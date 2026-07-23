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
  const pyodideRef = useRef<any>(null);

  useEffect(() => {
    const supabase = supabaseBrowser();
    supabase
      .from('modules')
      .select('unlocked')
      .eq('slug', params.slug)
      .single()
      .then(({ data }) => {
        setAllowed(!!data?.unlocked);
        setChecked(true);
      });
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
    });
    setSubmitting(false);
    setSubmitMsg(error ? error.message : 'Submitted. Your instructor will review it.');
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
          <p style={{ color: 'var(--ink-soft)' }}>
            Write your code below, run it to check the output, then submit when ready.
          </p>

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
                spellCheck={false}
              />
            </div>
          </div>

          <div style={{ display: 'flex', gap: 10, margin: '14px 0' }}>
            <button className="btn" onClick={runCode} disabled={running}>
              {running ? 'Running...' : 'Run'}
            </button>
            <button
              className="btn"
              onClick={submitWork}
              disabled={submitting}
              style={{ background: 'var(--accent-dark)' }}
            >
              {submitting ? 'Submitting...' : 'Submit'}
            </button>
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
