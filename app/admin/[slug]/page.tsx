'use client';

import { useEffect, useState } from 'react';
import { supabaseBrowser, isAdminEmail } from '../../../lib/supabaseClient';

type Exercise = {
  id: string;
  sort_order: number;
  title: string;
  prompt: string;
};

type Submission = {
  id: string;
  student_id: string;
  student_email: string;
  exercise_id: string | null;
  code: string;
  status: string;
  instructor_notes: string | null;
  approach_note: string | null;
  run_count: number | null;
  seconds_to_submit: number | null;
  paste_attempted: boolean | null;
  created_at: string;
};

export default function AdminModulePage({ params }: { params: { slug: string } }) {
  const [authorized, setAuthorized] = useState<boolean | null>(null);
  const [loading, setLoading] = useState(true);
  const [loadError, setLoadError] = useState<string | null>(null);
  const [exercises, setExercises] = useState<Exercise[]>([]);
  const [answerKeys, setAnswerKeys] = useState<Record<string, string>>({});
  const [latestByExercise, setLatestByExercise] = useState<Record<string, Submission[]>>({});
  const [busyId, setBusyId] = useState<string | null>(null);
  const [rejectingId, setRejectingId] = useState<string | null>(null);
  const [rejectNote, setRejectNote] = useState('');
  const [openAnswerKey, setOpenAnswerKey] = useState<Record<string, boolean>>({});

  async function loadEverything() {
    const supabase = supabaseBrowser();

    const { data: exData } = await supabase
      .from('exercises')
      .select('id, sort_order, title, prompt, is_bonus')
      .eq('module_slug', params.slug)
      .eq('is_bonus', false)
      .order('sort_order', { ascending: true });
    setExercises((exData as Exercise[]) ?? []);

    const { data: answerData } = await supabase.from('exercise_answers').select('exercise_id, answer_key');
    const keyMap: Record<string, string> = {};
    (answerData ?? []).forEach((a: any) => {
      keyMap[a.exercise_id] = a.answer_key;
    });
    setAnswerKeys(keyMap);

    const { data: subData, error: subErr } = await supabase.rpc('get_all_submissions');
    if (subErr) {
      setLoadError(subErr.message);
    } else {
      setLoadError(null);
      const relevant = (subData as Submission[]).filter((s: any) => {
        const ex = (exData ?? []).find((e: any) => e.id === s.exercise_id);
        return !!ex;
      });
      // reduce to latest submission per (student, exercise)
      const latestMap: Record<string, Submission> = {};
      relevant.forEach((s) => {
        const key = s.student_id + '::' + s.exercise_id;
        const existing = latestMap[key];
        if (!existing || new Date(s.created_at) > new Date(existing.created_at)) {
          latestMap[key] = s;
        }
      });
      const grouped: Record<string, Submission[]> = {};
      Object.values(latestMap).forEach((s) => {
        const exId = s.exercise_id ?? 'unknown';
        if (!grouped[exId]) grouped[exId] = [];
        grouped[exId].push(s);
      });
      setLatestByExercise(grouped);
    }

    setLoading(false);
  }

  useEffect(() => {
    const supabase = supabaseBrowser();
    supabase.auth.getUser().then(({ data }) => {
      const ok = isAdminEmail(data.user?.email);
      setAuthorized(ok);
      if (!ok) {
        window.location.href = '/modules';
        return;
      }
      loadEverything();
    });
  }, [params.slug]);

  async function approve(id: string) {
    setBusyId(id);
    const supabase = supabaseBrowser();
    await supabase.from('submissions').update({ status: 'approved' }).eq('id', id);
    await loadEverything();
    setBusyId(null);
  }

  function startReject(id: string) {
    setRejectingId(id);
    setRejectNote('');
  }

  async function confirmReject(id: string) {
    if (!rejectNote.trim()) return;
    setBusyId(id);
    const supabase = supabaseBrowser();
    await supabase
      .from('submissions')
      .update({ status: 'needs_revision', instructor_notes: rejectNote.trim() })
      .eq('id', id);
    setRejectingId(null);
    setRejectNote('');
    await loadEverything();
    setBusyId(null);
  }

  if (authorized === null) return <div className="container">Checking access...</div>;
  if (authorized === false) return null;

  return (
    <div className="container">
      <a href="/admin" className="navlink" style={{ fontFamily: 'var(--font-mono)', fontSize: 13 }}>
        &larr; admin/
      </a>
      <h1 style={{ textTransform: 'capitalize', marginTop: 8 }}>{params.slug.replace(/-/g, ' ')}</h1>

      {loading && <p>Loading...</p>}
      {loadError && (
        <div className="card locked">
          <strong>Couldn't load submissions:</strong> {loadError}
        </div>
      )}

      {!loading &&
        exercises.map((ex) => {
          const submissions = latestByExercise[ex.id] ?? [];
          return (
            <div key={ex.id} className="card">
              <div style={{ fontFamily: 'var(--font-mono)', fontSize: 12, color: 'var(--ink-soft)' }}>
                exercise {ex.sort_order}
              </div>
              <h3 style={{ margin: '2px 0 8px' }}>{ex.title}</h3>
              <p style={{ color: 'var(--ink-soft)' }}>{ex.prompt}</p>

              <button
                className="btn ghost"
                style={{ fontSize: 12, marginBottom: 10 }}
                onClick={() => setOpenAnswerKey((prev) => ({ ...prev, [ex.id]: !prev[ex.id] }))}
              >
                {openAnswerKey[ex.id] ? 'Hide answer key' : 'Show answer key'}
              </button>
              {openAnswerKey[ex.id] && (
                <div className="term-window" style={{ marginBottom: 14 }}>
                  <div className="term-header">
                    <span className="term-dot red" />
                    <span className="term-dot yellow" />
                    <span className="term-dot green" />
                    <span className="term-tab">answer_key.py</span>
                  </div>
                  <div className="term-body">
                    <pre style={{ margin: 0, color: 'var(--term-ink)', fontFamily: 'var(--font-mono)', fontSize: 13, whiteSpace: 'pre-wrap' }}>
                      {answerKeys[ex.id] ?? '(no answer key on file)'}
                    </pre>
                  </div>
                </div>
              )}

              {submissions.length === 0 && (
                <p style={{ color: 'var(--ink-soft)', fontSize: 13.5 }}>No submissions yet.</p>
              )}

              {submissions.map((s) => (
                <div key={s.id} style={{ borderTop: '1px solid var(--border)', paddingTop: 12, marginTop: 12 }}>
                  <div style={{ display: 'flex', justifyContent: 'space-between' }}>
                    <span style={{ fontFamily: 'var(--font-mono)', fontSize: 13 }}>{s.student_email}</span>
                    <span className={`badge ${s.status === 'approved' ? 'done' : s.status === 'needs_revision' ? 'danger' : ''}`}>
                      {s.status}
                    </span>
                  </div>
                  <div style={{ display: 'flex', gap: 6, flexWrap: 'wrap', margin: '6px 0' }}>
                    <span className="badge">{s.run_count ?? 0} runs</span>
                    <span className="badge">{s.seconds_to_submit != null ? `${s.seconds_to_submit}s` : '?'}</span>
                    {s.paste_attempted && <span className="badge locked"># tried to paste</span>}
                  </div>
                  <div className="term-window">
                    <div className="term-header">
                      <span className="term-dot red" />
                      <span className="term-dot yellow" />
                      <span className="term-dot green" />
                    </div>
                    <div className="term-body">
                      <pre style={{ margin: 0, color: 'var(--term-ink)', fontFamily: 'var(--font-mono)', fontSize: 13, whiteSpace: 'pre-wrap' }}>
                        {s.code}
                      </pre>
                    </div>
                  </div>
                  {s.approach_note && (
                    <p style={{ fontSize: 13, color: 'var(--ink-soft)', marginTop: 6, fontStyle: 'italic' }}>
                      "{s.approach_note}"
                    </p>
                  )}

                  {s.status === 'pending' && (
                    <div style={{ marginTop: 8 }}>
                      {rejectingId === s.id ? (
                        <div>
                          <textarea
                            className="editor"
                            style={{ minHeight: 70, color: 'var(--ink)', background: 'var(--surface)', border: '1px solid var(--border)' }}
                            placeholder="What should they fix? This is shown to the student."
                            value={rejectNote}
                            onChange={(e) => setRejectNote(e.target.value)}
                          />
                          <div style={{ display: 'flex', gap: 8, marginTop: 8 }}>
                            <button
                              className="btn danger"
                              disabled={busyId === s.id || !rejectNote.trim()}
                              onClick={() => confirmReject(s.id)}
                            >
                              Send back with this comment
                            </button>
                            <button className="btn ghost" onClick={() => setRejectingId(null)}>
                              Cancel
                            </button>
                          </div>
                        </div>
                      ) : (
                        <div style={{ display: 'flex', gap: 8 }}>
                          <button className="btn" disabled={busyId === s.id} onClick={() => approve(s.id)}>
                            Approve
                          </button>
                          <button className="btn danger" disabled={busyId === s.id} onClick={() => startReject(s.id)}>
                            Needs revision
                          </button>
                        </div>
                      )}
                    </div>
                  )}

                  {s.status === 'needs_revision' && (
                    <p style={{ color: 'var(--warn)', fontSize: 13, marginTop: 8 }}>
                      Your note: {s.instructor_notes ?? '(no comment saved)'}
                    </p>
                  )}
                </div>
              ))}
            </div>
          );
        })}
    </div>
  );
}
