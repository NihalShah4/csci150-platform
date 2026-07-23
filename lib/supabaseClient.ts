import { createBrowserClient } from '@supabase/ssr';

// These come from your Supabase project settings (Settings -> API).
// Set them as Environment Variables in the Vercel project dashboard:
//   NEXT_PUBLIC_SUPABASE_URL
//   NEXT_PUBLIC_SUPABASE_ANON_KEY
export function supabaseBrowser() {
  return createBrowserClient(
    process.env.NEXT_PUBLIC_SUPABASE_URL!,
    process.env.NEXT_PUBLIC_SUPABASE_ANON_KEY!
  );
}

// Only school-domain emails should be allowed to sign up.
// Change this to your actual school domain.
export const ALLOWED_EMAIL_DOMAIN = 'drew.edu';

export function isAllowedEmail(email: string) {
  return email.toLowerCase().endsWith('@' + ALLOWED_EMAIL_DOMAIN);
}

// The instructor account. This must match a real Supabase Auth user
// you create yourself (sign up through the app, or add the user
// directly in the Supabase dashboard). This value alone does NOT
// grant access on its own — it's paired with a Postgres Row Level
// Security policy (see supabase_schema.sql) that checks the same
// email server-side, so a student can't fake admin access by editing
// frontend code.
export const ADMIN_EMAIL = 'nshah3@drew.edu';

export function isAdminEmail(email: string | null | undefined) {
  return !!email && email.toLowerCase() === ADMIN_EMAIL.toLowerCase();
}
