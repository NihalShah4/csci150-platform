'use client';

import { useEffect, useState } from 'react';
import { supabaseBrowser, isAdminEmail } from '../../lib/supabaseClient';

// IMPORTANT: the isAdminEmail check below is a convenience redirect,
// not real security -- a student could disable JavaScript and skip it.
// The actual protection is the Postgres Row Level Security policy in
// supabase_schema.sql, which only lets the ADMIN_EMAIL account read
// every row of `submissions`, and the get_all_submissions() function,
// which only lets that same account see student emails.

type Submission = {
  id: string;
  student_id: string;
  student_email: string;
  module_slug: string;
  code: string;
  status: string;
  created_at: string;
};

type ModuleRow = {
  slug: string;
  title: string;
  sort_order: number;
  unlocked: boolean;
};

export default function AdminPage() {
  const [submissions, setSubmissions] = useState<Submission[]>([]);
  const [modules, setModules] = useState<ModuleRow[]>([]);
  const [loading, setLoading] = useState(true);
  const [authorized, setAuthorized] = useState<boolean | null>(null);
  const [busyId, setBusyId] = useState<string | null>(null);
  const [loadError, setLoadError] = useState<string | null>(null);

  async function loadEverything() {
    const supabase = supabaseBrowser();

    const { data: subData, error: subErr } = await supabase.rpc('get_all_submissions');
    if (subErr) {
      setLoadError(subErr.message);
    } else {
      setLoadError(null);
      setSubmissions((subData as Submission[]) ?? []);
    }

    const { data: modData } = await supabase
      .from('modules')
      .select('*')
      .order('sort_order', { ascending: true });
    setModules((modData as ModuleRow[]) ?? []);

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

  async function setStatus(id: string, status: string) {
    setBusyId(id);
    const supabase = supabaseBrowser();
    await supabase.from('submissions').update({ status }).eq('id', id);
    await loadEverything();
    setBusyId(null);
  }

  async function toggleModule(slug: string, current: boolean) {
    const supabase = supabaseBrowser();
    await supabase.from('modules').update({ unlocked: !current }).eq('slug', slug);
    await loadEverything();
  }

  if (authorized === null) return <div className="container">Checking access...</div>;
  if (authorized === false) return null;

  const pending = submissions.filter((s) => s.status === 'pending');
  const reviewed = submissions.filter((s) => s.status !== 'pending');

  return (
    <div className="container">
      <h1>Instructor Dashboard</h1>

      <h2 style={{ fontSize: 18, marginTop: 24 }}>Module Access</h2>
      <p style={{ color: '#6b7280', fontSize: 14 }}>
        Unlock a module once you've taught that week's material. This applies to the whole class at once.
      </p>
      {modules.map((m) => (
        <div key={m.slug} className="card" style={{ display: 'flex', justifyContent: 'space-between', alignItems: 'center' }}>
          <div>
            {m.sort_order}. {m.title}
            {m.unlocked ? <span className="badge done">unlocked</span> : <span className="badge locked">locked</span>}
          </div>
          <button className="btn" onClick={() => toggleModule(m.slug, m.unlocked)}>
            {m.unlocked ? 'Lock' : 'Unlock'}
          </button>
        </div>
      ))}

      <h2 style={{ fontSize: 18, marginTop: 32 }}>Pending Submissions ({pending.length})</h2>
      {loading && <p>Loading...</p>}
      {loadError && (
        <div className="card locked">
          <strong>Couldn't load submissions:</strong> {loadError}
          <p style={{ fontSize: 13, marginTop: 6 }}>
            This usually means the <code>get_all_submissions()</code> function hasn't been run in the
            Supabase SQL Editor yet.
          </p>
        </div>
      )}

      {pending.map((s) => (
        <div key={s.id} className="card">
          <div style={{ display: 'flex', justifyContent: 'space-between' }}>
            <strong>{s.module_slug}</strong>
            <span className="badge">{s.status}</span>
          </div>
          <p style={{ fontSize: 12, color: '#6b7280' }}>
            {s.student_email} &middot; {new Date(s.created_at).toLocaleString()}
          </p>
          <pre className="editor">{s.code}</pre>
          <div style={{ display: 'flex', gap: 8, marginTop: 8 }}>
            <button className="btn" disabled={busyId === s.id} onClick={() => setStatus(s.id, 'approved')}>
              Approve
            </button>
            <button
              className="btn"
              disabled={busyId === s.id}
              style={{ background: '#b23b30' }}
              onClick={() => setStatus(s.id, 'needs_revision')}
            >
              Needs revision
            </button>
          </div>
        </div>
      ))}

      {!loading && pending.length === 0 && <p>No pending submissions.</p>}

      {reviewed.length > 0 && (
        <>
          <h2 style={{ fontSize: 18, marginTop: 32 }}>Reviewed ({reviewed.length})</h2>
          {reviewed.map((s) => (
            <div key={s.id} className="card">
              <div style={{ display: 'flex', justifyContent: 'space-between' }}>
                <strong>{s.module_slug}</strong>
                <span className={`badge ${s.status === 'approved' ? 'done' : 'locked'}`}>{s.status}</span>
              </div>
              <p style={{ fontSize: 12, color: '#6b7280' }}>
                {s.student_email} &middot; {new Date(s.created_at).toLocaleString()}
              </p>
            </div>
          ))}
        </>
      )}
    </div>
  );
}
