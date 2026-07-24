'use client';

import { usePathname } from 'next/navigation';

export default function AppBackground() {
  const pathname = usePathname();
  if (pathname === '/') return null;

  return <div className="app-bg" aria-hidden="true" />;
}
