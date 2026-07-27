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
  approach_note text,
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

-- ============================================================
-- Interactivity additions: bonus exercises, tiered hints,
-- reflection notes, class-wide (anonymous) completion stats.
-- ============================================================

alter table exercises add column if not exists is_bonus boolean default false;

-- Tiered hints: students reveal these one level at a time in the UI.
-- Kept separate from exercises so the reveal logic lives entirely
-- client-side without needing to touch the exercise row itself.
create table if not exists exercise_hints (
  id uuid primary key default gen_random_uuid(),
  exercise_id uuid references exercises(id) not null,
  hint_level int not null,
  hint_text text not null,
  unique (exercise_id, hint_level)
);

alter table exercise_hints enable row level security;

create policy "anyone signed in can read hints"
  on exercise_hints for select
  using (auth.role() = 'authenticated');

create policy "only instructor manages hints"
  on exercise_hints for all
  using (auth.jwt() ->> 'email' = 'nshah3@drew.edu')
  with check (auth.jwt() ->> 'email' = 'nshah3@drew.edu');

-- Class-wide completion percentage per module, with zero per-student
-- data exposed. Safe for any signed-in student to call directly.
create or replace function get_module_completion_stats()
returns table (
  module_slug text,
  total_students bigint,
  completed_students bigint
)
language plpgsql
security definer
set search_path = public
as $$
begin
  if auth.role() <> 'authenticated' then
    raise exception 'not authorized';
  end if;

  return query
    with roster_count as (
      select count(*) as n from allowed_students
    ),
    ex_counts as (
      select module_slug, count(*) as total_ex
      from exercises
      where is_bonus = false
      group by module_slug
    ),
    approved as (
      select s.student_id, e.module_slug, count(distinct e.id) as approved_ex
      from submissions s
      join exercises e on e.id = s.exercise_id
      where s.status = 'approved' and e.is_bonus = false
      group by s.student_id, e.module_slug
    )
    select
      ec.module_slug,
      (select n from roster_count) as total_students,
      count(*) filter (where a.approved_ex = ec.total_ex) as completed_students
    from ex_counts ec
    left join approved a on a.module_slug = ec.module_slug
    group by ec.module_slug, ec.total_ex;
end;
$$;

-- Module 1 hints (two tiers per exercise: a nudge, then a bigger nudge).
insert into exercise_hints (exercise_id, hint_level, hint_text)
select id, 1, 'Try using both a double-quoted string and thinking about where the apostrophe sits inside it.'
from exercises where module_slug = 'intro-computers-programming' and sort_order = 1
on conflict (exercise_id, hint_level) do update set hint_text = excluded.hint_text;
insert into exercise_hints (exercise_id, hint_level, hint_text)
select id, 2, 'If you wrap the whole thing in double quotes, the apostrophe inside "It''s" is just a regular character, no escaping needed at all.'
from exercises where module_slug = 'intro-computers-programming' and sort_order = 1
on conflict (exercise_id, hint_level) do update set hint_text = excluded.hint_text;

insert into exercise_hints (exercise_id, hint_level, hint_text)
select id, 1, 'Remember multiplication and division happen before addition and subtraction, work left to right within each level.'
from exercises where module_slug = 'intro-computers-programming' and sort_order = 2
on conflict (exercise_id, hint_level) do update set hint_text = excluded.hint_text;
insert into exercise_hints (exercise_id, hint_level, hint_text)
select id, 2, '3 * 2 = 6 first, then 6 / 2 = 3. So it becomes 4 + 6 - 3.'
from exercises where module_slug = 'intro-computers-programming' and sort_order = 2
on conflict (exercise_id, hint_level) do update set hint_text = excluded.hint_text;

insert into exercise_hints (exercise_id, hint_level, hint_text)
select id, 1, 'Parentheses run first, so figure out (2 + 3) and (4 - 1) before anything else.'
from exercises where module_slug = 'intro-computers-programming' and sort_order = 3
on conflict (exercise_id, hint_level) do update set hint_text = excluded.hint_text;
insert into exercise_hints (exercise_id, hint_level, hint_text)
select id, 2, 'That gives you 5 * 3 ** 2. Exponents happen before multiplication, so 3 ** 2 = 9 first.'
from exercises where module_slug = 'intro-computers-programming' and sort_order = 3
on conflict (exercise_id, hint_level) do update set hint_text = excluded.hint_text;

insert into exercise_hints (exercise_id, hint_level, hint_text)
select id, 1, 'You need exactly four print() statements, one per row of the triangle.'
from exercises where module_slug = 'intro-computers-programming' and sort_order = 4
on conflict (exercise_id, hint_level) do update set hint_text = excluded.hint_text;
insert into exercise_hints (exercise_id, hint_level, hint_text)
select id, 2, 'Each row just has one more asterisk than the row before it: 1, 2, 3, 4.'
from exercises where module_slug = 'intro-computers-programming' and sort_order = 4
on conflict (exercise_id, hint_level) do update set hint_text = excluded.hint_text;

insert into exercise_hints (exercise_id, hint_level, hint_text)
select id, 1, 'Same idea as the previous exercise, but count down instead of up.'
from exercises where module_slug = 'intro-computers-programming' and sort_order = 5
on conflict (exercise_id, hint_level) do update set hint_text = excluded.hint_text;
insert into exercise_hints (exercise_id, hint_level, hint_text)
select id, 2, 'Row one has four stars, row two has three, and so on down to one star.'
from exercises where module_slug = 'intro-computers-programming' and sort_order = 5
on conflict (exercise_id, hint_level) do update set hint_text = excluded.hint_text;

insert into exercise_hints (exercise_id, hint_level, hint_text)
select id, 1, 'Read all four lines first and figure out the natural beginning, middle, and end of the story before touching any code.'
from exercises where module_slug = 'intro-computers-programming' and sort_order = 6
on conflict (exercise_id, hint_level) do update set hint_text = excluded.hint_text;
insert into exercise_hints (exercise_id, hint_level, hint_text)
select id, 2, 'Look for words like "First," "Then," "Next," and "Finally," they are telling you the order.'
from exercises where module_slug = 'intro-computers-programming' and sort_order = 6
on conflict (exercise_id, hint_level) do update set hint_text = excluded.hint_text;

insert into exercise_hints (exercise_id, hint_level, hint_text)
select id, 1, 'Read the function name being called on the second line very carefully, letter by letter.'
from exercises where module_slug = 'intro-computers-programming' and sort_order = 7
on conflict (exercise_id, hint_level) do update set hint_text = excluded.hint_text;
insert into exercise_hints (exercise_id, hint_level, hint_text)
select id, 2, 'It says "prin" instead of "print", Python does not know what "prin" means.'
from exercises where module_slug = 'intro-computers-programming' and sort_order = 7
on conflict (exercise_id, hint_level) do update set hint_text = excluded.hint_text;

insert into exercise_hints (exercise_id, hint_level, hint_text)
select id, 1, 'Look closely at the quote marks used at the very start and very end of the string.'
from exercises where module_slug = 'intro-computers-programming' and sort_order = 8
on conflict (exercise_id, hint_level) do update set hint_text = excluded.hint_text;
insert into exercise_hints (exercise_id, hint_level, hint_text)
select id, 2, 'It starts with a single quote but the apostrophe in "Don''t" closes that quote early. Try wrapping the whole thing in double quotes instead.'
from exercises where module_slug = 'intro-computers-programming' and sort_order = 8
on conflict (exercise_id, hint_level) do update set hint_text = excluded.hint_text;

insert into exercise_hints (exercise_id, hint_level, hint_text)
select id, 1, 'You only need ONE print() statement here, using two different escape sequences inside it.'
from exercises where module_slug = 'intro-computers-programming' and sort_order = 9
on conflict (exercise_id, hint_level) do update set hint_text = excluded.hint_text;
insert into exercise_hints (exercise_id, hint_level, hint_text)
select id, 2, '\t inserts a tab, \n starts a new line. Put them right inside your string literal.'
from exercises where module_slug = 'intro-computers-programming' and sort_order = 9
on conflict (exercise_id, hint_level) do update set hint_text = excluded.hint_text;

insert into exercise_hints (exercise_id, hint_level, hint_text)
select id, 1, 'print() automatically puts something between the things you give it, you do not have to add it yourself.'
from exercises where module_slug = 'intro-computers-programming' and sort_order = 10
on conflict (exercise_id, hint_level) do update set hint_text = excluded.hint_text;
insert into exercise_hints (exercise_id, hint_level, hint_text)
select id, 2, 'print("coffee", "break") already puts a single space between the two words by default.'
from exercises where module_slug = 'intro-computers-programming' and sort_order = 10
on conflict (exercise_id, hint_level) do update set hint_text = excluded.hint_text;

insert into exercise_hints (exercise_id, hint_level, hint_text)
select id, 1, 'print() has a keyword argument called sep that controls what goes between values.'
from exercises where module_slug = 'intro-computers-programming' and sort_order = 11
on conflict (exercise_id, hint_level) do update set hint_text = excluded.hint_text;
insert into exercise_hints (exercise_id, hint_level, hint_text)
select id, 2, 'print("red", "green", "blue", sep=" - ") is the shape you are looking for.'
from exercises where module_slug = 'intro-computers-programming' and sort_order = 11
on conflict (exercise_id, hint_level) do update set hint_text = excluded.hint_text;

insert into exercise_hints (exercise_id, hint_level, hint_text)
select id, 1, 'print() has a keyword argument called end, which normally defaults to a newline character.'
from exercises where module_slug = 'intro-computers-programming' and sort_order = 12
on conflict (exercise_id, hint_level) do update set hint_text = excluded.hint_text;
insert into exercise_hints (exercise_id, hint_level, hint_text)
select id, 2, 'Set end=" " on the first print() call so it does not jump to a new line before the second one runs.'
from exercises where module_slug = 'intro-computers-programming' and sort_order = 12
on conflict (exercise_id, hint_level) do update set hint_text = excluded.hint_text;

insert into exercise_hints (exercise_id, hint_level, hint_text)
select id, 1, 'The + operator glues string literals together into one longer string.'
from exercises where module_slug = 'intro-computers-programming' and sort_order = 13
on conflict (exercise_id, hint_level) do update set hint_text = excluded.hint_text;
insert into exercise_hints (exercise_id, hint_level, hint_text)
select id, 2, 'Something like "Py" + " + " + "thon" + " = " + "Python" builds the line piece by piece.'
from exercises where module_slug = 'intro-computers-programming' and sort_order = 13
on conflict (exercise_id, hint_level) do update set hint_text = excluded.hint_text;

insert into exercise_hints (exercise_id, hint_level, hint_text)
select id, 1, 'The * operator works on strings too, not just numbers.'
from exercises where module_slug = 'intro-computers-programming' and sort_order = 14
on conflict (exercise_id, hint_level) do update set hint_text = excluded.hint_text;
insert into exercise_hints (exercise_id, hint_level, hint_text)
select id, 2, '"ha" * 6 repeats the string six times in a row automatically.'
from exercises where module_slug = 'intro-computers-programming' and sort_order = 14
on conflict (exercise_id, hint_level) do update set hint_text = excluded.hint_text;

insert into exercise_hints (exercise_id, hint_level, hint_text)
select id, 1, 'Count the exact number of spaces in the target output before writing your print() calls.'
from exercises where module_slug = 'intro-computers-programming' and sort_order = 15
on conflict (exercise_id, hint_level) do update set hint_text = excluded.hint_text;
insert into exercise_hints (exercise_id, hint_level, hint_text)
select id, 2, 'Every character, including blank spaces, needs to appear exactly where shown, this is really just careful counting.'
from exercises where module_slug = 'intro-computers-programming' and sort_order = 15
on conflict (exercise_id, hint_level) do update set hint_text = excluded.hint_text;

insert into exercise_hints (exercise_id, hint_level, hint_text)
select id, 1, 'Count the opening and closing parentheses, are they balanced?'
from exercises where module_slug = 'intro-computers-programming' and sort_order = 16
on conflict (exercise_id, hint_level) do update set hint_text = excluded.hint_text;
insert into exercise_hints (exercise_id, hint_level, hint_text)
select id, 2, 'There is one opening parenthesis but no closing one at the end, add a )  right after the closing quote.'
from exercises where module_slug = 'intro-computers-programming' and sort_order = 16
on conflict (exercise_id, hint_level) do update set hint_text = excluded.hint_text;

insert into exercise_hints (exercise_id, hint_level, hint_text)
select id, 1, 'A string literal needs a matching quote mark at both the start and the end.'
from exercises where module_slug = 'intro-computers-programming' and sort_order = 17
on conflict (exercise_id, hint_level) do update set hint_text = excluded.hint_text;
insert into exercise_hints (exercise_id, hint_level, hint_text)
select id, 2, 'The string is missing its closing double quote, add one right before the closing parenthesis.'
from exercises where module_slug = 'intro-computers-programming' and sort_order = 17
on conflict (exercise_id, hint_level) do update set hint_text = excluded.hint_text;

insert into exercise_hints (exercise_id, hint_level, hint_text)
select id, 1, '% gives you the remainder after division, not the quotient.'
from exercises where module_slug = 'intro-computers-programming' and sort_order = 18
on conflict (exercise_id, hint_level) do update set hint_text = excluded.hint_text;
insert into exercise_hints (exercise_id, hint_level, hint_text)
select id, 2, '17 divided by 5 is 3 with 2 left over, so 17 % 5 is that leftover amount.'
from exercises where module_slug = 'intro-computers-programming' and sort_order = 18
on conflict (exercise_id, hint_level) do update set hint_text = excluded.hint_text;

insert into exercise_hints (exercise_id, hint_level, hint_text)
select id, 1, 'In Python 3, the single / operator always gives you a decimal result, even if it divides evenly.'
from exercises where module_slug = 'intro-computers-programming' and sort_order = 19
on conflict (exercise_id, hint_level) do update set hint_text = excluded.hint_text;
insert into exercise_hints (exercise_id, hint_level, hint_text)
select id, 2, '7 / 2 is 3.5, not 3, that is what makes it different from // (integer division).'
from exercises where module_slug = 'intro-computers-programming' and sort_order = 19
on conflict (exercise_id, hint_level) do update set hint_text = excluded.hint_text;

insert into exercise_hints (exercise_id, hint_level, hint_text)
select id, 1, 'You can use len() to find out how many characters are in the name string.'
from exercises where module_slug = 'intro-computers-programming' and sort_order = 20
on conflict (exercise_id, hint_level) do update set hint_text = excluded.hint_text;
insert into exercise_hints (exercise_id, hint_level, hint_text)
select id, 2, '"-" * len("Jordan Lee") builds a dash for every character in the name automatically.'
from exercises where module_slug = 'intro-computers-programming' and sort_order = 20
on conflict (exercise_id, hint_level) do update set hint_text = excluded.hint_text;

-- One bonus, ungraded, purely-for-fun challenge per module.
insert into exercises (module_slug, sort_order, title, prompt, starter_code, is_bonus) values
('intro-computers-programming', 100, 'Bonus: ASCII smiley',
 'Just for fun, no grading here. Using only print() statements, draw a small smiley face out of characters, however you want it to look. There is no single right answer.',
 '# Have fun with this one, draw a smiley however you like\n', true),
('input-processing-output', 100, 'Bonus: Mad Libs',
 'Just for fun. Ask the user for a noun, a verb, and an adjective using input(), then print a silly sentence using all three.',
 '# Read three words, then build a silly sentence\n', true),
('decision-structures-boolean', 100, 'Bonus: Personality quiz',
 'Just for fun. Ask the user two yes/no questions with input(), then use conditionals to print a lighthearted "personality result" based on their answers.',
 '# Ask two questions, then print a fun result based on the answers\n', true),
('repetition-structures', 100, 'Bonus: ASCII spiral or staircase',
 'Just for fun, no grading. Use nested loops to draw any interesting shape or pattern you like out of characters, get creative with it.',
 '# Draw any pattern you like using loops\n', true),
('functions', 100, 'Bonus: Mini calculator',
 'Just for fun. Write functions for add, subtract, multiply, and divide, then let the user pick an operation and two numbers, printing the result.',
 '# Build a tiny calculator using your own functions\n', true),
('files-exceptions', 100, 'Bonus: Diary entry',
 'Just for fun. Ask the user to type a short diary entry with input(), write it to a file with today''s "entry" appended, then read the whole file back and print it.',
 '# Write a diary-style entry to a file, then read it back\n', true),
('lists-tuples', 100, 'Bonus: Shuffle a playlist',
 'Just for fun. Given a list of five song titles, write code that picks one at random each time it is run (look up Python''s random module) and prints "Now playing: ...".',
 'songs = ["Song A", "Song B", "Song C", "Song D", "Song E"]\n# Pick and print one at random\n', true),
('more-about-strings', 100, 'Bonus: Pig Latin',
 'Just for fun. Given a single word, write code that converts it to Pig Latin (move the first letter to the end and add "ay"), print the result.',
 'word = "python"\n# Convert word to Pig Latin\n', true),
('dictionaries-sets', 100, 'Bonus: Build your own contact book',
 'Just for fun. Build a dictionary representing a few contacts (name to phone number), then let the user look up a name and print the number, or a friendly message if it is not found.',
 '# Build a small contact dictionary and let the user search it\n', true)
on conflict (module_slug, sort_order) do update set
  title = excluded.title, prompt = excluded.prompt, starter_code = excluded.starter_code, is_bonus = excluded.is_bonus;

-- Update RPC once more to also surface the student's approach note.
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
  approach_note text,
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
           s.code, s.status, s.instructor_notes, s.approach_note,
           s.run_count, s.seconds_to_submit, s.paste_attempted, s.created_at
    from submissions s
    join auth.users u on u.id = s.student_id
    left join exercises e on e.id = s.exercise_id
    order by s.created_at desc;
end;
$$;
