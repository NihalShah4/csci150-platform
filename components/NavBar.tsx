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
      <div className="row">
        <div className="brand">
          <span className="dot" />
          CSCI 150
        </div>
        <div className="links">
          <a className="navlink" href="/modules">modules/</a>
          {isAdminEmail(email) && <a className="navlink" href="/admin">admin/</a>}
        </div>
      </div>
      <div className="row">
        <span className="email">{email}</span>
        <button className="btn ghost" onClick={signOut}>
          sign out
        </button>
      </div>
    </div>
  );
}
