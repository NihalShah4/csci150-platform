'use client';

import { useEffect, useRef } from 'react';
import { supabaseBrowser } from '../lib/supabaseClient';

const TIMEOUT_MS = 5 * 60 * 1000; // 5 minutes
const ACTIVITY_EVENTS = ['mousemove', 'mousedown', 'keydown', 'scroll', 'touchstart', 'click'];

export default function InactivityTimer() {
  const timerRef = useRef<ReturnType<typeof setTimeout> | null>(null);
  const hasSessionRef = useRef(false);

  useEffect(() => {
    const supabase = supabaseBrowser();

    async function signOutForInactivity() {
      await supabase.auth.signOut();
      window.location.href = '/';
    }

    function resetTimer() {
      if (!hasSessionRef.current) return;
      if (timerRef.current) clearTimeout(timerRef.current);
      timerRef.current = setTimeout(signOutForInactivity, TIMEOUT_MS);
    }

    function startTracking() {
      hasSessionRef.current = true;
      resetTimer();
      ACTIVITY_EVENTS.forEach((evt) => window.addEventListener(evt, resetTimer));
    }

    function stopTracking() {
      hasSessionRef.current = false;
      if (timerRef.current) clearTimeout(timerRef.current);
      ACTIVITY_EVENTS.forEach((evt) => window.removeEventListener(evt, resetTimer));
    }

    supabase.auth.getUser().then(({ data }) => {
      if (data.user) startTracking();
    });

    const { data: sub } = supabase.auth.onAuthStateChange((_event, session) => {
      if (session?.user) {
        startTracking();
      } else {
        stopTracking();
      }
    });

    return () => {
      stopTracking();
      sub.subscription.unsubscribe();
    };
  }, []);

  return null;
}
