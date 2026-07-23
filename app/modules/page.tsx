'use client';

import { useEffect, useState } from 'react';
import Link from 'next/link';
import { supabaseBrowser } from '../../lib/supabaseClient';

type ModuleRow = {
  slug: string;
  title: string;
  sort_order: number;
  unlocked: boolean;
};

export default function Modules() {
  const [modules, setModules] = useState<ModuleRow[]>([]);
  const [email, setEmail] = useState<string | null>(null);
  const [loading, setLoading] = useState(true);

  useEffect(() => {
    const supabase = supabaseBrowser();
    supabase.auth.getUser().then(async ({ data }) => {
      if (!data.user) {
        window.location.href = '/';
        return;
      }
      setEmail(data.user.email ?? null);

      const { data: rows } = await supabase
        .from('modules')
        .select('*')
        .order('sort_order', { ascending: true });

      setModules((rows as ModuleRow[]) ?? []);
      setLoading(false);
    });
  }, []);

  return (
    <div className="container">
      <div className="eyebrow">your syllabus</div>
      <h1 style={{ marginTop: 0 }}>Modules</h1>
      {email && (
        <p style={{ color: 'var(--ink-soft)', fontFamily: 'var(--font-mono)', fontSize: 13 }}>
          {email}
        </p>
      )}

      {loading && <p>Loading modules...</p>}

      <div className="module-rail" style={{ marginTop: 24 }}>
        {modules.map((m) => (
          <div key={m.slug} className={`module-row ${m.unlocked ? 'unlocked' : ''}`}>
            <div className="module-num">{m.sort_order}</div>
            <div className={`card ${m.unlocked ? '' : 'locked'}`} style={{ marginBottom: 0 }}>
              <div style={{ display: 'flex', justifyContent: 'space-between', alignItems: 'center' }}>
                <div>
                  {m.title}
                  {m.unlocked ? (
                    <span className="badge done"># unlocked</span>
                  ) : (
                    <span className="badge locked"># locked</span>
                  )}
                </div>
                {m.unlocked ? (
                  <Link href={`/modules/${m.slug}`}>
                    <button className="btn">Open</button>
                  </Link>
                ) : (
                  <button className="btn" disabled>
                    Locked
                  </button>
                )}
              </div>
            </div>
          </div>
        ))}
      </div>

      {!loading && modules.length === 0 && (
        <p>No modules found. Make sure supabase_schema.sql has been run.</p>
      )}
    </div>
  );
}
