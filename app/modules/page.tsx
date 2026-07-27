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

type ClassStat = { module_slug: string; total_students: number; completed_students: number };

function computeStreak(dates: string[]): number {
  const daySet = new Set(dates.map((d) => new Date(d).toDateString()));
  let streak = 0;
  const cursor = new Date();
  // if nothing happened today yet, streak can still count from yesterday backwards
  if (!daySet.has(cursor.toDateString())) {
    cursor.setDate(cursor.getDate() - 1);
  }
  while (daySet.has(cursor.toDateString())) {
    streak += 1;
    cursor.setDate(cursor.getDate() - 1);
  }
  return streak;
}

export default function Modules() {
  const [modules, setModules] = useState<ModuleRow[]>([]);
  const [statusByModule, setStatusByModule] = useState<Record<string, ModuleStatus>>({});
  const [classStats, setClassStats] = useState<Record<string, ClassStat>>({});
  const [streak, setStreak] = useState(0);
  const [approvedTotal, setApprovedTotal] = useState(0);
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

      const { data: exRows } = await supabase.from('exercises').select('id, module_slug, is_bonus');
      const exerciseModuleMap: Record<string, string> = {};
      const totalByModule: Record<string, number> = {};
      (exRows ?? []).forEach((e: any) => {
        if (e.is_bonus) return;
        exerciseModuleMap[e.id] = e.module_slug;
        totalByModule[e.module_slug] = (totalByModule[e.module_slug] ?? 0) + 1;
      });

      const { data: subs } = await supabase
        .from('submissions')
        .select('exercise_id, status, created_at')
        .eq('student_id', data.user.id)
        .order('created_at', { ascending: true });

      const latestByExercise: Record<string, string> = {};
      let approvedCountTotal = 0;
      const seenApproved = new Set<string>();
      (subs ?? []).forEach((s: any) => {
        if (s.exercise_id) latestByExercise[s.exercise_id] = s.status;
      });
      Object.values(latestByExercise).forEach((status) => {
        if (status === 'approved') approvedCountTotal += 1;
      });
      setApprovedTotal(approvedCountTotal);
      setStreak(computeStreak((subs ?? []).map((s: any) => s.created_at)));

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

      const { data: statsData } = await supabase.rpc('get_module_completion_stats');
      const statsMap: Record<string, ClassStat> = {};
      (statsData ?? []).forEach((s: any) => {
        statsMap[s.module_slug] = s;
      });
      setClassStats(statsMap);

      setLoading(false);
    });
  }, []);

  const unlockedCount = modules.filter((m) => m.unlocked).length;
  const completeCount = modules.filter((m) => {
    const s = statusByModule[m.slug];
    return s && s.totalExercises > 0 && s.approvedCount === s.totalExercises;
  }).length;
  const total = modules.length || 9;

  const badges: string[] = [];
  if (approvedTotal >= 1) badges.push('First exercise approved');
  if (approvedTotal >= 10) badges.push('10 exercises approved');
  if (approvedTotal >= 25) badges.push('25 exercises approved');
  if (completeCount >= 1) badges.push('First module complete');
  if (completeCount >= total && total > 0) badges.push('All modules complete');
  if (streak >= 3) badges.push(`${streak}-day streak`);

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
        <>
          <div style={{ margin: '18px 0 12px' }}>
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

          {badges.length > 0 && (
            <div style={{ display: 'flex', gap: 8, flexWrap: 'wrap', marginBottom: 24 }}>
              {badges.map((b) => (
                <span key={b} className="status-chip complete">
                  <span className="status-dot" /> {b}
                </span>
              ))}
            </div>
          )}
        </>
      )}

      {loading && <p>Loading modules...</p>}

      <div className="module-rail">
        {modules.map((m) => {
          const stat = classStats[m.slug];
          const classPct = stat && stat.total_students > 0
            ? Math.round((stat.completed_students / stat.total_students) * 100)
            : null;
          return (
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
                {classPct !== null && (
                  <p style={{ fontSize: 11.5, color: 'var(--ink-soft)', fontFamily: 'var(--font-mono)', margin: '8px 0 0' }}>
                    {classPct}% of the class has finished this module
                  </p>
                )}
              </div>
            </div>
          );
        })}
      </div>

      {!loading && modules.length === 0 && (
        <p>No modules found. Make sure supabase_schema.sql has been run.</p>
      )}
    </div>
  );
}
