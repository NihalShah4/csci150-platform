'use client';

import { useEffect, useState } from 'react';
import Link from 'next/link';
import { supabaseBrowser, isAdminEmail } from '../../lib/supabaseClient';

type ModuleRow = {
  slug: string;
  title: string;
  sort_order: number;
  unlocked: boolean;
};

export default function AdminPage() {
  const [modules, setModules] = useState<ModuleRow[]>([]);
  const [pendingCounts, setPendingCounts] = useState<Record<string, number>>({});
  const [roster, setRoster] = useState<string[]>([]);
  const [newEmail, setNewEmail] = useState('');
  const [rosterMsg, setRosterMsg] = useState<string | null>(null);
  const [loading, setLoading] = useState(true);
  const [authorized, setAuthorized] = useState<boolean | null>(null);
  const [loadError, setLoadError] = useState<string | null>(null);

  async function loadEverything() {
    const supabase = supabaseBrowser();

    const { data: modData } = await supabase
      .from('modules')
      .select('*')
      .order('sort_order', { ascending: true });
    setModules((modData as ModuleRow[]) ?? []);

    const { data: subData, error: subErr } = await supabase.rpc('get_all_submissions');
    if (subErr) {
      setLoadError(subErr.message);
    } else {
      setLoadError(null);
      const counts: Record<string, number> = {};
      (subData ?? []).forEach((s: any) => {
        if (s.status === 'pending') {
          counts[s.module_slug] = (counts[s.module_slug] ?? 0) + 1;
        }
      });
      setPendingCounts(counts);
    }

    const { data: rosterData } = await supabase
      .from('allowed_students')
      .select('email')
      .order('added_at', { ascending: true });
    setRoster((rosterData ?? []).map((r: any) => r.email));

    setLoading(false);
  }

  useEffect(() => {
    const supabase = supabaseBrowser();
    supabase.auth.getUser().then(({ data }) => {
      const ok = isAdminEmail(data.user?.email);
      setAuthorized(ok);
      if (!ok) {
        window.location.href = '/modules';
        return;
      }
      loadEverything();
    });
  }, []);

  async function addToRoster(e: React.FormEvent) {
    e.preventDefault();
    setRosterMsg(null);
    const email = newEmail.trim().toLowerCase();
    if (!email) return;
    const supabase = supabaseBrowser();
    const { error } = await supabase.from('allowed_students').insert({ email });
    if (error) {
      setRosterMsg(error.message);
    } else {
      setNewEmail('');
      await loadEverything();
    }
  }

  async function removeFromRoster(email: string) {
    const supabase = supabaseBrowser();
    await supabase.from('allowed_students').delete().eq('email', email);
    await loadEverything();
  }

  async function toggleModule(slug: string, current: boolean) {
    const supabase = supabaseBrowser();
    await supabase.from('modules').update({ unlocked: !current }).eq('slug', slug);
    await loadEverything();
  }

  if (authorized === null) return <div className="container">Checking access...</div>;
  if (authorized === false) return null;

  return (
    <div className="container">
      <div className="eyebrow">instructor</div>
      <h1 style={{ marginTop: 0 }}>Dashboard</h1>

      <h2 style={{ fontSize: 17, marginTop: 28, fontFamily: 'var(--font-display)' }}>
        Class roster ({roster.length})
      </h2>
      <p style={{ color: 'var(--ink-soft)', fontSize: 13.5, marginTop: -6 }}>
        Only these emails can register.
      </p>
      <div className="card">
        <form onSubmit={addToRoster} style={{ display: 'flex', gap: 8, marginBottom: roster.length ? 16 : 0 }}>
          <input
            type="email"
            placeholder="student@drew.edu"
            value={newEmail}
            onChange={(e) => setNewEmail(e.target.value)}
            style={{ marginBottom: 0 }}
          />
          <button className="btn" type="submit" style={{ whiteSpace: 'nowrap' }}>
            Add student
          </button>
        </form>
        {rosterMsg && <p style={{ color: 'var(--danger)', fontSize: 13 }}>{rosterMsg}</p>}
        {roster.map((email) => (
          <div
            key={email}
            style={{
              display: 'flex',
              justifyContent: 'space-between',
              alignItems: 'center',
              padding: '8px 0',
              borderTop: '1px solid var(--border)',
              fontFamily: 'var(--font-mono)',
              fontSize: 13,
            }}
          >
            {email}
            <button className="btn ghost" onClick={() => removeFromRoster(email)} style={{ padding: '4px 10px', fontSize: 12 }}>
              Remove
            </button>
          </div>
        ))}
      </div>

      <h2 style={{ fontSize: 17, marginTop: 28, fontFamily: 'var(--font-display)' }}>Modules</h2>
      <p style={{ color: 'var(--ink-soft)', fontSize: 13.5, marginTop: -6 }}>
        Unlock/lock controls whether the whole class can see a module. Click a module to review its
        submissions and answer key.
      </p>

      {loadError && (
        <div className="card locked">
          <strong>Couldn't load submission counts:</strong> {loadError}
        </div>
      )}

      {loading && <p>Loading...</p>}

      {modules.map((m) => (
        <div key={m.slug} className="card" style={{ display: 'flex', justifyContent: 'space-between', alignItems: 'center' }}>
          <Link href={`/admin/${m.slug}`} style={{ flex: 1, textDecoration: 'none', color: 'inherit' }}>
            <div style={{ cursor: 'pointer' }}>
              <span style={{ fontFamily: 'var(--font-mono)', color: 'var(--ink-soft)', marginRight: 8 }}>
                {String(m.sort_order).padStart(2, '0')}
              </span>
              {m.title}
              {m.unlocked ? <span className="badge done"># unlocked</span> : <span className="badge locked"># locked</span>}
              {pendingCounts[m.slug] > 0 && (
                <span className="status-chip review">
                  <span className="status-dot" /> {pendingCounts[m.slug]} pending
                </span>
              )}
            </div>
          </Link>
          <button
            className="btn ghost"
            onClick={(e) => {
              e.preventDefault();
              toggleModule(m.slug, m.unlocked);
            }}
          >
            {m.unlocked ? 'Lock' : 'Unlock'}
          </button>
        </div>
      ))}
    </div>
  );
}
