-- ============================================================
--  ACUARIO MÁGICO — Configuración de Supabase
--  Pega y ejecuta esto en:  Supabase  ->  SQL Editor  ->  New query
-- ============================================================

-- 1) Tabla de dibujos
create table if not exists public.dibujos (
  id          uuid primary key default gen_random_uuid(),
  image_url   text not null,
  mundo       text default 'oceano',
  created_at  timestamptz default now()
);

-- 2) Activar Realtime sobre la tabla (para que el acuario reciba al instante)
alter publication supabase_realtime add table public.dibujos;

-- 3) Row Level Security (evento público: permitimos anon)
alter table public.dibujos enable row level security;

drop policy if exists "anon insert dibujos" on public.dibujos;
create policy "anon insert dibujos" on public.dibujos
  for insert to anon with check (true);

drop policy if exists "anon select dibujos" on public.dibujos;
create policy "anon select dibujos" on public.dibujos
  for select to anon using (true);

-- 4) Bucket de Storage 'dibujos' (público para lectura)
insert into storage.buckets (id, name, public)
values ('dibujos', 'dibujos', true)
on conflict (id) do nothing;

-- 5) Políticas de Storage: subir y leer anónimo
drop policy if exists "anon upload dibujos" on storage.objects;
create policy "anon upload dibujos" on storage.objects
  for insert to anon with check (bucket_id = 'dibujos');

drop policy if exists "public read dibujos" on storage.objects;
create policy "public read dibujos" on storage.objects
  for select to anon using (bucket_id = 'dibujos');

-- Listo. El bucket también lo puedes crear desde el panel:
-- Storage -> New bucket -> nombre "dibujos" -> marcar "Public bucket".
