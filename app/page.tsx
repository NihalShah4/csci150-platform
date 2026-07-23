'use client';

import { useEffect, useState } from 'react';
import { supabaseBrowser, isAllowedEmail, ALLOWED_EMAIL_DOMAIN } from '../lib/supabaseClient';

const SCRIPT = [
  { type: 'in', text: 'print("Hello, world.")' },
  { type: 'out', text: 'Hello, world.' },
  { type: 'in', text: 'name = "you"' },
  { type: 'in', text: 'print(f"Welcome to CSCI 150, {name}.")' },
  { type: 'out', text: 'Welcome to CSCI 150, you.' },
];

function TypingHero() {
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
    <div className="hero">
      <div>
        <div className="eyebrow">CSCI 150 &middot; python</div>
        <h1>Learn to code by actually writing code.</h1>
        <p className="lede">
          Nine modules, real Python running in your browser, and feedback from your instructor
          on every submission. No experience required.
        </p>
        <div style={{ marginTop: 28 }}>
          <TypingHero />
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
  );
}
