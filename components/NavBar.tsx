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
          <img src="/pynt-logo.png" alt="Pynt" style={{ width: 22, height: 22, borderRadius: 6 }} />
          Pynt
        </div>
        <div className="links">
          <a className="navlink" href="/modules">modules/</a>
          <a className="navlink" href="/playground">playground/</a>
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
