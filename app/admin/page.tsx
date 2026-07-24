'use client';

import { useEffect, useState } from 'react';
import { supabaseBrowser, isAdminEmail } from '../../lib/supabaseClient';

type Submission = {
  id: string;
  student_id: string;
  student_email: string;
  module_slug: string;
  code: string;
  status: string;
  created_at: string;
};

type ModuleRow = {
  slug: string;
  title: string;
  sort_order: number;
  unlocked: boolean;
};

export default function AdminPage() {
  const [submissions, setSubmissions] = useState<Submission[]>([]);
  const [modules, setModules] = useState<ModuleRow[]>([]);
  const [roster, setRoster] = useState<string[]>([]);
  const [newEmail, setNewEmail] = useState('');
  const [rosterMsg, setRosterMsg] = useState<string | null>(null);
  const [loading, setLoading] = useState(true);
  const [authorized, setAuthorized] = useState<boolean | null>(null);
  const [busyId, setBusyId] = useState<string | null>(null);
  const [loadError, setLoadError] = useState<string | null>(null);

  async function loadEverything() {
    const supabase = supabaseBrowser();

    const { data: subData, error: subErr } = await supabase.rpc('get_all_submissions');
    if (subErr) {
      setLoadError(subErr.message);
    } else {
      setLoadError(null);
      setSubmissions((subData as Submission[]) ?? []);
    }

    const { data: modData } = await supabase
      .from('modules')
      .select('*')
      .order('sort_order', { ascending: true });
    setModules((modData as ModuleRow[]) ?? []);

    const { data: rosterData } = await supabase
      .from('allowed_students')
      .select('email')
      .order('added_at', { ascending: true });
    setRoster((rosterData ?? []).map((r: any) => r.email));

    setLoading(false);
  }

  async function addToRoster(e: React.FormEvent) {
    e.preventDefault();
    setRosterMsg(null);
    const email = newEmail.trim().toLowerCase();
    if (!email) return;
    const supabase = supabaseBrowser();
    const { error } = await supabase.from('allowed_students').insert({ email });
    if (error) {
      setRosterMsg(error.message);
    } else {
      setNewEmail('');
      await loadEverything();
    }
  }

  async function removeFromRoster(email: string) {
    const supabase = supabaseBrowser();
    await supabase.from('allowed_students').delete().eq('email', email);
    await loadEverything();
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
  }, []);

  async function setStatus(id: string, status: string) {
    setBusyId(id);
    const supabase = supabaseBrowser();
    await supabase.from('submissions').update({ status }).eq('id', id);
    await loadEverything();
    setBusyId(null);
  }

  async function toggleModule(slug: string, current: boolean) {
    const supabase = supabaseBrowser();
    await supabase.from('modules').update({ unlocked: !current }).eq('slug', slug);
    await loadEverything();
  }

  if (authorized === null) return <div className="container">Checking access...</div>;
  if (authorized === false) return null;

  const pending = submissions.filter((s) => s.status === 'pending');
  const reviewed = submissions.filter((s) => s.status !== 'pending');

  return (
    <div className="container">
      <div className="eyebrow">instructor</div>
      <h1 style={{ marginTop: 0 }}>Dashboard</h1>

      <h2 style={{ fontSize: 17, marginTop: 28, fontFamily: 'var(--font-display)' }}>
        Class roster ({roster.length})
      </h2>
      <p style={{ color: 'var(--ink-soft)', fontSize: 13.5, marginTop: -6 }}>
        Only these emails can register. Add every enrolled student before class starts.
      </p>
      <div className="card">
        <form onSubmit={addToRoster} style={{ display: 'flex', gap: 8, marginBottom: roster.length ? 16 : 0 }}>
          <input
            type="email"
            placeholder="student@drew.edu"
            value={newEmail}
            onChange={(e) => setNewEmail(e.target.value)}
            style={{ marginBottom: 0 }}
          />
          <button className="btn" type="submit" style={{ whiteSpace: 'nowrap' }}>
            Add student
          </button>
        </form>
        {rosterMsg && <p style={{ color: 'var(--danger)', fontSize: 13 }}>{rosterMsg}</p>}
        {roster.map((email) => (
          <div
            key={email}
            style={{
              display: 'flex',
              justifyContent: 'space-between',
              alignItems: 'center',
              padding: '8px 0',
              borderTop: '1px solid var(--border)',
              fontFamily: 'var(--font-mono)',
              fontSize: 13,
            }}
          >
            {email}
            <button className="btn ghost" onClick={() => removeFromRoster(email)} style={{ padding: '4px 10px', fontSize: 12 }}>
              Remove
            </button>
          </div>
        ))}
      </div>

      <h2 style={{ fontSize: 17, marginTop: 28, fontFamily: 'var(--font-display)' }}>Module access</h2>
      <p style={{ color: 'var(--ink-soft)', fontSize: 13.5, marginTop: -6 }}>
        Unlock a module once you've taught that week's material. Applies to the whole class at once.
      </p>
      {modules.map((m) => (
        <div
          key={m.slug}
          className="card"
          style={{ display: 'flex', justifyContent: 'space-between', alignItems: 'center' }}
        >
          <div>
            <span style={{ fontFamily: 'var(--font-mono)', color: 'var(--ink-soft)', marginRight: 8 }}>
              {String(m.sort_order).padStart(2, '0')}
            </span>
            {m.title}
            {m.unlocked ? <span className="badge done"># unlocked</span> : <span className="badge locked"># locked</span>}
          </div>
          <button className="btn ghost" onClick={() => toggleModule(m.slug, m.unlocked)}>
            {m.unlocked ? 'Lock' : 'Unlock'}
          </button>
        </div>
      ))}

      <h2 style={{ fontSize: 17, marginTop: 32, fontFamily: 'var(--font-display)' }}>
        Pending ({pending.length})
      </h2>
      {loading && <p>Loading...</p>}
      {loadError && (
        <div className="card locked">
          <strong>Couldn't load submissions:</strong> {loadError}
          <p style={{ fontSize: 13, marginTop: 6 }}>
            This usually means the <code>get_all_submissions()</code> function hasn't been run in the
            Supabase SQL Editor yet.
          </p>
        </div>
      )}

      {pending.map((s) => (
        <div key={s.id} className="card">
          <div style={{ display: 'flex', justifyContent: 'space-between' }}>
            <strong style={{ fontFamily: 'var(--font-mono)', fontSize: 14 }}>{s.module_slug}</strong>
            <span className="badge">{s.status}</span>
          </div>
          <p style={{ fontSize: 12.5, color: 'var(--ink-soft)', fontFamily: 'var(--font-mono)' }}>
            {s.student_email} &middot; {new Date(s.created_at).toLocaleString()}
          </p>
          <div className="term-window">
            <div className="term-header">
              <span className="term-dot red" />
              <span className="term-dot yellow" />
              <span className="term-dot green" />
            </div>
            <div className="term-body">
              <pre
                style={{
                  margin: 0,
                  color: 'var(--term-ink)',
                  fontFamily: 'var(--font-mono)',
                  fontSize: 13,
                  whiteSpace: 'pre-wrap',
                }}
              >
                {s.code}
              </pre>
            </div>
          </div>
          <div style={{ display: 'flex', gap: 8, marginTop: 10 }}>
            <button className="btn" disabled={busyId === s.id} onClick={() => setStatus(s.id, 'approved')}>
              Approve
            </button>
            <button
              className="btn danger"
              disabled={busyId === s.id}
              onClick={() => setStatus(s.id, 'needs_revision')}
            >
              Needs revision
            </button>
          </div>
        </div>
      ))}

      {!loading && !loadError && pending.length === 0 && (
        <p style={{ color: 'var(--ink-soft)' }}>No pending submissions.</p>
      )}

      {reviewed.length > 0 && (
        <>
          <h2 style={{ fontSize: 17, marginTop: 32, fontFamily: 'var(--font-display)' }}>
            Reviewed ({reviewed.length})
          </h2>
          {reviewed.map((s) => (
            <div key={s.id} className="card" style={{ display: 'flex', justifyContent: 'space-between' }}>
              <div>
                <strong style={{ fontFamily: 'var(--font-mono)', fontSize: 13 }}>{s.module_slug}</strong>
                <div style={{ fontSize: 12, color: 'var(--ink-soft)', fontFamily: 'var(--font-mono)' }}>
                  {s.student_email}
                </div>
              </div>
              <span className={`badge ${s.status === 'approved' ? 'done' : 'danger'}`}>{s.status}</span>
            </div>
          ))}
        </>
      )}
    </div>
  );
}
