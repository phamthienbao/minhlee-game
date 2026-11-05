-- Hộp thư công ty, giai đoạn B: luật phía máy chủ cho soạn tin và giao việc. Chạy MỘT LẦN sau hop-thu.sql (chạy lại an toàn).
-- Chống gian lận và spam ngay trên server, vì kiểm tra ở trình duyệt không chặn được người cố ý.
--  - chat/task chỉ gửi dưới tên nhân vật của mình; tối đa 10 tin mỗi phút và 5 việc giao trong 24 giờ
--  - chỉ NGƯỜI NHẬN được đánh dấu đã đọc và đánh dấu "Xong"; người giao hoặc người nhận có thể mở lại (bỏ tick)
--  - done/read_at không thể đặt sẵn khi tạo tin
create or replace function public.messages_guard() returns trigger
language plpgsql security definer set search_path = public as $$
declare me text := public.my_char();
begin
  if me is null then raise exception 'not signed in'; end if;
  if tg_op = 'INSERT' then
    if new.kind in ('chat','task') then
      if new.from_char <> me then raise exception 'not allowed'; end if;
      if (select count(*) from public.messages where from_char = me and created_at > now() - interval '1 minute') >= 10 then raise exception 'rate_limit'; end if;
      if new.kind = 'task' then
        if (select count(*) from public.messages where from_char = me and kind = 'task' and created_at > now() - interval '1 day') >= 5 then raise exception 'task_limit'; end if;
        if new.due is null then new.due := 'today'; end if;
      else
        new.due := null;
      end if;
    end if;
    new.done := false; new.done_at := null; new.read_at := null;
    return new;
  else
    if new.read_at is distinct from old.read_at and old.to_char <> me then raise exception 'not allowed'; end if;
    if new.done is distinct from old.done then
      if old.kind <> 'task' then raise exception 'not a task'; end if;
      if new.done and old.to_char <> me then raise exception 'only the assignee can mark done'; end if;
    end if;
    return new;
  end if;
end $$;
drop trigger if exists messages_guard on public.messages;
create trigger messages_guard before insert or update on public.messages for each row execute function public.messages_guard();
