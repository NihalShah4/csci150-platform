'use client';

import { useEffect, useRef, useState } from 'react';
import { supabaseBrowser } from '../../../lib/supabaseClient';
import LoadingFact from '../../../components/LoadingFact';

declare global {
  interface Window {
    loadPyodide: any;
  }
}

type Exercise = {
  id: string;
  sort_order: number;
  title: string;
  prompt: string;
  starter_code: string;
  is_bonus: boolean;
};

type Hint = { hint_level: number; hint_text: string };

function ExerciseCard({
  exercise,
  pyodideRef,
  pyodideReady,
  studentId,
  moduleSlug,
}: {
  exercise: Exercise;
  pyodideRef: React.MutableRefObject<any>;
  pyodideReady: boolean;
  studentId: string | null;
  moduleSlug: string;
}) {
  const [code, setCode] = useState(exercise.starter_code);
  const [output, setOutput] = useState('');
  const [running, setRunning] = useState(false);
  const [submitting, setSubmitting] = useState(false);
  const [submitMsg, setSubmitMsg] = useState<string | null>(null);
  const [locked, setLocked] = useState(false);
  const [needsRevision, setNeedsRevision] = useState(false);
  const [instructorNote, setInstructorNote] = useState<string | null>(null);
  const [statusChecked, setStatusChecked] = useState(false);
  const [pasteBlockedMsg, setPasteBlockedMsg] = useState(false);
  const [approachNote, setApproachNote] = useState('');
  const [hints, setHints] = useState<Hint[]>([]);
  const [revealedLevel, setRevealedLevel] = useState(0);
  const runCountRef = useRef(0);
  const pasteAttemptedRef = useRef(false);
  const startTimeRef = useRef<number>(Date.now());

  useEffect(() => {
    const supabase = supabaseBrowser();
    supabase
      .from('exercise_hints')
      .select('hint_level, hint_text')
      .eq('exercise_id', exercise.id)
      .order('hint_level', { ascending: true })
      .then(({ data }) => setHints((data as Hint[]) ?? []));

    if (!studentId || exercise.is_bonus) {
      setStatusChecked(true);
      return;
    }
    supabase
      .from('submissions')
      .select('code, status, instructor_notes')
      .eq('student_id', studentId)
      .eq('exercise_id', exercise.id)
      .order('created_at', { ascending: false })
      .limit(1)
      .maybeSingle()
      .then(({ data }) => {
        if (data?.status === 'approved') {
          setLocked(true);
          setCode(data.code);
        } else if (data?.status === 'needs_revision') {
          setNeedsRevision(true);
          setInstructorNote(data.instructor_notes ?? null);
        }
        setStatusChecked(true);
      });
  }, [studentId, exercise.id, exercise.is_bonus]);

  async function runCode() {
    runCountRef.current += 1;
    setRunning(true);
    setOutput('');
    try {
      const pyodide = pyodideRef.current;
      if (!pyodide) {
        setOutput('Python is still loading, try again in a second.');
        setRunning(false);
        return;
      }
      let captured = '';
      pyodide.setStdout({ batched: (s: string) => (captured += s + '\n') });
      pyodide.globals.set('input', (prompt?: string) => {
        captured += (prompt ?? '') + '(sample input)\n';
        return 'sample input';
      });
      await pyodide.runPythonAsync(code);
      setOutput(captured || '(no output)');
    } catch (err: any) {
      setOutput('Error:\n' + err.message);
    }
    setRunning(false);
  }

  async function submitWork() {
    if (!studentId) {
      setSubmitMsg('You must be signed in to submit.');
      return;
    }
    setSubmitting(true);
    setSubmitMsg(null);
    const supabase = supabaseBrowser();
    const { error } = await supabase.from('submissions').insert({
      student_id: studentId,
      module_slug: moduleSlug,
      exercise_id: exercise.id,
      code,
      approach_note: approachNote.trim() || null,
      status: 'pending',
      run_count: runCountRef.current,
      seconds_to_submit: Math.round((Date.now() - startTimeRef.current) / 1000),
      paste_attempted: pasteAttemptedRef.current,
    });
    setSubmitting(false);
    if (error) {
      setSubmitMsg(error.message);
      if (error.message.includes('already been approved')) setLocked(true);
    } else {
      setSubmitMsg('Submitted. Your instructor will review it.');
      setNeedsRevision(false);
      setInstructorNote(null);
      setApproachNote('');
    }
  }

  return (
    <div className="card" style={{ marginBottom: 22 }}>
      <div style={{ display: 'flex', justifyContent: 'space-between', alignItems: 'flex-start', marginBottom: 10 }}>
        <div>
          <div style={{ fontFamily: 'var(--font-mono)', fontSize: 12, color: 'var(--ink-soft)' }}>
            {exercise.is_bonus ? 'bonus' : `exercise ${exercise.sort_order}`}
          </div>
          <h3 style={{ margin: '2px 0 8px' }}>{exercise.title}</h3>
        </div>
        {exercise.is_bonus && <span className="badge locked"># ungraded, just for fun</span>}
        {statusChecked && locked && (
          <span className="status-chip complete">
            <span className="status-dot" /> approved
          </span>
        )}
      </div>
      <p style={{ color: 'var(--ink-soft)', marginTop: 0 }}>{exercise.prompt}</p>

      {statusChecked && needsRevision && (
        <div className="card locked" style={{ background: 'var(--danger-soft)', borderColor: 'var(--danger)' }}>
          <strong style={{ color: 'var(--danger)' }}>Needs another try</strong>
          <p style={{ margin: '6px 0 0', color: 'var(--ink)' }}>
            {instructorNote || 'Your instructor asked you to revise this one, no comment was left.'}
          </p>
        </div>
      )}

      <div className="term-window">
        <div className="term-header">
          <span className="term-dot red" />
          <span className="term-dot yellow" />
          <span className="term-dot green" />
          <span className="term-tab">exercise_{exercise.sort_order}.py</span>
        </div>
        <div className="term-body">
          <textarea
            className="editor"
            value={code}
            onChange={(e) => setCode(e.target.value)}
            onPaste={(e) => {
              if (locked) return;
              e.preventDefault();
              pasteAttemptedRef.current = true;
              setPasteBlockedMsg(true);
              setTimeout(() => setPasteBlockedMsg(false), 2500);
            }}
            spellCheck={false}
            readOnly={locked}
            style={{ minHeight: 140, ...(locked ? { opacity: 0.75, cursor: 'default' } : {}) }}
          />
        </div>
      </div>
      {pasteBlockedMsg && (
        <p style={{ color: 'var(--warn)', fontSize: 12.5, marginTop: 6 }}>
          Pasting is turned off here, type it out yourself.
        </p>
      )}

      {!pyodideReady && (
        <div style={{ marginTop: 8 }}>
          <LoadingFact />
        </div>
      )}

      <div style={{ display: 'flex', gap: 10, margin: '12px 0', flexWrap: 'wrap' }}>
        <button className="btn" onClick={runCode} disabled={running}>
          {running ? 'Running...' : 'Run'}
        </button>
        {!locked && !exercise.is_bonus && (
          <button
            className="btn"
            onClick={submitWork}
            disabled={submitting}
            style={{ background: 'var(--accent-dark)' }}
          >
            {submitting ? 'Submitting...' : 'Submit'}
          </button>
        )}
        {hints.length > 0 && !locked && (
          <button
            className="btn ghost"
            onClick={() => setRevealedLevel((l) => Math.min(l + 1, hints.length))}
            disabled={revealedLevel >= hints.length}
          >
            {revealedLevel === 0
              ? 'Give me a hint'
              : revealedLevel >= hints.length
              ? 'No more hints'
              : 'Another hint'}
          </button>
        )}
      </div>

      {revealedLevel > 0 && (
        <div className="card locked" style={{ marginBottom: 12 }}>
          {hints.slice(0, revealedLevel).map((h) => (
            <p key={h.hint_level} style={{ margin: '4px 0', color: 'var(--ink)' }}>
              <strong>Hint {h.hint_level}:</strong> {h.hint_text}
            </p>
          ))}
        </div>
      )}

      {!locked && !exercise.is_bonus && (
        <div style={{ marginBottom: 12 }}>
          <label style={{ fontSize: 12.5, color: 'var(--ink-soft)', fontFamily: 'var(--font-mono)' }}>
            Before you submit: what was your approach? (optional)
          </label>
          <textarea
            className="editor"
            value={approachNote}
            onChange={(e) => setApproachNote(e.target.value)}
            placeholder="One or two sentences on how you solved it..."
            style={{
              minHeight: 60,
              color: 'var(--ink)',
              background: 'var(--surface)',
              border: '1px solid var(--border)',
              marginTop: 4,
            }}
          />
        </div>
      )}

      {output && (
        <div className="term-window">
          <div className="term-header">
            <span className="term-dot red" />
            <span className="term-dot yellow" />
            <span className="term-dot green" />
            <span className="term-tab">output</span>
          </div>
          <div className="term-body">
            <div className="output">
              {output}
              <span className="cursor" />
            </div>
          </div>
        </div>
      )}
      {submitMsg && (
        <p style={{ color: 'var(--warn)', marginTop: 10, fontFamily: 'var(--font-mono)', fontSize: 13 }}>
          {submitMsg}
        </p>
      )}
    </div>
  );
}

export default function ModulePage({ params }: { params: { slug: string } }) {
  const [checked, setChecked] = useState(false);
  const [allowed, setAllowed] = useState(false);
  const [exercises, setExercises] = useState<Exercise[]>([]);
  const [studentId, setStudentId] = useState<string | null>(null);
  const [pyodideReady, setPyodideReady] = useState(false);
  const pyodideRef = useRef<any>(null);

  useEffect(() => {
    const supabase = supabaseBrowser();

    async function load() {
      const { data: moduleRow } = await supabase
        .from('modules')
        .select('unlocked')
        .eq('slug', params.slug)
        .single();
      setAllowed(!!moduleRow?.unlocked);

      const { data: userData } = await supabase.auth.getUser();
      setStudentId(userData.user?.id ?? null);

      const { data: exData } = await supabase
        .from('exercises')
        .select('*')
        .eq('module_slug', params.slug)
        .order('sort_order', { ascending: true });
      setExercises((exData as Exercise[]) ?? []);

      setChecked(true);
    }
    load();
  }, [params.slug]);

  useEffect(() => {
    const script = document.createElement('script');
    script.src = 'https://cdn.jsdelivr.net/pyodide/v0.26.2/full/pyodide.js';
    script.onload = async () => {
      pyodideRef.current = await window.loadPyodide();
      setPyodideReady(true);
    };
    document.body.appendChild(script);
  }, []);

  const coreExercises = exercises.filter((e) => !e.is_bonus);
  const bonusExercises = exercises.filter((e) => e.is_bonus);

  return (
    <div className="container">
      <a href="/modules" className="navlink" style={{ fontFamily: 'var(--font-mono)', fontSize: 13 }}>
        &larr; modules/
      </a>
      <h1 style={{ textTransform: 'capitalize', marginTop: 8 }}>{params.slug.replace(/-/g, ' ')}</h1>

      {!checked && <p>Checking access...</p>}

      {checked && !allowed && (
        <div className="card locked">
          <p>This module is locked. Your instructor hasn't unlocked it yet.</p>
        </div>
      )}

      {checked && allowed && exercises.length === 0 && (
        <div className="card">
          <p style={{ color: 'var(--ink-soft)' }}>
            No exercises published for this module yet, check back soon.
          </p>
        </div>
      )}

      {checked &&
        allowed &&
        coreExercises.map((ex) => (
          <ExerciseCard
            key={ex.id}
            exercise={ex}
            pyodideRef={pyodideRef}
            pyodideReady={pyodideReady}
            studentId={studentId}
            moduleSlug={params.slug}
          />
        ))}

      {checked && allowed && bonusExercises.length > 0 && (
        <>
          <div className="eyebrow" style={{ marginTop: 8 }}>
            just for fun
          </div>
          {bonusExercises.map((ex) => (
            <ExerciseCard
              key={ex.id}
              exercise={ex}
              pyodideRef={pyodideRef}
              pyodideReady={pyodideReady}
              studentId={studentId}
              moduleSlug={params.slug}
            />
          ))}
        </>
      )}
    </div>
  );
}
