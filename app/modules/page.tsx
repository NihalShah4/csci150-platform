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

type ModuleStatus = {
  totalExercises: number;
  approvedCount: number;
  hasPending: boolean;
  hasNeedsRevision: boolean;
};

export default function Modules() {
  const [modules, setModules] = useState<ModuleRow[]>([]);
  const [statusByModule, setStatusByModule] = useState<Record<string, ModuleStatus>>({});
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

      const { data: exRows } = await supabase.from('exercises').select('id, module_slug');
      const exerciseModuleMap: Record<string, string> = {};
      const totalByModule: Record<string, number> = {};
      (exRows ?? []).forEach((e: any) => {
        exerciseModuleMap[e.id] = e.module_slug;
        totalByModule[e.module_slug] = (totalByModule[e.module_slug] ?? 0) + 1;
      });

      const { data: subs } = await supabase
        .from('submissions')
        .select('exercise_id, status, created_at')
        .eq('student_id', data.user.id)
        .order('created_at', { ascending: true });

      const latestByExercise: Record<string, string> = {};
      (subs ?? []).forEach((s: any) => {
        if (s.exercise_id) latestByExercise[s.exercise_id] = s.status;
      });

      const result: Record<string, ModuleStatus> = {};
      Object.entries(exerciseModuleMap).forEach(([exId, slug]) => {
        if (!result[slug]) {
          result[slug] = { totalExercises: totalByModule[slug] ?? 0, approvedCount: 0, hasPending: false, hasNeedsRevision: false };
        }
        const status = latestByExercise[exId];
        if (status === 'approved') result[slug].approvedCount += 1;
        if (status === 'pending') result[slug].hasPending = true;
        if (status === 'needs_revision') result[slug].hasNeedsRevision = true;
      });
      setStatusByModule(result);

      setLoading(false);
    });
  }, []);

  const unlockedCount = modules.filter((m) => m.unlocked).length;
  const completeCount = modules.filter((m) => {
    const s = statusByModule[m.slug];
    return s && s.totalExercises > 0 && s.approvedCount === s.totalExercises;
  }).length;
  const total = modules.length || 9;

  function statusChip(slug: string) {
    const s = statusByModule[slug];
    if (!s || s.totalExercises === 0) return null;
    if (s.approvedCount === s.totalExercises) {
      return (
        <span className="status-chip complete">
          <span className="status-dot" /> complete
        </span>
      );
    }
    if (s.hasNeedsRevision) return <span className="status-chip retry">try again</span>;
    if (s.hasPending) {
      return (
        <span className="status-chip review">
          <span className="status-dot" /> in review
        </span>
      );
    }
    if (s.approvedCount > 0) {
      return (
        <span className="status-chip review">
          {s.approvedCount}/{s.totalExercises} done
        </span>
      );
    }
    return null;
  }

  return (
    <div className="container">
      <div className="eyebrow">your syllabus</div>
      <h1 style={{ marginTop: 0, marginBottom: 4 }}>Modules</h1>
      {email && (
        <p style={{ color: 'var(--ink-soft)', fontFamily: 'var(--font-mono)', fontSize: 13, marginTop: 0 }}>
          {email}
        </p>
      )}

      {!loading && (
        <div style={{ margin: '18px 0 28px' }}>
          <div style={{ display: 'flex', justifyContent: 'space-between', fontSize: 13, marginBottom: 6 }}>
            <span style={{ fontFamily: 'var(--font-mono)', color: 'var(--ink-soft)' }}>
              {completeCount} of {total} modules complete
            </span>
            <span style={{ fontFamily: 'var(--font-mono)', color: 'var(--ink-soft)' }}>
              {unlockedCount} unlocked
            </span>
          </div>
          <div className="progress-track">
            <div className="progress-fill" style={{ width: `${(completeCount / total) * 100}%` }} />
          </div>
        </div>
      )}

      {loading && <p>Loading modules...</p>}

      <div className="module-rail">
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
                  {statusChip(m.slug)}
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
