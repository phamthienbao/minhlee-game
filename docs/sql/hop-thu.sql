-- Hộp thư công ty (giai đoạn A): bảng online + messages. Chạy MỘT LẦN trong Supabase → SQL Editor.
-- Không chứa khóa hay email. Có thể chạy lại an toàn (create if not exists / or replace / drop policy if exists).

-- Hàm tiện ích: nhân vật của người đang đăng nhập (theo bảng progress)
create or replace function public.my_char() returns text
language sql stable security definer set search_path = public as $$
  select char_id from public.progress where user_id = auth.uid() limit 1
$$;
revoke all on function public.my_char() from public;
grant execute on function public.my_char() to authenticated;

-- 1) Ai đang online (mỗi người một dòng, ghi mỗi ~60 giây)
create table if not exists public.online (
  char_id   text primary key,
  last_seen timestamptz not null default now()
);
alter table public.online enable row level security;
drop policy if exists online_select on public.online;
drop policy if exists online_insert on public.online;
drop policy if exists online_update on public.online;
create policy online_select on public.online for select to authenticated using (true);
create policy online_insert on public.online for insert to authenticated with check (char_id = public.my_char());
create policy online_update on public.online for update to authenticated using (char_id = public.my_char()) with check (char_id = public.my_char());

-- 2) Tin nhắn / việc giao / giấy nhớ càm ràm
create table if not exists public.messages (
  id         uuid primary key default gen_random_uuid(),
  thread_id  uuid references public.messages(id) on delete cascade,   -- null: tin gốc; có giá trị: trả lời trong luồng
  from_char  text not null,
  to_char    text not null,
  kind       text not null check (kind in ('chat','task','note')),
  body       text not null check (char_length(body) between 1 and 300),
  due        text check (due in ('today','tomorrow','none')),         -- chỉ dùng cho kind = 'task'
  done       boolean not null default false,
  done_at    timestamptz,
  read_at    timestamptz,                                              -- người nhận đã mở xem
  ref        uuid references public.messages(id) on delete cascade,   -- giấy nhớ càm ràm trỏ về việc gốc
  created_at timestamptz not null default now(),
  check (from_char <> to_char)
);
create unique index if not exists messages_one_note_per_task on public.messages(ref) where kind = 'note';
create index if not exists messages_to_idx   on public.messages(to_char, created_at desc);
create index if not exists messages_from_idx on public.messages(from_char, created_at desc);
alter table public.messages enable row level security;
drop policy if exists messages_select on public.messages;
drop policy if exists messages_insert on public.messages;
drop policy if exists messages_update on public.messages;
create policy messages_select on public.messages for select to authenticated
  using (from_char = public.my_char() or to_char = public.my_char());
-- chat/task: chỉ gửi dưới tên nhân vật của mình. note: do máy người NHẬN ghi (người giao có thể đang offline) nên cho phép khi to_char là mình.
create policy messages_insert on public.messages for insert to authenticated
  with check ((kind in ('chat','task') and from_char = public.my_char()) or (kind = 'note' and to_char = public.my_char()));
create policy messages_update on public.messages for update to authenticated
  using (from_char = public.my_char() or to_char = public.my_char())
  with check (from_char = public.my_char() or to_char = public.my_char());

-- 3) Quyền (dự án này không tự cấp quyền cho bảng mới)
grant usage on schema public to authenticated;
grant select, insert on public.online to authenticated;
-- upsert (thêm, nếu đã có thì cập nhật) ghi cả char_id nên cần quyền update cả bảng; RLS vẫn chỉ cho sửa dòng của chính mình
grant update on public.online to authenticated;
grant select, insert on public.messages to authenticated;
grant update (done, done_at, read_at) on public.messages to authenticated;
