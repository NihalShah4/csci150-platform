'use client';

import { useEffect, useState } from 'react';
import Link from 'next/link';
import { supabaseBrowser } from '../../lib/supabaseClient';

const MODULES = [
  { slug: 'intro-computers-programming', title: '1. Introduction to Computers and Programming' },
  { slug: 'input-processing-output', title: '2. Input, Processing, Output' },
  { slug: 'decision-structures-boolean', title: '3. Decision Structures and Boolean Logic' },
  { slug: 'repetition-structures', title: '4. Repetition Structures' },
  { slug: 'functions', title: '5. Functions' },
  { slug: 'files-exceptions', title: '6. Files and Exceptions' },
  { slug: 'lists-tuples', title: '7. Lists and Tuples' },
  { slug: 'more-about-strings', title: '8. More About Strings' },
  { slug: 'dictionaries-sets', title: '9. Dictionaries and Sets' },
];

export default function Modules() {
  const [unlocked, setUnlocked] = useState<Set<string>>(new Set([MODULES[0].slug]));
  const [email, setEmail] = useState<string | null>(null);

  useEffect(() => {
    const supabase = supabaseBrowser();
    supabase.auth.getUser().then(({ data }) => {
      if (!data.user) {
        window.location.href = '/';
        return;
      }
      setEmail(data.user.email ?? null);
      // TODO: replace with a real query to the `progress` table
      // to get which modules this student has unlocked.
    });
  }, []);

  return (
    <div className="container">
      <h1>Modules</h1>
      {email && <p style={{ color: '#9aa1b2' }}>Signed in as {email}</p>}

      {MODULES.map((m, i) => {
        const isUnlocked = unlocked.has(m.slug);
        return (
          <div key={m.slug} className={`card ${isUnlocked ? '' : 'locked'}`}>
            <div style={{ display: 'flex', justifyContent: 'space-between', alignItems: 'center' }}>
              <div>
                {m.title}
                {isUnlocked ? (
                  <span className="badge done">unlocked</span>
                ) : (
                  <span className="badge locked">locked</span>
                )}
              </div>
              {isUnlocked ? (
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
        );
      })}
    </div>
  );
}
