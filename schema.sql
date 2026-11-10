create table public.entries (
  id text primary key,
  user_id uuid not null default auth.uid() references auth.users(id) on delete cascade,
  t text not null check (t in ('i','w','x')),
  d date not null,
  tm text,
  a numeric(14,2) not null check (a >= 0),
  src text, bank text, cat text, sub text,
  q numeric, note text,
  created_at timestamptz default now()
);
create index on public.entries (user_id, d);
alter table public.entries enable row level security;
create policy "own rows only" on public.entries
  for all using (user_id = auth.uid()) with check (user_id = auth.uid());
