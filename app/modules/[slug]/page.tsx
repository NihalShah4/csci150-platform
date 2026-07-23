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
  const [output, setOutput] = useState('Click "Run" to see output here.');
  const [running, setRunning] = useState(false);
  const [submitting, setSubmitting] = useState(false);
  const [submitMsg, setSubmitMsg] = useState<string | null>(null);
  const pyodideRef = useRef<any>(null);

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
    setOutput('Running...');
    try {
      const pyodide = pyodideRef.current;
      if (!pyodide) {
        setOutput('Python is still loading, try again in a few seconds.');
        setRunning(false);
        return;
      }
      let captured = '';
      pyodide.setStdout({ batched: (s: string) => (captured += s + '\n') });
      // input() has no meaning in a headless runner; stub it so code doesn't hang.
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
    setSubmitMsg(error ? error.message : 'Submitted! Your instructor will review it.');
  }

  return (
    <div className="container">
      <a href="/modules" style={{ color: '#9aa1b2', fontSize: 13 }}>
        &larr; Back to modules
      </a>
      <h1 style={{ textTransform: 'capitalize' }}>{params.slug.replace(/-/g, ' ')}</h1>

      <div className="card">
        <p>Write your code below, run it to check the output, then submit when ready.</p>
        <textarea
          className="editor"
          value={code}
          onChange={(e) => setCode(e.target.value)}
          spellCheck={false}
        />
        <div style={{ display: 'flex', gap: 10, margin: '10px 0' }}>
          <button className="btn" onClick={runCode} disabled={running}>
            {running ? 'Running...' : 'Run'}
          </button>
          <button className="btn" onClick={submitWork} disabled={submitting} style={{ background: '#2e9e5b' }}>
            {submitting ? 'Submitting...' : 'Submit'}
          </button>
        </div>
        <div className="output">{output}</div>
        {submitMsg && <p style={{ color: '#e8b84f' }}>{submitMsg}</p>}
      </div>
    </div>
  );
}
