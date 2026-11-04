# Chế độ nhiều người chơi (Supabase)

Trạng thái: Giai đoạn 1 đã triển khai, chưa kiểm thử với đăng nhập thật (v2.0.0-alpha, 2026-11-04). Giai đoạn 2 đến 6 chưa bắt đầu. Chi tiết triển khai giai đoạn 1: §9. Tài liệu này ghi các quyết định của chủ dự án để các phiên làm việc sau không phải hỏi lại.

## 1. Mục tiêu

Nhân viên MinhLee (tối đa 14 người, đúng 14 nhân vật hiện có) đăng nhập bằng email công ty và chơi chung một văn phòng. Nhân vật nào chưa có người đăng nhập thì chạy AI như NPC; người đăng nhập thì thay thế NPC đó.

## 2. Quyết định của chủ dự án

| # | Chủ đề | Quyết định |
|---|---|---|
| 1 | Đăng nhập | Email công ty. Mỗi email gắn với đúng một nhân vật trong game (bảng `roster`). Tối đa 14 người online. |
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

- Kênh theo ngày game. Presence: ai đang online. Broadcast: vị trí và trạng thái người chơi (khoảng 5–10 lần mỗi giây), vị trí NPC do máy chủ NPC phát, chat, giao việc.
- Kênh riêng (private) chỉ cho người đã đăng nhập.

## 5. Các giai đoạn

1. **Đăng nhập và lưu trên server** — *Đã triển khai, chưa kiểm thử với đăng nhập thật (v2.0.0-alpha, 2026-11-04).* Đăng nhập, gắn nhân vật theo email, lưu tiến độ lên `progress`, chế độ Guest. Game đơn lẻ vẫn chạy. Chi tiết: §9.
2. **Thấy nhau**: Presence và vị trí người chơi thật; NPC của người đang online bị ẩn, người chơi hiển thị bằng nhân vật tương ứng.
3. **Đồng hồ và NPC dùng chung**: giờ chung, máy chủ NPC, sự kiện cùng lúc (mời nước, họp, tan ca).
4. **Việc theo bộ phận và chỉ số công ty**: kho việc riêng theo bộ phận, chỉ số chung tăng khi hoàn thành.
5. **Chat, giao việc giữa người, khen và càm ràm**: chọn nhanh hoặc tự gõ; máy tự chọn khi không gõ.
6. **Hoàn thiện và thử với người thật**: mất kết nối, vào giữa ngày, lỗi mạng.

## 6. Việc cần chuẩn bị (chủ dự án)

Xem hướng dẫn trong cuộc trao đổi: tạo dự án Supabase (vùng Singapore), tắt tự đăng ký, mời 14 email, cấu hình SMTP riêng, chạy SQL tạo bảng. Gửi lại: Project URL, anon key, link nơi đặt game.

Trạng thái (2026-11-04): chủ dự án báo đã làm xong phần cấu hình server (bảng, hàm, RLS, 14 email được mời, SMTP riêng, Site URL và Redirect URL). Chưa xác nhận lại bằng truy vấn: tên cột của `progress`, nội dung hàm `claim_character()`, và RLS. Xem `docs/tasks.md`.

## 7. Rủi ro và điểm cần lưu ý

- Nhân vật người chơi hiện tách riêng với 14 NPC. Cần cho phép người chơi dùng ngoại hình và vai của một nhân vật có sẵn.
- Một số cơ chế hiện có dựa vào một người chơi duy nhất (thẻ nhiệm vụ, sự kiện bất ngờ gần người chơi, lời nhắc cuối ngày) cần định nghĩa lại cho nhiều người.
- NPC có thể hơi giật hoặc lệch giữa các máy khi dùng máy chủ NPC.
- Dự án Supabase miễn phí bị tạm dừng nếu 1 tuần không ai dùng.
- Nhiệm vụ cá nhân, việc theo bộ phận và hậu quả của việc quên cần cân bằng sau khi chơi thử với người thật.

## 8. Câu hỏi còn mở

1. Guest chơi một mình hay vào văn phòng chung? (mặc định: một mình)
2. Đồng hồ chung không tạm dừng được: chấp nhận không?
3. Bỏ hay giữ chế độ ngồi làm việc (time-lapse) trong chế độ chung?

## 9. Giai đoạn 1: đã triển khai (v2.0.0-alpha, 2026-11-04)

Phạm vi: đăng nhập bằng email, nhận nhân vật theo email, lưu tiến độ lên server, chế độ Guest. Chưa có: thấy người chơi khác, đồng hồ chung, chat, giao việc giữa người (giai đoạn 2 đến 6).

### 9.1 Thành phần

| Thành phần | Vị trí | Nội dung |
|---|---|---|
| Hằng số kết nối | `index.html`, cạnh `CHAR_GENDER` | `SUPABASE_URL`, `SUPABASE_KEY` (khóa publishable, công khai theo thiết kế; dữ liệu được bảo vệ bằng RLS). Không đưa khóa secret hay service_role vào mã nguồn |
| Thư viện | `index.html`, importmap | `@supabase/supabase-js@2.45.4` qua jsDelivr `+esm`. Nạp lười bằng `await import()`. Nếu CDN lỗi, game vẫn chạy ở chế độ Guest |
| Trạng thái đăng nhập | `MEMBER` (`{char}`), `CLOUD` (client, user, timer, dirty, failedAt) | `MEMBER` là null khi chưa đăng nhập |
| Khởi động | `cloudBoot()` | Có phiên đăng nhập: `cloudClaim()`, rồi `cloudApply(row)`. Không có phiên và chưa chọn Guest: màn đăng nhập `showLogin()`. Đã chọn Guest, hoặc không tải được thư viện: `showWelcomeBack()` của Guest |
| Nhận nhân vật | `cloudClaim()` gọi RPC `claim_character()` | Server ánh xạ email sang nhân vật qua bảng `roster`, tạo hàng `progress` nếu chưa có. Nếu lỗi, đăng xuất và hiện màn đăng nhập kèm thông báo nhờ quản trị viên kiểm tra |
| Áp dụng nhân vật | `cloudApply(row)` | Tên = tên thật của nhân vật. Giới tính lấy từ `CHAR_GENDER`. Ngoại hình = ngoại hình của NPC (`rebuildPlayer`). NPC của chính nhân vật đó có `times.arrive = 99999` mỗi ngày (`startDay()`) |
| Lưu dữ liệu thành viên | `Store.useCloud(cloudPush)`, `cloudPush()`, `cloudFlush()` | Mọi `Store.patch` và `Store.setting` gọi `cloudPush()`: debounce 3 giây, rồi cập nhật hàng `progress`. Lỗi: thử lại sau 15 giây, thông báo nhẹ tối đa một lần mỗi phút. Lưu thêm khi `pagehide` và `visibilitychange` |
| Đăng xuất | `memberLogout()` | Lưu nốt, `signOut`, `Store.useLocal()` khôi phục dữ liệu Guest trên máy |
| Màn đăng nhập | `showLogin()` | Ô email và "✉️ Gửi link đăng nhập" (`signInWithOtp`, `shouldCreateUser: false`, chuyển hướng về địa chỉ trang). Nút "🎮 Chơi Guest (nhân viên mới)" ghi `localStorage['mot-ngay.guest'] = '1'` |
| Popup chào | `showWelcomeBack()` | Thành viên: "Chào <tên>!" với "▶ Tiếp tục" và "🚪 Đăng xuất". Không hiện form đặt tên, kể cả sau "Về màn hình chính" |
| Nút ở màn chính | `btn-login` ("🔑 Đăng nhập công ty") | Mở màn đăng nhập |

### 9.2 Quy tắc dữ liệu

- Thành viên không ghi `localStorage`. `Store.persist()` gửi dữ liệu lên server thay cho việc ghi máy. Dữ liệu Guest trên máy không bị đổi.
- Sau khi chọn Guest, lần mở sau game vào thẳng dữ liệu Guest, không hiện màn đăng nhập. Muốn đăng nhập, dùng nút "🔑 Đăng nhập công ty" ở màn chính.
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
| AC-M9 | Đăng nhập bằng link email thật, và link quay lại game | Not verified |
| AC-M10 | `claim_character()` trả đúng nhân vật theo email thật (cột và hàm trên server chưa xác nhận lại) | Not verified |
| AC-M11 | Lưu tiến độ thật lên server, và tải lại sau khi đóng trình duyệt | Not verified |
| AC-M12 | Popup chào và màn đăng nhập hiển thị đúng về mặt hình ảnh | Not verified |
| AC-M13 | Import động của supabase-js qua CDN trong trình duyệt thật | Not verified |
| AC-M14 | Bản offline (`index-offline.html`, app Mac) cập nhật theo bản này | Not done (chủ dự án chưa yêu cầu). Xem `docs/spec/phan-phoi-offline.md` |
