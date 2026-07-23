'use client';

import { useEffect, useState } from 'react';
import { supabaseBrowser, isAdminEmail } from '../lib/supabaseClient';

export default function NavBar() {
  const [email, setEmail] = useState<string | null>(null);

  useEffect(() => {
    const supabase = supabaseBrowser();
    supabase.auth.getUser().then(({ data }) => setEmail(data.user?.email ?? null));
    const { data: sub } = supabase.auth.onAuthStateChange((_event, session) => {
      setEmail(session?.user?.email ?? null);
    });
    return () => sub.subscription.unsubscribe();
  }, []);

  if (!email) return null;

  async function signOut() {
    const supabase = supabaseBrowser();
    await supabase.auth.signOut();
    window.location.href = '/';
  }

  return (
    <div className="navbar">
      <div className="links">
        <strong>CSCI 150</strong>
        <a href="/modules">Modules</a>
        {isAdminEmail(email) && <a href="/admin">Admin</a>}
      </div>
      <div>
        <span className="email">{email}</span>
        <button className="btn" onClick={signOut} style={{ background: '#eef0f4', color: '#1c2029' }}>
          Sign out
        </button>
      </div>
    </div>
  );
}
