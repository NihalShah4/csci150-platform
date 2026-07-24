'use client';

import { useEffect, useRef, useState } from 'react';
import { supabaseBrowser } from '../../../lib/supabaseClient';

declare global {
  interface Window {
    loadPyodide: any;
  }
}

const STARTER_CODE = `# Try it: print a greeting using an input value
name = input("What's your name? ")
print("Hello, " + name + "! Welcome to CSCI 150.")
`;

export default function ModulePage({ params }: { params: { slug: string } }) {
  const [code, setCode] = useState(STARTER_CODE);
  const [output, setOutput] = useState('');
  const [running, setRunning] = useState(false);
  const [submitting, setSubmitting] = useState(false);
  const [submitMsg, setSubmitMsg] = useState<string | null>(null);
  const [checked, setChecked] = useState(false);
  const [allowed, setAllowed] = useState(false);
  const [locked, setLocked] = useState(false);
  const [pasteBlockedMsg, setPasteBlockedMsg] = useState(false);
  const pyodideRef = useRef<any>(null);
  const runCountRef = useRef(0);
  const pasteAttemptedRef = useRef(false);
  const startTimeRef = useRef<number>(Date.now());

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
      if (userData.user) {
        const { data: latest } = await supabase
          .from('submissions')
          .select('code, status')
          .eq('student_id', userData.user.id)
          .eq('module_slug', params.slug)
          .order('created_at', { ascending: false })
          .limit(1)
          .maybeSingle();

        if (latest?.status === 'approved') {
          setLocked(true);
          setCode(latest.code);
        }
      }

      setChecked(true);
    }
    load();
  }, [params.slug]);

  useEffect(() => {
    const script = document.createElement('script');
    script.src = 'https://cdn.jsdelivr.net/pyodide/v0.26.2/full/pyodide.js';
    script.onload = async () => {
      pyodideRef.current = await window.loadPyodide();
    };
    document.body.appendChild(script);
  }, []);

  async function runCode() {
    runCountRef.current += 1;
    setRunning(true);
    setOutput('');
    try {
      const pyodide = pyodideRef.current;
      if (!pyodide) {
        setOutput('Python is still loading, try again in a few seconds.');
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
    setSubmitting(true);
    setSubmitMsg(null);
    const supabase = supabaseBrowser();
    const { data: userData } = await supabase.auth.getUser();
    if (!userData.user) {
      setSubmitMsg('You must be signed in to submit.');
      setSubmitting(false);
      return;
    }
    const { error } = await supabase.from('submissions').insert({
      student_id: userData.user.id,
      module_slug: params.slug,
      code,
      status: 'pending',
      run_count: runCountRef.current,
      seconds_to_submit: Math.round((Date.now() - startTimeRef.current) / 1000),
      paste_attempted: pasteAttemptedRef.current,
    });
    setSubmitting(false);
    if (error) {
      setSubmitMsg(error.message.includes('already been approved') ? error.message : error.message);
      if (error.message.includes('already been approved')) setLocked(true);
    } else {
      setSubmitMsg('Submitted. Your instructor will review it.');
    }
  }

  const filename = params.slug.replace(/-/g, '_') + '.py';

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

      {checked && allowed && (
        <>
          {locked ? (
            <div className="card" style={{ marginBottom: 16 }}>
              <span className="status-chip complete">
                <span className="status-dot" /> approved
              </span>
              <p style={{ color: 'var(--ink-soft)', marginTop: 10 }}>
                This one's locked in. Your instructor already approved it, so it can't be changed
                or resubmitted. Nice work.
              </p>
            </div>
          ) : (
            <p style={{ color: 'var(--ink-soft)' }}>
              Write your code below, run it to check the output, then submit when ready.
            </p>
          )}

          <div className="term-window">
            <div className="term-header">
              <span className="term-dot red" />
              <span className="term-dot yellow" />
              <span className="term-dot green" />
              <span className="term-tab">{filename}</span>
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
                style={locked ? { opacity: 0.75, cursor: 'default' } : undefined}
              />
              {pasteBlockedMsg && (
                <p style={{ color: 'var(--warn)', fontSize: 12.5, marginTop: 6 }}>
                  Pasting is turned off here, type it out yourself so it actually sinks in.
                </p>
              )}
            </div>
          </div>

          <div style={{ display: 'flex', gap: 10, margin: '14px 0' }}>
            <button className="btn" onClick={runCode} disabled={running}>
              {running ? 'Running...' : 'Run'}
            </button>
            {!locked && (
              <button
                className="btn"
                onClick={submitWork}
                disabled={submitting}
                style={{ background: 'var(--accent-dark)' }}
              >
                {submitting ? 'Submitting...' : 'Submit'}
              </button>
            )}
          </div>

          <div className="term-window">
            <div className="term-header">
              <span className="term-dot red" />
              <span className="term-dot yellow" />
              <span className="term-dot green" />
              <span className="term-tab">output</span>
            </div>
            <div className="term-body">
              <div className="output">
                {output || 'Click "Run" to see output here.'}
                {output && <span className="cursor" />}
              </div>
            </div>
          </div>

          {submitMsg && (
            <p style={{ color: 'var(--warn)', marginTop: 12, fontFamily: 'var(--font-mono)', fontSize: 13 }}>
              {submitMsg}
            </p>
          )}
        </>
      )}
    </div>
  );
}
