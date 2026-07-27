'use client';

import { useEffect, useRef, useState } from 'react';
import { supabaseBrowser } from '../../lib/supabaseClient';
import LoadingFact from '../../components/LoadingFact';

declare global {
  interface Window {
    loadPyodide: any;
  }
}

const STARTER = `# This is your scratchpad. Nothing here is graded or saved.
# Try anything you want.

for i in range(1, 4):
    print("Experiment", i)
`;

export default function PlaygroundPage() {
  const [code, setCode] = useState(STARTER);
  const [output, setOutput] = useState('');
  const [running, setRunning] = useState(false);
  const [ready, setReady] = useState(false);
  const [checked, setChecked] = useState(false);
  const pyodideRef = useRef<any>(null);

  useEffect(() => {
    const supabase = supabaseBrowser();
    supabase.auth.getUser().then(({ data }) => {
      if (!data.user) {
        window.location.href = '/';
        return;
      }
      setChecked(true);
    });
  }, []);

  useEffect(() => {
    const script = document.createElement('script');
    script.src = 'https://cdn.jsdelivr.net/pyodide/v0.26.2/full/pyodide.js';
    script.onload = async () => {
      pyodideRef.current = await window.loadPyodide();
      setReady(true);
    };
    document.body.appendChild(script);
  }, []);

  async function run() {
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

  if (!checked) return <div className="container">Checking access...</div>;

  return (
    <div className="container">
      <div className="eyebrow">no grading &middot; no pressure</div>
      <h1 style={{ marginTop: 0 }}>Scratchpad</h1>
      <p style={{ color: 'var(--ink-soft)' }}>
        A free space to try things out. Nothing you write here gets submitted or saved, it resets
        when you leave the page. Break things on purpose, see what happens.
      </p>

      <div className="term-window">
        <div className="term-header">
          <span className="term-dot red" />
          <span className="term-dot yellow" />
          <span className="term-dot green" />
          <span className="term-tab">scratch.py</span>
        </div>
        <div className="term-body">
          <textarea
            className="editor"
            value={code}
            onChange={(e) => setCode(e.target.value)}
            spellCheck={false}
            style={{ minHeight: 220 }}
          />
        </div>
      </div>

      <div style={{ display: 'flex', gap: 10, margin: '14px 0' }}>
        <button className="btn" onClick={run} disabled={running}>
          {running ? 'Running...' : ready ? 'Run' : 'Loading Python...'}
        </button>
      </div>
      {!ready && <LoadingFact />}

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
    </div>
  );
}
