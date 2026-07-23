'use client';

import { useEffect, useState } from 'react';
import { supabaseBrowser, isAdminEmail } from '../../lib/supabaseClient';

// IMPORTANT: the isAdminEmail check below is a convenience redirect,
// not real security -- a student could disable JavaScript and skip it.
// The actual protection is the Postgres Row Level Security policy in
// supabase_schema.sql, which only lets the ADMIN_EMAIL account read
// every row of `submissions`. Everyone else only ever gets their own.

type Submission = {
  id: string;
  student_id: string;
  module_slug: string;
  code: string;
  status: string;
  created_at: string;
};

export default function AdminPage() {
  const [submissions, setSubmissions] = useState<Submission[]>([]);
  const [loading, setLoading] = useState(true);
  const [authorized, setAuthorized] = useState<boolean | null>(null);

  useEffect(() => {
    const supabase = supabaseBrowser();
    supabase.auth.getUser().then(({ data }) => {
      const ok = isAdminEmail(data.user?.email);
      setAuthorized(ok);
      if (!ok) {
        window.location.href = '/modules';
        return;
      }
      supabase
        .from('submissions')
        .select('*')
        .order('created_at', { ascending: false })
        .then(({ data }) => {
          setSubmissions((data as Submission[]) ?? []);
          setLoading(false);
        });
    });
  }, []);

  if (authorized === null) return <div className="container">Checking access...</div>;
  if (authorized === false) return null;

  return (
    <div className="container">
      <h1>Instructor Dashboard</h1>
      <p style={{ color: '#9aa1b2' }}>Pending submissions across all students and modules.</p>

      {loading && <p>Loading...</p>}

      {submissions.map((s) => (
        <div key={s.id} className="card">
          <div style={{ display: 'flex', justifyContent: 'space-between' }}>
            <strong>{s.module_slug}</strong>
            <span className="badge">{s.status}</span>
          </div>
          <p style={{ fontSize: 12, color: '#9aa1b2' }}>
            Student: {s.student_id} &middot; {new Date(s.created_at).toLocaleString()}
          </p>
          <pre className="editor">{s.code}</pre>
          <div style={{ display: 'flex', gap: 8, marginTop: 8 }}>
            <button className="btn">Approve</button>
            <button className="btn" style={{ background: '#a94444' }}>
              Needs revision
            </button>
          </div>
        </div>
      ))}

      {!loading && submissions.length === 0 && <p>No submissions yet.</p>}
    </div>
  );
}
