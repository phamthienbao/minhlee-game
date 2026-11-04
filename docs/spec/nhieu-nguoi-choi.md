# Chế độ nhiều người chơi (Supabase)

Trạng thái: Giai đoạn 1 đã triển khai (v2.0.0-alpha, 2026-11-04; sửa v2.0.1-alpha). Chủ dự án đã thử đăng nhập thật và lưu lên máy chủ thành công (2026-11-04, sau khi cấp quyền bảng, §6.1). Đăng nhập bằng email và mật khẩu thay cho link email: v2.1.0-alpha (`docs/spec/dang-nhap-cong-ty.md`, tóm tắt §10). Từ v2.1.0-alpha, màn đăng nhập chỉ hiện khi cờ `loginEnabled` bật. Giai đoạn 2 (thấy nhau) có phiên bản đầu từ v2.2.0-alpha (commit `fa7ebf7`, đã đẩy lên `origin/main`; `docs/spec/thay-nhau.md`, tóm tắt §12). Hộp thư công ty giai đoạn A (không dùng Realtime) có từ v2.2.0-alpha (commit `fa7ebf7`, đã đẩy lên `origin/main`; `docs/spec/hop-thu-cong-ty.md`, tóm tắt §13). Giai đoạn 3 đến 6 chưa bắt đầu. Chi tiết triển khai giai đoạn 1: §9. Tài liệu này ghi các quyết định của chủ dự án để các phiên làm việc sau không phải hỏi lại.

## 1. Mục tiêu

Nhân viên MinhLee (tối đa 14 người, đúng 14 nhân vật hiện có) đăng nhập bằng email công ty và chơi chung một văn phòng. Nhân vật nào chưa có người đăng nhập thì chạy AI như NPC; người đăng nhập thì thay thế NPC đó.

## 2. Quyết định của chủ dự án

| # | Chủ đề | Quyết định |
|---|---|---|
| 1 | Đăng nhập | Email công ty và mật khẩu do quản trị viên tạo (từ v2.1.0-alpha, `docs/spec/dang-nhap-cong-ty.md`). Mỗi email gắn với đúng một nhân vật trong game (bảng `roster`). Tối đa 14 người online. |
| 2 | Nhân viên mới | Vẫn giữ. Chế độ **Guest** để giải trí: người chưa có tài khoản công ty chơi vai nhân viên mới (tự đặt tên). |
| 3 | Thời gian | Chạy theo **giờ game** (không theo giờ thật). Người chưa đăng nhập: nhân vật đó là NPC. Người đã đăng nhập: thay NPC bằng người chơi. |
| 4 | Nội dung việc | Mỗi bộ phận có nội dung việc riêng (Backend việc về server, QC về lỗi, ...). |
| 5 | Thưởng chung | Sự phát triển công ty: doanh thu tăng, sản phẩm nhiều người dùng, ... (chỉ số chung cho cả công ty). |
| 6 | Thưởng cá nhân | Mở khóa đồ trang trí trên bàn (như hiện nay), theo từng người. |
| 7 | Chat và giao việc | Có chat. Giao việc và xác nhận xong ở mức đơn giản, chỉ chọn từ danh sách. Giữ cơ chế càm ràm khi quên việc. Khen và càm ràm: người chơi chọn tự gõ hoặc để máy tự chọn câu. |
| 8 | Bản offline | Tạm thời không cần (build offline và app Mac có thể hỏng, chấp nhận). |

## 3. Giả định mặc định (chờ chủ dự án xác nhận)

- **Guest** chơi một mình trong máy của họ (không vào văn phòng chung, lưu tiến độ trong trình duyệt như hiện nay). Lý do: văn phòng chung chỉ có 14 chỗ theo nhân vật.
- **Đồng hồ chung**: giờ game tính từ giờ máy chủ, mọi máy cùng thấy cùng một giờ. Không tạm dừng được trong chế độ chung (nút tạm dừng chỉ mở menu, đồng hồ vẫn chạy). Chức năng ngồi làm việc tua nhanh (time-lapse) chỉ dùng được ở chế độ Guest hoặc phải đổi cách làm.
- **Máy tính NPC**: một máy online được chọn làm "máy chủ NPC" (người vào sớm nhất), tính vị trí NPC rồi phát cho các máy còn lại. Máy đó thoát thì máy khác nhận lại.

## 4. Kiến trúc

- Nơi đặt game: hosting tĩnh (Netlify hoặc GitHub Pages). Dữ liệu và realtime: Supabase (miễn phí đủ cho 14 người).
- Thư viện: `@supabase/supabase-js` nạp qua importmap (CDN, ghim phiên bản).
- Khóa: chỉ dùng `anon key` trong game, bảo vệ bằng RLS. Không đưa `service_role` hay mật khẩu database vào repo.

### Bảng dữ liệu (Postgres)

- `roster(email, char_id, dept)`: email nào là nhân vật nào, thuộc bộ phận nào. Chỉ đọc được dòng của chính mình. Không đưa danh sách email lên GitHub.
- `progress(user_id, char_id, days, tasks_total, unlocked[], affinity, diary, session, data, updated_at)`: tiến độ cá nhân. Cột `days` và `data` được thêm khi triển khai (`data` giữ `world`, `recentEv`, `lastTheme`, `settings`). Hàm `claim_character()` tạo hàng khi đăng nhập lần đầu theo email trong `roster`.
- Sau này: `company(...)` (chỉ số chung: doanh thu, người dùng, phiên bản), `tasks(...)` (việc giao giữa người với người), `dept_progress(...)`.

### Realtime

- Kế hoạch ban đầu: kênh theo ngày game. Presence: ai đang online. Broadcast: vị trí và trạng thái người chơi (khoảng 5–10 lần mỗi giây), vị trí NPC do máy chủ NPC phát, chat, giao việc.
- Kênh riêng (private) chỉ cho người đã đăng nhập.
- Thực tế giai đoạn 2 (v2.2.0-alpha): một kênh chung `office` (không theo ngày, vì chưa có đồng hồ chung), Presence khóa theo id nhân vật, Broadcast `pos` khoảng 3 lần mỗi giây khi đi, nhịp 10 s khi đứng yên, không gửi khi đứng một mình. Kênh chưa phải riêng (private). Hạn mức Realtime, công thức tin nhắn và quyết định còn mở: `docs/spec/thay-nhau.md` §2, §6.

## 5. Các giai đoạn

1. **Đăng nhập và lưu trên server** — *Đã triển khai. Đăng nhập thật và lưu lên server đã được chủ dự án xác nhận (2026-11-04).* Đăng nhập, gắn nhân vật theo email, lưu tiến độ lên `progress`, chế độ Guest. Game đơn lẻ vẫn chạy. Thành viên ngồi đúng bàn của nhân vật mình, và được gọi theo cách riêng (v2.0.1-alpha). Chi tiết: §9.
2. **Thấy nhau** — *Phiên bản đầu đã triển khai (v2.2.0-alpha, 2026-11-04, commit `fa7ebf7`). Chưa kiểm tra với Realtime thật hoặc hai trình duyệt thật.* Presence và vị trí người chơi thật; NPC của người đang online bị ẩn, người chơi hiển thị bằng nhân vật tương ứng. Chi tiết: `docs/spec/thay-nhau.md`, §12.
3. **Đồng hồ và NPC dùng chung**: giờ chung, máy chủ NPC, sự kiện cùng lúc (mời nước, họp, tan ca).
4. **Việc theo bộ phận và chỉ số công ty**: kho việc riêng theo bộ phận, chỉ số chung tăng khi hoàn thành.
5. **Chat, giao việc giữa người, khen và càm ràm**: chọn nhanh hoặc tự gõ; máy tự chọn khi không gõ. Giai đoạn A của hộp thư đã có (§13). Phần còn lại chia thành giai đoạn B đến F: `docs/spec/hop-thu-cong-ty.md` §8.
6. **Hoàn thiện và thử với người thật**: mất kết nối, vào giữa ngày, lỗi mạng.

## 6. Việc cần chuẩn bị (chủ dự án)

Xem hướng dẫn trong cuộc trao đổi: tạo dự án Supabase (vùng Singapore), tắt tự đăng ký, mời 14 email, cấu hình SMTP riêng, chạy SQL tạo bảng. Gửi lại: Project URL, anon key, link nơi đặt game.

Cài đặt bảng điều khiển cho đăng nhập bằng mật khẩu (v2.1.0-alpha): `docs/spec/dang-nhap-cong-ty.md` §3. Từ v2.1.0-alpha không cần SMTP hay mẫu email; quản trị viên tạo từng tài khoản với mật khẩu riêng.

Trạng thái (2026-11-04): chủ dự án báo đã làm xong phần cấu hình server (bảng, hàm, RLS, 14 email được mời, SMTP riêng, Site URL và Redirect URL). Đăng nhập thật chạy được. Lưu lên `progress` chỉ chạy sau khi cấp quyền ở §6.1. Chưa xác nhận lại bằng truy vấn: tên cột của `progress`, nội dung hàm `claim_character()`, và RLS. Xem `docs/tasks.md`.

### 6.1 Cấp quyền cho bảng (bắt buộc, v2.0.1-alpha)

Trong dự án Supabase này, bảng public mới không được cấp quyền cho vai trò API mặc định. Ngoài chính sách RLS, cần chạy thêm các lệnh sau (SQL Editor, một lần):

```sql
grant usage on schema public to authenticated;
grant select on public.progress to authenticated;
grant select on public.roster to authenticated;
```

Quyền `update` theo cột của `progress` đã được cấp trước đó. Mỗi bảng public mới sau này cần cấp quyền tương tự.

Triệu chứng khi thiếu quyền:

- Mỗi lần lưu hiện "Chưa lưu được lên máy chủ" (v2.0.0-alpha). Mã lỗi PostgREST là 42501, "permission denied for table progress".
- Khách (vai trò `anon`) đọc bảng cũng nhận lỗi quyền, thay vì danh sách rỗng.

Từ v2.0.1-alpha, khi gặp lỗi 42501 hoặc thông báo chứa "permission denied", game hiện "⚠ Máy chủ chưa cấp quyền lưu tiến độ. Hãy báo quản trị viên kiểm tra." Các lỗi khác vẫn hiện thông báo chung. Cả hai đều tối đa một lần mỗi 60 giây, và game thử lại sau mỗi 15 giây. Đã xác nhận (chủ dự án, 2026-11-04): sau khi cấp quyền, lưu hoạt động.

## 7. Rủi ro và điểm cần lưu ý

- Nhân vật người chơi hiện tách riêng với 14 NPC. Cần cho phép người chơi dùng ngoại hình và vai của một nhân vật có sẵn.
- Một số cơ chế hiện có dựa vào một người chơi duy nhất (thẻ nhiệm vụ, sự kiện bất ngờ gần người chơi, lời nhắc cuối ngày) cần định nghĩa lại cho nhiều người.
- NPC có thể hơi giật hoặc lệch giữa các máy khi dùng máy chủ NPC.
- Dự án Supabase miễn phí bị tạm dừng nếu 1 tuần không hoạt động. Khi tạm dừng, đăng nhập và lưu tiến độ không hoạt động cho đến khi dự án được khôi phục trên bảng điều khiển Supabase. Chơi Guest không bị ảnh hưởng (lưu trên máy).
- Gói Free giới hạn 2 000 000 tin nhắn Realtime mỗi tháng và 200 kết nối đồng thời (bảng điều khiển, 2026-11-04). Từ v2.2.0-alpha, tần suất gửi vị trí được giảm để nằm trong hạn mức (công thức và bảng số: `docs/spec/thay-nhau.md` §6). Chưa đo bằng Supabase thật.
- Hộp thư giai đoạn A không dùng Realtime: máy khách hỏi bảng mỗi 25 giây khi tab đang hiện. Lượng yêu cầu REST chưa đo (`docs/spec/hop-thu-cong-ty.md` §5).
- Nhiệm vụ cá nhân, việc theo bộ phận và hậu quả của việc quên cần cân bằng sau khi chơi thử với người thật.

## 8. Câu hỏi còn mở

1. Guest chơi một mình hay vào văn phòng chung? (mặc định: một mình)
2. Đồng hồ chung không tạm dừng được: chấp nhận không?
3. Bỏ hay giữ chế độ ngồi làm việc (time-lapse) trong chế độ chung?

## 9. Giai đoạn 1: đã triển khai (v2.0.0-alpha, 2026-11-04; v2.0.1-alpha)

Phạm vi: đăng nhập bằng email, nhận nhân vật theo email, lưu tiến độ lên server, chế độ Guest. Chưa có: thấy người chơi khác, đồng hồ chung, chat, giao việc giữa người (giai đoạn 2 đến 6).

### 9.1 Thành phần

| Thành phần | Vị trí | Nội dung |
|---|---|---|
| Hằng số kết nối | `index.html`, cạnh `CHAR_GENDER` | `SUPABASE_URL`, `SUPABASE_KEY` (khóa publishable, công khai theo thiết kế; dữ liệu được bảo vệ bằng RLS). Không đưa khóa secret hay service_role vào mã nguồn |
| Thư viện | `index.html`, importmap | `@supabase/supabase-js@2.45.4` qua jsDelivr `+esm`. Nạp lười bằng `await import()`. Nếu CDN lỗi, game vẫn chạy ở chế độ Guest |
| Trạng thái đăng nhập | `MEMBER` (`{char}`), `CLOUD` (client, user, timer, dirty, failedAt) | `MEMBER` là null khi chưa đăng nhập |
| Khởi động | `cloudBoot()` | Có phiên đăng nhập: `cloudClaim()`, rồi `cloudApply(row)`. Không có phiên và chưa chọn Guest (cờ `loginEnabled` bật): màn đăng nhập `showLogin()`. Cờ tắt: Guest ngay, không tải supabase-js. Đã chọn Guest, hoặc không tải được thư viện: `showWelcomeBack()` của Guest |
| Nhận nhân vật | `cloudClaim()` gọi RPC `claim_character()` | Server ánh xạ email sang nhân vật qua bảng `roster`, tạo hàng `progress` nếu chưa có. Nếu lỗi, đăng xuất và hiện màn đăng nhập kèm thông báo nhờ quản trị viên kiểm tra |
| Áp dụng nhân vật | `cloudApply(row)` | Tên = tên thật của nhân vật. Giới tính lấy từ `CHAR_GENDER`. Ngoại hình = ngoại hình của NPC (`rebuildPlayer`). NPC của chính nhân vật đó có `times.arrive = 99999` mỗi ngày (`startDay()`). Gọi `applyPlayerDesk(p)` và đặt `MEMBER_CALL` (v2.0.1-alpha) |
| Bàn của thành viên | `applyPlayerDesk(profile)` (mục 5) | Sao chép `DESKS[profile.desk]` vào `PLAYER_DESK`: `kind`, `x`, `z`, `seat`, `north`, và `sx`/`sz` (tâm mặt bàn; bàn dài: `sx` = x ghế, `sz` = z bàn ± 0,5). Đưa điểm làm việc `SPOTS[0]` về điểm trước ghế (lệch 0,4 m). Dựng lại đồ trên bàn (`buildDeskItems()`, quay π khi ghế ở phía bắc bàn dài). Với `desk: null` (Nguyên) hoặc khi gọi với `null`: khôi phục bàn khách ở góc dưới bên trái, cạnh bàn Thông. v2.0.1-alpha |
| Cách gọi thành viên | `MEMBER_CALL` (mục 1), `MEMBER_CALLS` (khối đăng nhập, sau mục 14) | `fill()` dùng `MEMBER_CALL` cho `{ten}`. `bao` → "anh Bảo", `an3` → "chị Ba", `an7` → "chú 7", `thanh` → "Chủ tịt", còn lại → tên nhân vật. Xóa khi đăng xuất. `Store.name` vẫn là tên thật (HUD, nhật ký). v2.0.1-alpha |
| Lưu dữ liệu thành viên | `Store.useCloud(cloudPush)`, `cloudPush()`, `cloudFlush()`, `cloudFlushNow()` | Mọi `Store.patch` và `Store.setting` gọi `cloudPush()`: debounce 2 giây (v2.1.0-alpha; trước là 3 giây), rồi ghi hàng `progress` có điều kiện theo `updated_at`. Lỗi: thử lại sau 15 giây, thông báo nhẹ tối đa một lần mỗi phút. Lỗi quyền (42501, "permission denied"): thông báo riêng, xem §6.1. Khi `pagehide` và khi tab ẩn: `cloudFlushNow()` (keepalive). Một nơi hoạt động: §11 |
| Đăng xuất | `memberLogout()` | Lưu nốt, `signOut`, `Store.useLocal()` khôi phục dữ liệu Guest trên máy, `applyPlayerDesk(null)`, xóa `MEMBER_CALL` |
| Màn đăng nhập | `showLogin()` | Ô email, ô mật khẩu, "Đăng nhập", "🎮 Chơi Guest". Chỉ hiện khi `loginEnabled` bật. Từ v2.1.0-alpha, thay link email (v2.0.x). Chi tiết: `docs/spec/dang-nhap-cong-ty.md`. Nút Guest ghi `localStorage['mot-ngay.guest'] = '1'` |
| Popup chào | `showWelcomeBack()` | Thành viên: "Chào <tên>!" với "▶ Tiếp tục" và "🚪 Đăng xuất". Không hiện form đặt tên, kể cả sau "Về màn hình chính" |
| Nút ở màn chính | `btn-login` ("🔑 Đăng nhập công ty") | Mở màn đăng nhập. Ẩn khi `loginEnabled` tắt (mặc định với mọi người) |

### 9.2 Quy tắc dữ liệu

- Thành viên không ghi `localStorage`. `Store.persist()` gửi dữ liệu lên server thay cho việc ghi máy. Dữ liệu Guest trên máy không bị đổi.
- Thành viên ngồi ở bàn của nhân vật mình (v2.0.1-alpha). Các mục đồ mở khóa được dựng trên bàn đó. Bàn khách (góc dưới bên trái) không dùng khi đăng nhập.
- Cách gọi trong lời thoại (v2.0.1-alpha): `{ten}` thành "anh Bảo", "chị Ba", "chú 7", "Chủ tịt" theo `MEMBER_CALLS`, còn lại là tên nhân vật. Khách không có tên thì là "bạn". Giới hạn đã biết: câu bắt đầu bằng `{ten}` có chữ thường ("anh Bảo ơi…"), cần người Việt rà lại. `{anh}`/`{Anh}` vẫn theo giới tính của thành viên (nữ: `thao`, `yen`, `an3`).
- Sau khi chọn Guest, lần mở sau game vào thẳng dữ liệu Guest, không hiện màn đăng nhập. Muốn đăng nhập, dùng nút "🔑 Đăng nhập công ty" ở màn chính (chỉ hiện khi cờ `loginEnabled` bật).
- Cột `progress` nhận: `days`, `tasks_total`, `unlocked`, `affinity`, `diary`, `session` và `data` (`world`, `recentEv`, `lastTheme`, `settings`).
- Thành viên không nhận việc từ nhân vật của chính mình (`newWork()`), và nhân vật của chính mình không hỏi về tài liệu còn thiếu (lọc `DOC_QUESTS` trong `startDay()`).
- "Xóa dữ liệu" và "Xóa hết và chơi mới" gọi `Store.clear()`. Với thành viên, hành vi này chưa được thiết kế lại (xem `docs/tasks.md`, Known defects).

### 9.3 Tiêu chí chấp nhận

| ID | Tiêu chí | Trạng thái |
|---|---|---|
| AC-M1 | `index.html` có cú pháp hợp lệ | Verified (2026-11-04) |
| AC-M2 | Dự án Supabase truy cập được; email provider đã bật | Verified (probe, 2026-11-04) |
| AC-M3 | OTP gửi tới email chưa được mời bị từ chối ("Signups not allowed for otp") | Verified (probe, 2026-11-04) |
| AC-M4 | Các lệnh supabase-js 2.45.4 đã dùng chạy đúng với dự án thật | Verified (Node, 2026-11-04) |
| AC-M5 | Thành viên (mock, headless Chrome): ngày, việc, đồ đã mở, thân thiết, thế giới được khôi phục | Verified with mocked server (2026-11-04) |
| AC-M6 | Thành viên không ghi `localStorage`; dữ liệu Guest còn nguyên sau đăng xuất | Verified with mocked server (2026-11-04) |
| AC-M7 | NPC của nhân vật đăng nhập bị ẩn; nhân vật đó không giao việc cho chính mình | Verified with mocked server (2026-11-04) |
| AC-M8 | Guest chạy khi CDN của Supabase lỗi | Not verified (đọc mã nguồn, không chạy trình duyệt) |
| AC-M9 | Đăng nhập bằng link email thật, và link quay lại game | Verified by owner (2026-11-04, v2.0.0-alpha test) |
| AC-M10 | `claim_character()` trả đúng nhân vật theo email thật | Partly: the owner's login gave the right character (2026-11-04). Columns, function body, and RLS not re-checked by query |
| AC-M11 | Lưu tiến độ thật lên server, và tải lại sau khi đóng trình duyệt | Save: verified by owner (2026-11-04, after §6.1 grants). Reload after closing the browser: not verified |
| AC-M12 | Popup chào và màn đăng nhập hiển thị đúng về mặt hình ảnh | Not verified |
| AC-M13 | Import động của supabase-js qua CDN trong trình duyệt thật | Not verified |
| AC-M14 | Bản offline (`index-offline.html`, app Mac) cập nhật theo bản này | Not done (chủ dự án chưa yêu cầu). Xem `docs/spec/phan-phoi-offline.md` |
| AC-M15 | Thành viên ngồi đúng bàn nhân vật (ghế, điểm làm việc, tâm mặt bàn, đồ trên bàn): Bảo (bàn dài, phía nam), Toàn, Phú (phía bắc), Thảo (bàn riêng) | Verified (headless Chrome, 2026-11-04). Bảo's screenshot with 8 items and the tag looked right |
| AC-M16 | Ngồi làm việc ở bàn thành viên, qua thẻ công việc, đến đúng ghế | Verified (headless Chrome, 2026-11-04) |
| AC-M17 | Đăng xuất khôi phục bàn khách (góc dưới bên trái) | Verified (headless Chrome, 2026-11-04) |
| AC-M18 | Đồ trên bàn ở phía bắc của bàn dài quay đúng hướng về ghế | Not verified (chưa chụp ảnh) |
| AC-M19 | Mỗi nhân vật có bàn đúng (14 nhân vật) | Not verified (chỉ 4 nhân vật đã kiểm tra) |
| AC-M20 | Lời thoại `{ten}` dùng `MEMBER_CALLS` (anh Bảo, chị Ba, chú 7, Chủ tịt) | Code read only (2026-11-04). Not played |
| AC-M21 | Lỗi quyền 42501 hiện "⚠ Máy chủ chưa cấp quyền lưu tiến độ…"; sau khi cấp quyền, lưu hoạt động | Save after grants: verified by owner (2026-11-04). Toast text: code only, not seen |


## 10. Đăng nhập bằng mật khẩu (v2.1.0-alpha, 2026-11-04)

Chi tiết (luồng, thông báo lỗi, tạo tài khoản, cờ `loginEnabled`, tiêu chí AC-M22 đến AC-M32): `docs/spec/dang-nhap-cong-ty.md`.

Tóm tắt: email công ty và mật khẩu do quản trị viên tạo trong bảng điều khiển Supabase (Auto Confirm). Không gửi email nào. Luồng "quên mật khẩu", email khôi phục và màn tạo mật khẩu đã bỏ trong cùng bản v2.1.0-alpha. Màn đăng nhập và nút "🔑 Đăng nhập công ty" chỉ hiện khi cờ `loginEnabled` bật (trình duyệt đã mở game với `?login`).

## 11. Lưu tiến độ và một nơi hoạt động (v2.1.0-alpha, 2026-11-04)

Chi tiết phía đăng nhập và tiêu chí: `docs/spec/dang-nhap-cong-ty.md` §6 và AC-M33 đến AC-M39.

Lý do: chủ dự án mở hai tab cùng một tài khoản (một link cũ, một link có `?login`). Cả hai đã đăng nhập và mỗi tab ghi tiến độ của mình vài giây một lần, nên bên ghi sau cùng thắng. Hệ quả: sau đăng nhập, game báo "0 ngày" và quay về buổi sáng thứ Hai, dù hàng máy chủ có ngày dở (ngày 1, phút 695). Đây là nguyên nhân có khả năng nhất, chưa tái hiện trên máy chủ thật.

| Quy tắc | Cách làm | Hàm |
|---|---|---|
| Một nơi hoạt động | Mỗi tài khoản chỉ mở ở một tab hoặc thiết bị. Đăng nhập sau cùng giữ quyền ghi | `cloudEnter()` |
| Phiên bản ghi | `CLOUD.version` = `updated_at` đọc lúc đăng nhập, sau mỗi lần ghi thành công thì bằng giá trị máy chủ trả về. Keepalive cũng chỉ đổi khi máy chủ xác nhận; gửi lỗi thì giữ nguyên | `cloudApply()`, `cloudFlush()`, `cloudFlushNow()` |
| Ghi có điều kiện | Chỉ ghi nếu `updated_at` trên máy chủ vẫn bằng `CLOUD.version`. Không có hàng nào được cập nhật = xung đột | `cloudFlush()` |
| Xung đột | Đặt `CLOUD.conflict`, dừng mọi lần ghi (kể cả keepalive). Popup "⚠ Tài khoản đang được mở ở nơi khác", nút "🔄 Tải lại trang". Cũng mở popup khi phát hiện lúc tab ẩn (`cloudFlushNow()`) | `cloudConflict()` |
| Ghi ngay sau đăng nhập | Đánh dấu dữ liệu đã đổi rồi ghi một lần, để nơi vừa đăng nhập giành quyền | `cloudEnter()` |
| Lưu khi đóng hoặc ẩn tab | `fetch` PATCH với `keepalive: true`, header `apikey`, `Authorization: Bearer` (mã truy cập giữ mới bởi `onAuthStateChange`), `Prefer: return=representation`. Thân trên 60 000 byte (UTF-8, đếm bằng `TextEncoder`) thì dùng `cloudFlush()` thường. Đang có lần ghi (`CLOUD.busy`, kể cả keepalive đang gửi) thì không gửi, giữ `CLOUD.dirty` | `cloudFlushNow()` |
| Lưu nối tiếp | Một lần ghi tại một thời điểm (`CLOUD.busy`). Guest không gọi máy chủ | `cloudFlush()` |

- Ngày dở với "0 ngày" là bình thường: `days` và `tasks_total` chỉ tăng khi kết thúc ngày hoặc hoàn thành việc.
- Khôi phục: nếu `resumeSession()` lỗi, `G.resumeFailed` được đặt và nút tiếp tục hiện "⚠ Không khôi phục được ngày đang dở nên đã bắt đầu một ngày mới."
- Chẩn đoán (tạm thời): popup chào của thành viên thêm dòng "☁ Đã tải từ máy chủ: …" và dòng "(chẩn đoán: …)" đọc từ `CLOUD.loaded` (đặt trong `cloudApply()`). Gỡ khi chủ dự án xác nhận.
- Đã sửa (2026-11-04, cùng bản v2.1.0-alpha): `cloudEnter()` chạy `rebuildPlayer()` và `refreshTitle()` sau đăng nhập bằng mật khẩu; xung đột lúc tab ẩn mở popup; `CLOUD.version` chỉ đổi theo máy chủ xác nhận; giới hạn 60 000 đếm theo byte; `cloudFlushNow()` khi đang bận giữ `CLOUD.dirty`. Chi tiết: `docs/changelog.md` v2.1.0-alpha, `docs/tasks.md` (Known defects). Chưa kiểm tra trên máy chủ thật (AC-M33 đến AC-M36).

## 12. Giai đoạn 2: thấy nhau (v2.2.0-alpha, 2026-11-04)

Chi tiết (kênh, Presence, gói `pos`, hiển thị, NPC ẩn, tiêu chí AC-M40 đến AC-M53): `docs/spec/thay-nhau.md`.

Tóm tắt: thành viên đã đăng nhập vào kênh Realtime chung `office` (bắt đầu trong `cloudEnter()`, dừng trong `memberLogout()` và `cloudConflict()`). Vị trí gửi khoảng 3 lần mỗi giây khi đổi, cộng nhịp 10 s khi đứng yên, và không gửi khi đứng một mình. Số tin và hạn mức: `docs/spec/thay-nhau.md` §6. Người thật hiện bằng nhân vật của họ, NPC của họ bị ẩn đến hết ngày. Guest không tham gia. Chưa có chat, đồng hồ chung hay NPC dùng chung.

## 13. Hộp thư công ty, giai đoạn A (v2.2.0-alpha, 2026-11-04, commit `fa7ebf7`)

Chi tiết (bảng, luồng, giới hạn, tiêu chí AC-M59 đến AC-M69): `docs/spec/hop-thu-cong-ty.md`.

Tóm tắt: thành viên đã đăng nhập thấy ai đang online (chấm 🟢 trên nhãn NPC), có nút 📬 với huy hiệu tin chưa đọc, và đọc hộp thư (chỉ đọc). Dữ liệu nằm trong hai bảng `online` và `messages`, không dùng Realtime, để giữ trong hạn mức. SQL: `docs/sql/hop-thu.sql`, chủ dự án đã chạy (2026-11-04, bản đã sửa quyền `update` trên `online`). Luồng cơ bản (huy hiệu, toast, hộp thư) đã kiểm tra trên máy chủ thật. Chấm 🟢 với hai tài khoản thật chưa kiểm tra.
