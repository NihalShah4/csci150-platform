-- Run this once in the Supabase SQL editor for your project.

create table modules (
  slug text primary key,
  title text not null,
  sort_order int not null,
  unlocked boolean default false
);

insert into modules (slug, title, sort_order, unlocked) values
  ('intro-computers-programming', 'Introduction to Computers and Programming', 1, true),
  ('input-processing-output', 'Input, Processing, Output', 2, false),
  ('decision-structures-boolean', 'Decision Structures and Boolean Logic', 3, false),
  ('repetition-structures', 'Repetition Structures', 4, false),
  ('functions', 'Functions', 5, false),
  ('files-exceptions', 'Files and Exceptions', 6, false),
  ('lists-tuples', 'Lists and Tuples', 7, false),
  ('more-about-strings', 'More About Strings', 8, false),
  ('dictionaries-sets', 'Dictionaries and Sets', 9, false);

create table submissions (
  id uuid primary key default gen_random_uuid(),
  student_id uuid references auth.users not null,
  module_slug text references modules(slug) not null,
  code text not null,
  status text default 'pending',
  instructor_notes text,
  created_at timestamptz default now()
);

create table progress (
  student_id uuid references auth.users not null,
  module_slug text references modules(slug) not null,
  unlocked_at timestamptz default now(),
  primary key (student_id, module_slug)
);

-- Row Level Security: students can only see and insert their own submissions.
alter table submissions enable row level security;

create policy "students insert own submissions"
  on submissions for insert
  with check (auth.uid() = student_id);

create policy "students read own submissions"
  on submissions for select
  using (auth.uid() = student_id);

-- The instructor account can read every submission. This is the real
-- security boundary -- the frontend "admin page" check is convenience
-- only, this policy is what actually stops other students from ever
-- reading each other's work, no matter how they query the database.
create policy "instructor reads all submissions"
  on submissions for select
  using (auth.jwt() ->> 'email' = 'nshah3@drew.edu');

create policy "instructor updates all submissions"
  on submissions for update
  using (auth.jwt() ->> 'email' = 'nshah3@drew.edu');

-- You (the instructor) will read everything using the Supabase
-- dashboard or a service-role key from a secure admin-only route,
-- not through the public anon key used by students.

alter table modules enable row level security;
alter table progress enable row level security;

create policy "anyone signed in can read modules"
  on modules for select
  using (auth.role() = 'authenticated');

create policy "only instructor can change module lock state"
  on modules for update
  using (auth.jwt() ->> 'email' = 'nshah3@drew.edu');

create policy "students read own progress"
  on progress for select
  using (auth.uid() = student_id);

create policy "only instructor manages progress"
  on progress for insert
  with check (auth.jwt() ->> 'email' = 'nshah3@drew.edu');

-- Lets the instructor account see each submission alongside the
-- student's email. This function runs with elevated privileges
-- (security definer) but the very first line refuses to run for
-- anyone except the instructor -- so it can't be used to leak
-- emails to students, only to the one account it checks for.
create or replace function get_all_submissions()
returns table (
  id uuid,
  student_id uuid,
  student_email text,
  module_slug text,
  code text,
  status text,
  created_at timestamptz
)
language plpgsql
security definer
set search_path = public
as $$
begin
  if (auth.jwt() ->> 'email') is distinct from 'nshah3@drew.edu' then
    raise exception 'not authorized';
  end if;

  return query
    select s.id, s.student_id, u.email::text, s.module_slug, s.code, s.status, s.created_at
    from submissions s
    join auth.users u on u.id = s.student_id
    order by s.created_at desc;
end;
$$;
