# Hộp thư công ty (giai đoạn A và B1: online, soạn tin, giao việc)

Trạng thái: Giai đoạn A (v2.2.0-alpha, 2026-11-04) đã commit và đẩy lên `origin/main` (`fa7ebf7`; `537fd04` thêm nút 📬 và sửa quyền `online`). Chủ dự án đã chạy `docs/sql/hop-thu.sql` và xác nhận luồng cơ bản trên máy chủ thật. **Giai đoạn B1 và C đã viết trong `index.html` và `docs/sql/hop-thu-b.sql`, chưa commit.** Chủ dự án đã chạy `hop-thu-b.sql` trên máy chủ thật (2026-11-04, "Success. No rows returned"). B1 chưa được thử bằng hai tài khoản hoặc điện thoại. C chỉ kiểm tra bằng headless Chrome với máy khách giả lập. Giai đoạn B2 (NPC đưa tin), D, E, F chưa làm (§8). Tóm tắt và vị trí trong kế hoạch: `docs/spec/nhieu-nguoi-choi.md` §13.

Phạm vi hiện tại (A, B1, C): thành viên đã đăng nhập (sau `?login`) thấy ai đang online, thấy huy hiệu tin chưa đọc, đọc và soạn tin với đồng nghiệp, giao việc có hạn, tick "Xong", và nhận càm ràm cuối ngày kèm giấy nhớ trên bàn khi việc quá hạn. Guest không dùng tính năng này. Chưa có NPC đưa tin, khen nhanh, hay thông báo ngoài game.

## 1. Vì sao không dùng Realtime

Gói Supabase Free giới hạn 2 000 000 tin Realtime mỗi tháng (`docs/spec/thay-nhau.md` §6). Hộp thư không cần tức thời, nên máy khách hỏi bảng định kỳ qua REST. Cách này không tốn hạn mức Realtime. Chế độ "họp trực tiếp" dùng Realtime là tùy chọn của giai đoạn F.

## 2. Cài đặt máy chủ

Mở Supabase, chọn SQL Editor, dán toàn bộ `docs/sql/hop-thu.sql` rồi bấm Run. Có thể chạy lại an toàn (`create ... if not exists`, chính sách được xóa rồi tạo lại, hàm được thay thế).

Sau đó, giai đoạn B1: dán `docs/sql/hop-thu-b.sql` rồi bấm Run, **sau** `hop-thu.sql`. Cũng chạy lại được. File này thay trigger `messages_guard` (§4.4). Chủ dự án đã chạy (2026-11-04, không lỗi). Nếu chưa chạy thì các luật ở §4.4 chỉ có ở máy khách.

Trong dự án này, bảng mới không tự được cấp quyền. File SQL đã có lệnh `grant` cho vai trò `authenticated` (xem `docs/spec/nhieu-nguoi-choi.md` §6.1).

## 3. Thành phần

| Thành phần | Vị trí | Nội dung |
|---|---|---|
| Khối `MSG` | `index.html`, sau khối `RT`, trước `newDayState()` | Trạng thái: `timer`, `beatT`, `items` (tối đa 100 tin mới nhất), `online`, `unread`, `seen`, `primed`, `busy`, `failedAt`, `fails` |
| Trạng thái `MV` | `index.html`, khối `MSG` | Hộp thư: `mode` (`list`, `pick`, `thread`), `who` (người đang chat), `draft` (nháp), `task` (công tắc giao việc), `due` (hạn đã chọn), `sending` |
| `msgStart()` / `msgStop()` | khối `MSG` | Bắt đầu và dừng hỏi định kỳ. Gọi trong `cloudEnter()`, `memberLogout()`, `cloudConflict()` (như giai đoạn A) |
| `msgTick()` | khối `MSG` | Một lần hỏi: ghi online, đọc `online` và `messages`, cập nhật huy hiệu, toast, chấm xanh, toast việc đã xong, làm mới hộp thư đang mở |
| `msgSetBadge()`, `msgApplyOnline()`, `msgOnVisible()` | khối `MSG` | Huy hiệu 📬, chấm 🟢 trên nhãn NPC, hỏi ngay khi tab hiện lại |
| `msgOpenInbox()` | khối `MSG` | Mở hộp thư ở danh sách hội thoại (`msgRender()`) |
| `msgRender()` | khối `MSG` | Vẽ danh sách hội thoại, màn chọn người (`pick`), hoặc chuyển sang `msgRenderThread()` |
| `msgRenderThread()` | khối `MSG` | Vẽ khung chat với một người: tin, việc (ô Xong), ô soạn, công tắc giao việc, nút Gửi |
| `msgSend(to, text, task, due)` | khối `MSG` | Thêm dòng `chat` hoặc `task` (insert). Thành công: xóa nháp, tắt công tắc việc |
| `msgSetDone(x, done)` | khối `MSG` | Đặt hoặc bỏ `done` và `done_at` (update) |
| `msgMarkRead(who)` | khối `MSG` | Đặt `read_at` cho tin chưa đọc từ người đó |
| `msgModal(...)` | khối `MSG` | Mở popup và gắn `data-mail` để lần hỏi chỉ làm mới đúng hộp thư |
| `msgFriendly(e)` | khối `MSG` | Đổi lỗi thành câu tiếng Việt (§4.4, §6) |
| `#b-mail`, `#mail-dot` | `index.html`, HUD | Nút 📬 ở thanh trên, bên phải, trước nút 🎥. Chấm đỏ có số tin chưa đọc |
| `docs/sql/hop-thu.sql` | `docs/sql/` | Hàm `my_char()`, bảng `online` và `messages`, chỉ mục, RLS, quyền (giai đoạn A) |
| `docs/sql/hop-thu-b.sql` | `docs/sql/` | Trigger `messages_guard` và hàm của nó: luật gửi, giới hạn, quyền đọc và Xong (B1) |

## 4. Dữ liệu

### 4.1 Bảng `online`

| Cột | Kiểu | Ý nghĩa |
|---|---|---|
| `char_id` | text, khóa chính | Id nhân vật |
| `last_seen` | timestamptz | Lần ghi cuối |

Một dòng cho mỗi nhân vật. Đang online = có dòng với `last_seen` trong 3 phút gần nhất.

### 4.2 Bảng `messages`

| Cột | Kiểu | Ý nghĩa |
|---|---|---|
| `id` | uuid, khóa chính | Mã tin |
| `thread_id` | uuid, có thể rỗng | Chưa dùng. Cuộc trò chuyện hiện là cặp hai người |
| `from_char`, `to_char` | text | Người gửi, người nhận (không được trùng nhau) |
| `kind` | `chat`, `task` hoặc `note` | Tin thường, việc giao, giấy nhớ càm ràm (`note`, giai đoạn C, §8.1) |
| `body` | text, 1 đến 300 ký tự | Nội dung |
| `due` | `today`, `tomorrow`, `none` hoặc rỗng | Hạn của việc (chỉ `task`). Máy chủ đặt `today` nếu trống. Đây là nhãn, không lưu ngày (§7) |
| `done`, `done_at` | boolean, timestamptz | Việc đã xong (chỉ `task`). Người nhận đặt khi tick. Cả hai bên đặt lại được khi mở lại |
| `read_at` | timestamptz | Người nhận đã mở xem cuộc trò chuyện |
| `ref` | uuid, có thể rỗng | Giấy nhớ trỏ về việc gốc. Chỉ `note`, tối đa một giấy nhớ cho mỗi việc |
| `created_at` | timestamptz | Thời điểm gửi |

Chỉ mục: `messages_one_note_per_task` (duy nhất theo `ref` khi `kind = 'note'`), `messages_to_idx`, `messages_from_idx`.

### 4.3 Hàm `my_char()`

Trả về `char_id` trong bảng `progress` của người đang đăng nhập (`auth.uid()`). Khai báo `security definer` với `search_path = public`. Quyền thực thi cấp cho `authenticated`.

### 4.4 Quyền truy cập (RLS, GRANT và trigger)

| Bảng | Đọc | Ghi |
|---|---|---|
| `online` | Mọi thành viên đã đăng nhập | Thêm và sửa dòng có `char_id` của mình (quyền `update` cả bảng, xem Lỗi đã sửa dưới đây) |
| `messages` | Chỉ tin mình gửi hoặc mình nhận | Thêm: `chat` và `task` chỉ dưới tên mình. `note`: khi mình là người nhận. Sửa: chỉ cột `done`, `done_at`, `read_at` (quyền cột) |

Quyền cột: `authenticated` chỉ sửa được `done`, `done_at`, `read_at` trên `messages`, nên nội dung, người gửi và người nhận không đổi được.

Trước B1, RLS cho cả hai bên đặt `done` và `read_at`. Trigger `messages_guard` (`docs/sql/hop-thu-b.sql`) siết lại theo bên:

| Luật | Nội dung |
|---|---|
| Gửi `chat` và `task` | Chỉ dưới tên nhân vật của mình (`from_char = my_char()`) |
| Tần suất | Tối đa 10 tin trong 1 phút (đếm mọi tin có người gửi là mình; kiểm tra khi gửi `chat` hoặc `task`), và 5 việc `task` trong 24 giờ liên tục. Vượt thì báo `rate_limit` hoặc `task_limit` |
| Hạn mặc định | `task` không có hạn thì đặt `today`. `chat` có hạn rỗng |
| Đặt sẵn khi tạo | `done`, `done_at`, `read_at` được đặt về rỗng khi tạo tin, dù máy khách gửi giá trị gì |
| Đã đọc | Chỉ người nhận đặt được `read_at` |
| Xong | Chỉ người nhận đặt `done = true`, và chỉ với `task`. Cả hai bên đặt `done = false` (mở lại) được |

Máy khách đổi các lỗi trên thành câu tiếng Việt trong `msgFriendly()`. Với `note`, trigger không kiểm tra người gửi, tần suất hay `ref` (§8.1, AC-M88). Luật chạy được trên máy chủ (2026-11-04), nhưng chưa thử đủ (AC-M75).

**Lỗi đã sửa (2026-11-04, giai đoạn A):** bản đầu chỉ cấp `grant update (last_seen) on public.online`. Upsert ghi cả `char_id`, nên máy chủ thật trả lỗi 403 / 42501 "permission denied for table online" khi ghi online. Bản sửa: `grant update on public.online to authenticated` (cả bảng). RLS vẫn chỉ cho sửa dòng có `char_id` của mình. Bài kiểm thử giả lập đã bỏ sót lỗi này; chủ dự án phát hiện trong console trình duyệt.

## 5. Luồng hoạt động

| Việc | Cách làm |
|---|---|
| Bắt đầu | Đăng nhập thành viên: `msgStart()` hỏi ngay, sau đó mỗi 25 giây |
| Hỏi định kỳ | Mỗi 25 giây, chỉ khi tab đang hiện. Khi tab hiện lại, hỏi ngay |
| Ghi online | Lần hỏi kế tiếp ghi `online` (upsert) nếu đã quá 55 giây từ lần ghi trước. Kiểm tra chạy theo nhịp 25 giây, nên thực tế ghi khoảng mỗi 75 giây (§7) |
| Đọc dữ liệu | `online` (dòng trong 3 phút gần nhất), và `messages` (tối đa 100 dòng, mới nhất trước) |
| Tin mới | Tin gửi đến mình, chưa đọc, chưa thấy ở lần hỏi trước. Toast 3,5 giây "📬 <tên>: <40 ký tự đầu>…", chỉ khi đang chơi. Lần hỏi đầu sau đăng nhập không có toast |
| Mở cuộc trò chuyện | `msgMarkRead(who)` đặt `read_at` cho tin chưa đọc từ người đó. Không có tin chưa đọc thì không gửi yêu cầu. Giai đoạn A đánh dấu tất cả một lúc |
| Soạn và gửi | Ô tối đa 300 ký tự, cắt khi gửi và bỏ khoảng trắng đầu cuối. Chỉ gửi khi có chữ và không đang gửi (`MV.sending`). Gửi xong xóa nháp và tắt công tắc việc |
| Giao việc | Bật "Đây là việc cần làm", chọn hạn (hôm nay, ngày mai, không hạn; mặc định hôm nay). Gửi `kind = task`. Sau khi gửi, công tắc tắt lại; hạn giữ lần chọn cuối |
| Xong | Người nhận tick ô "Xong": đặt `done` và `done_at`, có âm thanh và toast "✅ Đã báo xong việc". Người giao bấm "↩ Mở lại" để đặt `done = false`. Người nhận cũng bỏ tick được |
| Báo việc xong cho người giao | Khi việc mình giao chuyển sang xong (phát hiện ở lần hỏi, không báo ở lần hỏi đầu, chỉ khi đang chơi): toast "✅ <tên> đã xong: <40 ký tự đầu>" |
| Làm mới hộp thư | Lần hỏi vẽ lại hộp thư chỉ khi popup hộp thư đang mở, chưa mở màn "Tin mới", nháp trống, và ô nhập không có con trỏ |
| Lỗi | Ghi `dlog` (chỉ khi chạy trên localhost hoặc có `?debug`). Sau lỗi thứ n, chờ 25 giây × 2^n trước khi hỏi lại: 50 giây, 100 giây, 200 giây, tối đa 300 giây (5 phút). Thành công thì đặt lại về 0. Lỗi gửi và tick hiện thông báo tiếng Việt (`msgFriendly()`). Lỗi đánh dấu đã đọc chỉ ghi nhật ký |
| Dừng | Đăng xuất, hoặc xung đột "đang được mở ở nơi khác": dừng hỏi, bỏ lắng nghe tab, xóa dữ liệu trong bộ nhớ, ẩn huy hiệu và chấm xanh |

Ước tính lượng yêu cầu REST (chưa đo): một thành viên có tab đang hiện gửi 2 truy vấn đọc mỗi 25 giây (4,8 yêu cầu/phút) và khoảng 1 lần ghi online mỗi 75 giây (0,8 yêu cầu/phút). Tổng khoảng 5,6 yêu cầu/phút. Tab ẩn: không gửi. B1 thêm yêu cầu ghi khi gửi, tick, mở lại và đánh dấu đã đọc; số này phụ thuộc hành vi nên chưa ước lượng. Giới hạn REST của gói Free chưa được kiểm tra.

## 6. Giao diện

- **Nút 📬** (`#b-mail`, emoji cỡ 28 px): hiện ngay khi thành viên đã đăng nhập, kể cả khi lần hỏi đầu lỗi. Chấm đỏ hiện số tin chưa đọc (trên 9 hiện "9+", bằng 0 thì ẩn). Chỉ bấm được ở chế độ chơi. Đã thử 💬 nhưng bị loại: giống nút "Nói chuyện" (`docs/spec/mot-ngay-o-cong-ty.md` §4.2).
- **Chấm 🟢** sau tên trên nhãn NPC: nhân vật đang online (trừ chính mình). Nhãn của người thật đang hiện trong `RT.peers` (giai đoạn 2) chưa có chấm này (§7).
- **Popup "📬 Hộp thư" (danh sách)**: mỗi người có một dòng: tên (🟢 nếu online), thời gian, số tin mới, số việc chưa xong, và tin mới nhất (tiền tố "Bạn: " nếu mình gửi). Chưa có tin: "Chưa có tin nào. Bấm “Tin mới” để nhắn hoặc giao việc cho đồng nghiệp." Nút "✏ Tin mới" và "Đóng".
- **"✏ Gửi cho ai?"**: nút tên mọi nhân vật trừ mình, 🟢 khi đang online. Nút "← Quay lại". Người không online vẫn nhận được tin khi họ vào game.
- **Cuộc trò chuyện**: tin hai bên theo thời gian (tin mình nền hồng). Việc có viền đậm, dòng "📌 Việc (hạn: …)", nội dung, và: ô "Xong" nếu mình là người nhận, "⏳ Chờ làm" nếu chưa xong, "✅ Đã xong · <giờ>" nếu xong. Nút "↩ Mở lại" hiện cho người giao khi việc đã xong. Ô nhập tối đa 300 ký tự; công tắc "Đây là việc cần làm, hạn [hôm nay ▾]"; nút "Gửi" đổi thành "📌 Giao việc" khi bật công tắc; nút "← Danh sách".
- **Văn bản và lỗi**: tin luôn hiện dưới dạng chữ (`h()`, `textContent`; đã kiểm tra với HTML, mock). Lỗi hiện câu tiếng Việt từ `msgFriendly()` ("Bạn gửi hơi nhanh…", "Hôm nay bạn đã giao đủ 5 việc…", "Không kết nối được…", còn lại "Chưa gửi được…"). Chi tiết chỉ vào nhật ký gỡ lỗi.

## 7. Giới hạn đã biết

- **Luật máy chủ chưa thử đủ**: `hop-thu-b.sql` đã chạy, nhưng giới hạn 10 tin, 5 việc, quyền Xong và quyền đọc chưa thử với hai tài khoản thật (AC-M75). Với `note`, máy chủ chỉ kiểm tra RLS (§8.1). Người cố ý vẫn vượt được.
- **Nhịp ghi online**: thực tế khoảng 75 giây, không phải 55 giây như thiết kế (kiểm tra theo nhịp 25 giây). Cửa sổ 3 phút vẫn đủ. Tab ẩn hoặc máy ngủ không ghi online, nên sau khoảng 3 phút người khác thấy ngoại tuyến. Chủ dự án quyết định có đổi ngưỡng không.
- **Chưa chạy `hop-thu.sql`** (ví dụ ở máy chủ khác): nút 📬 vẫn hiện, hộp thư báo "Chưa có tin nào", không có chấm xanh, và lỗi chỉ có trong nhật ký gỡ lỗi.
- **Số lượng tin**: huy hiệu, toast và cuộc trò chuyện chỉ dùng 100 tin mới nhất. Tin cũ hơn không hiện, không đếm được là chưa đọc, và việc cũ hơn không tick hay mở lại được.
- **Hạn việc là nhãn**: `today` và `tomorrow` không lưu ngày. Việc giao hôm qua với hạn "hôm nay" vẫn hiện "hôm nay" và được nhắc ở mọi lần kết thúc ngày cho đến khi xong (§8.1).
- **Giờ xong và giới hạn**: `done_at` do máy khách gửi (sai nếu đồng hồ máy sai). Giới hạn 5 việc là trượt 24 giờ. Giới hạn 10 tin mỗi phút đếm mọi tin có người gửi là mình.
- **Làm mới khi đang gõ**: hộp thư không tự cập nhật khi nháp còn chữ. Tin mới hiện sau khi gửi hoặc xóa nháp.
- **Nhãn người thật**: chấm 🟢 không hiện trên nhãn của người thật (`rtPeer()`, giai đoạn 2).
- **Hàm `my_char()`**: có thể được gọi bởi vai trò `anon` nếu dự án cấp quyền mặc định. Với khách không có `auth.uid()` nên hàm trả về rỗng. Chưa kiểm tra bằng truy vấn.
- **Quyền riêng tư**: chủ dự án đọc được mọi tin qua bảng điều khiển Supabase. Cần báo cho thành viên trước khi dùng.
- **Bàn phím điện thoại**: chưa kiểm tra. Bàn phím có thể che ô soạn và nút Gửi.

## 8. Các giai đoạn tiếp theo

Theo quyết định với chủ dự án (2026-11-04). Các giai đoạn này chia nhỏ giai đoạn 5 trong `docs/spec/nhieu-nguoi-choi.md` §5.

| Giai đoạn | Nội dung | Ghi chú |
|---|---|---|
| B1 (đã làm, chưa commit) | Soạn tin theo cuộc trò chuyện (300 ký tự). Giao việc có hạn (hôm nay, ngày mai, không hạn; mặc định hôm nay). Tick "Xong", mở lại, toast báo xong. Luật máy chủ `docs/sql/hop-thu-b.sql` | Kiểm tra bằng máy khách giả lập. SQL đã chạy trên máy chủ (2026-11-04, AC-M70). Chưa thử hai tài khoản (AC-M65, AC-M75, AC-M77, AC-M80) |
| B2 (chưa làm) | NPC đưa tin chạy đến bàn người chơi | Chưa có người đưa tin trong game. Thứ tự so với giai đoạn 3 chưa quyết: hỏi chủ dự án trước khi làm (`docs/handoff.md` §6) |
| C (đã làm, chưa commit) | Càm ràm cuối ngày: việc quá hạn, chưa xong, chưa có giấy nhớ, làm người giao nhắc khi người nhận kết thúc ngày. Giấy nhớ (`kind = note`) hiện trên bàn người nhận. Chi tiết §8.1 | Kiểm tra bằng máy khách giả lập. Máy chủ chưa kiểm tra `note` (AC-M88). Chưa làm: tóm tắt đầu ngày, mốc 48 giờ "lỡ" (AC-M89) |
| D | Nút khen nhanh (chọn sẵn) và càm ràm nhanh. Chat nhanh chọn sẵn hoặc tự gõ | Dùng lại luật tần suất và quyền của §4.4 |
| E | Thông báo ngoài game: email qua Supabase, hoặc Web Push | Web Push trên iPhone cần cài game như ứng dụng web |
| F | Tùy chọn "họp trực tiếp": bật Realtime của giai đoạn 2 khi cần | Không bật mặc định, để giữ trong hạn mức |

### 8.1 Giai đoạn C: càm ràm cuối ngày và giấy nhớ (đã làm, chưa commit)

Mã: khối `MSG` (`taskOverdue()`, `msgDeskNotes()`, `msgNagFlow()`, `msgReadDeskNotes()`), `endDay()`, `workActivity()` và `buildDeskItems()` (`index.html`).

- **Khi nào**: `endDay()` gọi `msgNagFlow()` trước nhắc của NPC. Mọi lần kết thúc ngày đều chạy (18:00 hoặc về sớm). Có nhắc từ người thì bỏ qua nhắc NPC (`workNag`). Tối đa một lần mỗi ngày.
- **Chọn việc**: việc `task` gửi cho mình, chưa `done`, quá hạn (`taskOverdue`), và chưa có giấy nhớ (`ref`). Lấy việc cũ nhất. `none` không bao giờ quá hạn; `tomorrow` quá hạn từ ngày lịch kế tiếp (so `created_at` theo ngày máy); `today` quá hạn ở mọi lần kết thúc ngày cho đến khi xong (code không so ngày, nên không khớp ý "hết ngày giao" của kế hoạch).
- **Không nhắc khi**: chưa hỏi máy chủ lần nào (`MSG.primed`), không có máy khách, đang xung đột, hoặc không tìm thấy NPC người giao.
- **Hiệu ứng**: một dòng `WORK_NAG[người giao]` kèm “(Việc: “tiêu đề”)”, tối đa 300 ký tự. Thiện cảm −aff, tâm trạng −mood, `D.stats.nagged` +1, một khoảnh khắc nhật ký, bong bóng lời, thẻ. Nút “Dạ, em xin lỗi, mai em làm” không cộng lại thiện cảm (khác `workNag`).
- **Giấy nhớ**: máy người nhận ghi `kind = note`, `from_char` = người giao, `to_char` = mình, `ref` = mã việc. Lỗi 23505 (đã có giấy nhớ cho việc) bỏ qua. Việc đã có giấy nhớ không bị nhắc lại.
- **Hiển thị**: tối đa 3 tờ vàng chưa đọc trên bàn của mình. Thẻ bàn làm việc có “📝 Đọc giấy nhớ trên bàn (n)” đầu tiên: đặt `read_at`, dựng lại bàn. Bàn dựng lại khi tập giấy nhớ chưa đọc đổi (lần hỏi).
- **Người giao**: toast khi giấy nhớ mình giao xuất hiện. Thấy giấy nhớ trong hội thoại với người nhận (nền vàng).
- **Khác kế hoạch cũ**: người giao cũng thấy giấy nhớ (chưa quyết; kế hoạch cũ chỉ người nhận). Chưa có tóm tắt đầu ngày, chưa có mốc 48 giờ "lỡ" (AC-M89).

## 9. Tiêu chí chấp nhận

| ID | Tiêu chí | Trạng thái |
|---|---|---|
| AC-M59 | `docs/sql/hop-thu.sql` chạy không lỗi trong SQL Editor (chạy một lần) | Verified by owner (2026-11-04), with the corrected `online` grant (§4.4) |
| AC-M60 | Chấm 🟢 hiện trên nhãn NPC của người đang online | Verified (mocked client, headless Chrome, 2026-11-04). Real server: not verified |
| AC-M61 | Tin mới hiện huy hiệu và toast. Mở hộp thư đánh dấu đã đọc | Verified (mocked client, 2026-11-04). Real server: verified by owner (2026-11-04), huy hiệu, toast và hộp thư |
| AC-M62 | Lỗi liên tiếp: chờ 50 s, 100 s, 200 s, tối đa 300 s. Thành công thì đặt lại | Verified (mocked client, 2026-11-04) |
| AC-M63 | Đăng xuất và xung đột: dừng hỏi, xóa huy hiệu và chấm xanh | Verified (mocked client, 2026-11-04) |
| AC-M64 | Tin chứa HTML hiện dạng chữ | Verified (mocked client, 2026-11-04) |
| AC-M65 | RLS: thành viên không đọc được tin của cặp khác, không gửi được tin dưới tên người khác | Not verified (cần hai tài khoản thật) |
| AC-M66 | Chỉ hỏi máy chủ khi tab đang hiện. Hiện lại thì hỏi ngay | Code read only (2026-11-04) |
| AC-M67 | Toast chỉ hiện ở chế độ chơi, không hiện khi đang mở menu | Code read only (2026-11-04) |
| AC-M68 | Hai tài khoản thật: thấy chấm xanh và huy hiệu của nhau. Chấm tắt khoảng 3 phút sau khi đóng tab | Not verified |
| AC-M69 | Số yêu cầu thực tế với 3 người trở lên khớp ước tính §5 | Not measured |
| AC-M70 | `docs/sql/hop-thu-b.sql` chạy không lỗi sau `hop-thu.sql` (chạy một lần) | Verified by owner (2026-11-04): "Success. No rows returned" |
| AC-M71 | Hộp thư trống hiện "Chưa có tin nào" và nút "Tin mới" | Verified (mocked client, headless Chrome, 2026-11-04) |
| AC-M72 | Màn "Gửi cho ai?": 🟢 hiện đúng người đang online | Verified (mocked client, 2026-11-04) |
| AC-M73 | Tin chứa HTML hiện dạng chữ trong cuộc trò chuyện | Verified (mocked client, 2026-11-04) |
| AC-M74 | Giao việc gửi `kind = task` kèm hạn đã chọn. Sau khi gửi, công tắc tắt | Insert with due verified (mocked client). Toggle reset: code read only |
| AC-M75 | Luật máy chủ: chỉ gửi dưới tên mình, 10 tin/phút và 5 việc/24 giờ, `done` và `read_at` đặt sẵn bị đặt về rỗng, chỉ người nhận đọc và tick, cả hai mở lại được | Not verified (SQL ran 2026-11-04; the rules are not yet tested on the real server) |
| AC-M76 | Vượt giới hạn hiện thông báo tiếng Việt, không lộ lỗi kỹ thuật | Rate-limit toast verified (mocked client). Real server: not verified |
| AC-M77 | Người nhận tick "Xong", người giao thấy "✅ Đã xong" và nhận toast, bấm "↩ Mở lại" được | Tick and done text verified (mocked client). Sender toast and reopen: code read only. Two real accounts: not verified |
| AC-M78 | Làm mới hộp thư không ghi đè nháp đang gõ | Code read only (2026-11-04) |
| AC-M79 | Mở cuộc trò chuyện đánh dấu đã đọc đúng tin của người đó | Code read only (2026-11-04) |
| AC-M80 | Trên điện thoại, bàn phím không che ô soạn và nút Gửi | Not verified |
| AC-M81 | Quá hạn theo nhãn: `none` không bao giờ; `tomorrow` từ ngày lịch kế tiếp; `today` ở mọi lần kết thúc ngày cho đến khi xong (§8.1) | Verified (mocked client, headless Chrome) |
| AC-M82 | Cuối ngày, người giao nhắc đúng một lần: thiện cảm giảm (−1 cho người giao được thử), giấy nhớ ghi với `ref` đúng việc | Partly verified (mocked client: note with `ref`, affinity −1). Mood, diary, card: code read only |
| AC-M83 | Lần kết thúc ngày thứ hai không nhắc. Việc đã có giấy nhớ không bị nhắc lại (chỉ mục duy nhất, lỗi 23505 bỏ qua) | Second nag skipped: verified (mocked client). Unique index path: code read only |
| AC-M84 | Thẻ bàn làm việc có "📝 Đọc giấy nhớ trên bàn (n)". Chọn thì hiện nội dung và đặt `read_at` | Verified (mocked client, headless Chrome) |
| AC-M85 | Tối đa 3 tờ vàng chưa đọc trên bàn, không che các món khác | Not verified: papers present in the mocked scene, no screenshot |
| AC-M86 | Người giao thấy giấy nhớ trong hội thoại (nền vàng) và toast khi giấy nhớ xuất hiện | Code read only |
| AC-M87 | Hai tài khoản thật: người giao offline, người nhận nhận nhắc và ghi giấy nhớ, giấy nhớ hiện ở cả hai bên. RLS cho ghi `note` khi `to_char` là mình | Not verified |
| AC-M88 | Luật máy chủ cho `note`: người gửi là người giao, `ref` là việc của người nhận, giới hạn tần suất | Not built (trigger does not check `note`, §7) |
| AC-M89 | Việc quá 48 giờ thực chuyển sang "lỡ" (§8, giai đoạn C) | Not built |
