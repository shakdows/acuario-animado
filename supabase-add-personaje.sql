-- ============================================================
--  Agregar columna "personaje" (qué animal coloreó el niño)
--  para el modo Cine. Corre esto en SQL Editor.
-- ============================================================
alter table public.dibujos add column if not exists personaje text;
