'use client';

import { useState } from 'react';
import { supabaseBrowser, isAllowedEmail, ALLOWED_EMAIL_DOMAIN } from '../lib/supabaseClient';

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
    <div className="container" style={{ maxWidth: 420 }}>
      <h1>CSCI 150</h1>
      <p style={{ color: '#9aa1b2' }}>Intro to Computer Science and Programming (Python)</p>

      <div className="card">
        <div style={{ display: 'flex', gap: 8, marginBottom: 14 }}>
          <button
            className="btn"
            style={{ background: mode === 'signin' ? '#4f7cff' : '#262b38' }}
            onClick={() => setMode('signin')}
          >
            Sign in
          </button>
          <button
            className="btn"
            style={{ background: mode === 'signup' ? '#4f7cff' : '#262b38' }}
            onClick={() => setMode('signup')}
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

        {message && <p style={{ color: '#e8b84f', marginTop: 12 }}>{message}</p>}
      </div>
    </div>
  );
}
