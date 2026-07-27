'use client';

import { useEffect, useState } from 'react';
import { randomFact } from '../lib/pythonFacts';

export default function LoadingFact() {
  const [fact, setFact] = useState(() => randomFact());

  useEffect(() => {
    const interval = setInterval(() => {
      setFact((prev) => randomFact(prev));
    }, 4000);
    return () => clearInterval(interval);
  }, []);

  return (
    <div style={{ fontSize: 12.5, color: 'var(--ink-soft)', fontFamily: 'var(--font-mono)' }}>
      Loading Python... did you know: {fact}
    </div>
  );
}
