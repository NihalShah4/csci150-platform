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
  run_count integer default 0,
  seconds_to_submit integer,
  paste_attempted boolean default false,
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

-- Once a student's submission for a module has been approved, they can
-- never insert another one for that module -- even if they edit the
-- frontend, log in from a different device, or call the API directly.
-- This is enforced here, at the database level, not in the app code.
create or replace function prevent_resubmission_after_approval()
returns trigger
language plpgsql
security definer
set search_path = public
as $$
begin
  if exists (
    select 1 from submissions
    where student_id = new.student_id
      and module_slug = new.module_slug
      and status = 'approved'
  ) then
    raise exception 'This module has already been approved and cannot be resubmitted.';
  end if;
  return new;
end;
$$;

drop trigger if exists trg_prevent_resubmission on submissions;
create trigger trg_prevent_resubmission
  before insert on submissions
  for each row execute function prevent_resubmission_after_approval();

-- Class roster: only emails in this table can ever create an account.
-- You manage this list from the admin dashboard (or directly here).
create table if not exists allowed_students (
  email text primary key,
  added_at timestamptz default now()
);

alter table allowed_students enable row level security;

create policy "instructor manages roster"
  on allowed_students for all
  using (auth.jwt() ->> 'email' = 'nshah3@drew.edu')
  with check (auth.jwt() ->> 'email' = 'nshah3@drew.edu');

-- Your own account must be seeded here too, or even you couldn't sign up.
insert into allowed_students (email) values ('nshah3@drew.edu')
  on conflict (email) do nothing;

-- This runs before Supabase Auth creates ANY new account. If the email
-- isn't on the roster, account creation fails immediately -- this is
-- the actual gate, not just something the app checks afterward.
create or replace function enforce_student_roster()
returns trigger
language plpgsql
security definer
set search_path = public
as $$
begin
  if not exists (
    select 1 from allowed_students where lower(email) = lower(new.email)
  ) then
    raise exception 'This email is not on the class roster. Contact your instructor if you believe this is a mistake.';
  end if;
  return new;
end;
$$;

drop trigger if exists trg_enforce_roster on auth.users;
create trigger trg_enforce_roster
  before insert on auth.users
  for each row execute function enforce_student_roster();

-- Exercises: each module can contain several independently graded
-- problems instead of one single code box. A module only counts as
-- "complete" for a student once every exercise inside it is approved.
create table if not exists exercises (
  id uuid primary key default gen_random_uuid(),
  module_slug text references modules(slug) not null,
  sort_order int not null,
  title text not null,
  prompt text not null,
  starter_code text not null,
  unique (module_slug, sort_order)
);

alter table exercises enable row level security;

create policy "anyone signed in can read exercises"
  on exercises for select
  using (auth.role() = 'authenticated');

create policy "only instructor manages exercises"
  on exercises for all
  using (auth.jwt() ->> 'email' = 'nshah3@drew.edu')
  with check (auth.jwt() ->> 'email' = 'nshah3@drew.edu');

-- Submissions now attach to a specific exercise, not just a module.
alter table submissions add column if not exists exercise_id uuid references exercises(id);

-- Update the approval-lock trigger to work per-exercise instead of
-- per-module, since a student can now have several exercises within
-- one module in different states.
create or replace function prevent_resubmission_after_approval()
returns trigger
language plpgsql
security definer
set search_path = public
as $$
begin
  if new.exercise_id is not null and exists (
    select 1 from submissions
    where student_id = new.student_id
      and exercise_id = new.exercise_id
      and status = 'approved'
  ) then
    raise exception 'This exercise has already been approved and cannot be resubmitted.';
  end if;
  return new;
end;
$$;

-- Update the admin RPC to include exercise info.
drop function if exists get_all_submissions();
create or replace function get_all_submissions()
returns table (
  id uuid,
  student_id uuid,
  student_email text,
  module_slug text,
  exercise_id uuid,
  exercise_title text,
  code text,
  status text,
  instructor_notes text,
  run_count integer,
  seconds_to_submit integer,
  paste_attempted boolean,
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
    select s.id, s.student_id, u.email::text, s.module_slug, s.exercise_id, e.title,
           s.code, s.status, s.instructor_notes, s.run_count, s.seconds_to_submit, s.paste_attempted, s.created_at
    from submissions s
    join auth.users u on u.id = s.student_id
    left join exercises e on e.id = s.exercise_id
    order by s.created_at desc;
end;
$$;

-- Reference solutions ("answer key"). Kept in a completely separate table
-- with its own access rule -- students never get this data even by
-- inspecting network requests, since the general "students can read
-- exercises" policy only covers the exercises table, not this one.
create table if not exists exercise_answers (
  exercise_id uuid primary key references exercises(id),
  answer_key text not null
);

alter table exercise_answers enable row level security;

create policy "only instructor reads or writes answer keys"
  on exercise_answers for all
  using (auth.jwt() ->> 'email' = 'nshah3@drew.edu')
  with check (auth.jwt() ->> 'email' = 'nshah3@drew.edu');

-- Seed Module 1's exercises: original problems written in the spirit
-- of a first chapter on computers and programming (print statements
-- only -- no variables or input yet, those come in Module 2).
insert into exercises (module_slug, sort_order, title, prompt, starter_code) values
(
  'intro-computers-programming', 1, 'Escape artist',
  'Write a single print() statement that outputs the exact line below, including both the double quotes and the apostrophe:\nShe said, "It''s already done!"\nThink about which quote characters Python will let you use, and where you need a backslash, before you start typing.',
  '# Print the exact line above, quotes and all\n'
),
(
  'intro-computers-programming', 2, 'Order of operations',
  'Before writing any code, work out on paper what this expression equals: 4 + 3 * 2 - 6 / 2\nThen write one print() statement that prints the numeric result of that exact expression (do not just print the number you calculated by hand, print the expression itself and let Python evaluate it). Run it to check your prediction.',
  '# Print the result of the expression: 4 + 3 * 2 - 6 / 2\n'
),
(
  'intro-computers-programming', 3, 'Match the pattern',
  'Using only print() statements, reproduce this exact triangle of asterisks, one row per print() call, four rows total:\n*\n**\n***\n****',
  '# Print the four rows of the triangle above\n'
),
(
  'intro-computers-programming', 4, 'Reorder the story',
  'The four print() statements below are correct on their own, but they are in the wrong order, so right now they print a confusing, out-of-sequence message. Rearrange the lines (do not change their text) so the program prints a coherent four-line message that makes logical sense from start to finish.',
  'print("Then I ran it and saw the output on screen.")\nprint("First, I opened my code editor.")\nprint("Finally, I fixed the bug and celebrated.")\nprint("Next, I typed my very first print statement.")\n'
),
(
  'intro-computers-programming', 5, 'Spot the bug',
  'The program below is supposed to print two lines: "Loading Pynt..." and "Ready to code.", but it has a mistake in it. Fix it so both lines print correctly without any errors.',
  'print("Loading Pynt...")\nprin("Ready to code.")\n'
)
on conflict (module_slug, sort_order) do update set
  title = excluded.title,
  prompt = excluded.prompt,
  starter_code = excluded.starter_code;


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
  run_count integer,
  seconds_to_submit integer,
  paste_attempted boolean,
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
    select s.id, s.student_id, u.email::text, s.module_slug, s.code, s.status,
           s.run_count, s.seconds_to_submit, s.paste_attempted, s.created_at
    from submissions s
    join auth.users u on u.id = s.student_id
    order by s.created_at desc;
end;
$$;
