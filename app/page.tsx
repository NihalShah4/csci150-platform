'use client';

import { useEffect, useRef, useState } from 'react';
import { supabaseBrowser, isAllowedEmail, ALLOWED_EMAIL_DOMAIN } from '../lib/supabaseClient';

declare global {
  interface Window {
    loadPyodide: any;
  }
}

const SCRIPT = [
  { type: 'in', text: 'print("Hello, world.")' },
  { type: 'out', text: 'Hello, world.' },
  { type: 'in', text: 'name = "you"' },
  { type: 'in', text: 'print(f"Welcome to Pynt, {name}.")' },
  { type: 'out', text: 'Welcome to Pynt, you.' },
];

function TypingIntro() {
  const [lines, setLines] = useState<{ type: string; text: string }[]>([]);
  const [current, setCurrent] = useState('');

  useEffect(() => {
    let cancelled = false;
    async function run() {
      for (const line of SCRIPT) {
        if (cancelled) return;
        if (line.type === 'in') {
          for (let i = 1; i <= line.text.length; i++) {
            if (cancelled) return;
            setCurrent(line.text.slice(0, i));
            await new Promise((r) => setTimeout(r, 18));
          }
          await new Promise((r) => setTimeout(r, 250));
          setLines((prev) => [...prev, line]);
          setCurrent('');
        } else {
          await new Promise((r) => setTimeout(r, 350));
          setLines((prev) => [...prev, line]);
        }
      }
    }
    run();
    return () => {
      cancelled = true;
    };
  }, []);

  return (
    <div className="term-window" style={{ maxWidth: 460 }}>
      <div className="term-header">
        <span className="term-dot red" />
        <span className="term-dot yellow" />
        <span className="term-dot green" />
        <span className="term-tab">week_01.py</span>
      </div>
      <div className="term-body">
        <div className="output">
          {lines.map((l, i) => (
            <div key={i}>
              {l.type === 'in' ? '>>> ' : ''}
              {l.text}
            </div>
          ))}
          {current && <div>&gt;&gt;&gt; {current}<span className="cursor" /></div>}
          {!current && lines.length === SCRIPT.length && <span className="cursor" />}
        </div>
      </div>
    </div>
  );
}

const PLAYGROUND_STARTER = `# No account needed -- just hit Run.
for i in range(1, 6):
    print("Line " + str(i) + ": you just ran real Python.")
`;

function LivePlayground() {
  const [code, setCode] = useState(PLAYGROUND_STARTER);
  const [output, setOutput] = useState('');
  const [running, setRunning] = useState(false);
  const [ready, setReady] = useState(false);
  const pyodideRef = useRef<any>(null);

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
        setOutput('Still warming up the Python engine, try again in a second.');
        setRunning(false);
        return;
      }
      let captured = '';
      pyodide.setStdout({ batched: (s: string) => (captured += s + '\n') });
      await pyodide.runPythonAsync(code);
      setOutput(captured || '(no output)');
    } catch (err: any) {
      setOutput('Error:\n' + err.message);
    }
    setRunning(false);
  }

  return (
    <div className="term-window">
      <div className="term-header">
        <span className="term-dot red" />
        <span className="term-dot yellow" />
        <span className="term-dot green" />
        <span className="term-tab">playground.py &middot; no account needed</span>
      </div>
      <div className="term-body">
        <textarea
          className="editor"
          value={code}
          onChange={(e) => setCode(e.target.value)}
          spellCheck={false}
          style={{ minHeight: 110 }}
        />
      </div>
      <div style={{ padding: '0 16px 16px' }}>
        <button className="btn" onClick={run} disabled={running}>
          {running ? 'Running...' : ready ? 'Run this code' : 'Loading Python...'}
        </button>
      </div>
      {output && (
        <div className="term-body" style={{ borderTop: '1px solid var(--term-border)' }}>
          <div className="output">
            {output}
            <span className="cursor" />
          </div>
        </div>
      )}
    </div>
  );
}

export default function Home() {
  const [mode, setMode] = useState<'signin' | 'signup'>('signin');
  const [email, setEmail] = useState('');
  const [password, setPassword] = useState('');
  const [message, setMessage] = useState<string | null>(null);
  const [loading, setLoading] = useState(false);

  async function handleSubmit(e: React.FormEvent) {
    e.preventDefault();
    setMessage(null);

    if (!isAllowedEmail(email)) {
      setMessage(`Please use your @${ALLOWED_EMAIL_DOMAIN} email address.`);
      return;
    }

    setLoading(true);
    const supabase = supabaseBrowser();

    if (mode === 'signup') {
      const { error } = await supabase.auth.signUp({
        email,
        password,
        options: { emailRedirectTo: `${window.location.origin}/modules` },
      });
      setLoading(false);
      if (error) setMessage(error.message);
      else setMessage('Check your email to verify your account, then sign in.');
    } else {
      const { error } = await supabase.auth.signInWithPassword({ email, password });
      setLoading(false);
      if (error) setMessage(error.message);
      else window.location.href = '/modules';
    }
  }

  return (
    <div>
      <div className="hero" style={{ paddingBottom: 24 }}>
        <div>
          <div className="eyebrow">pynt &middot; csci 150 &middot; python</div>
          <h1>Learn to code by actually writing code.</h1>
          <p className="lede">
            Nine modules, real Python running in your browser, and feedback from your instructor
            on every submission. No experience required.
          </p>
          <div style={{ marginTop: 28 }}>
            <TypingIntro />
          </div>
        </div>

        <div className="card" style={{ maxWidth: 380, justifySelf: 'end', width: '100%' }}>
          <div style={{ display: 'flex', gap: 8, marginBottom: 16 }}>
            <button
              className={mode === 'signin' ? 'btn' : 'btn ghost'}
              onClick={() => setMode('signin')}
              style={{ flex: 1 }}
            >
              Sign in
            </button>
            <button
              className={mode === 'signup' ? 'btn' : 'btn ghost'}
              onClick={() => setMode('signup')}
              style={{ flex: 1 }}
            >
              Register
            </button>
          </div>

          <form onSubmit={handleSubmit}>
            <input
              type="email"
              placeholder={`you@${ALLOWED_EMAIL_DOMAIN}`}
              value={email}
              onChange={(e) => setEmail(e.target.value)}
              required
            />
            <input
              type="password"
              placeholder="Password"
              value={password}
              onChange={(e) => setPassword(e.target.value)}
              required
              minLength={8}
            />
            <button className="btn" type="submit" disabled={loading} style={{ width: '100%' }}>
              {loading ? 'Please wait...' : mode === 'signup' ? 'Create account' : 'Sign in'}
            </button>
          </form>

          {message && (
            <p style={{ color: 'var(--warn)', marginTop: 12, fontSize: 13.5 }}>{message}</p>
          )}
        </div>
      </div>

      <div className="container" style={{ maxWidth: 700, paddingTop: 0 }}>
        <div className="eyebrow">try it &middot; no signup</div>
        <h2 style={{ marginTop: 0, marginBottom: 6 }}>Not sure if this is for you? Just run something.</h2>
        <p style={{ color: 'var(--ink-soft)', marginTop: 0, marginBottom: 20 }}>
          This is real Python, running right in your browser. Edit it, break it, fix it.
        </p>
        <LivePlayground />
      </div>
    </div>
  );
}
