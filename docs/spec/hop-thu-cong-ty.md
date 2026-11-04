# Hộp thư công ty (giai đoạn A: ai đang online và hỏi tin mới)

Trạng thái: Giai đoạn A đã viết trong `index.html` (khối `MSG`, v2.2.0-alpha, 2026-11-04), **chưa commit**. Chưa chạy trên Supabase thật: chủ dự án phải chạy `docs/sql/hop-thu.sql` một lần trước khi tính năng hoạt động. Chỉ kiểm tra bằng headless Chrome với máy khách Supabase giả lập. Giai đoạn B đến F chưa làm (§8). Tóm tắt và vị trí trong kế hoạch: `docs/spec/nhieu-nguoi-choi.md` §13.

Phạm vi giai đoạn A: thành viên đã đăng nhập (sau `?login`) thấy ai đang online, thấy huy hiệu tin chưa đọc, và mở hộp thư để đọc. Chưa có soạn tin, chưa có việc giao, chưa có chat. Tin chỉ xuất hiện khi bảng `messages` có dữ liệu (ví dụ chủ dự án thêm bằng bảng điều khiển để thử). Guest không dùng tính năng này.

## 1. Vì sao không dùng Realtime

Gói Supabase Free giới hạn 2 000 000 tin Realtime mỗi tháng (`docs/spec/thay-nhau.md` §6). Hộp thư không cần tức thời, nên máy khách hỏi bảng định kỳ qua REST. Cách này không tốn hạn mức Realtime. Chế độ "họp trực tiếp" dùng Realtime là tùy chọn của giai đoạn F.

## 2. Cài đặt máy chủ

Mở Supabase, chọn SQL Editor, dán toàn bộ `docs/sql/hop-thu.sql` rồi bấm Run. Có thể chạy lại an toàn (`create ... if not exists`, chính sách được xóa rồi tạo lại, hàm được thay thế).

Trong dự án này, bảng mới không tự được cấp quyền. File SQL đã có lệnh `grant` cho vai trò `authenticated` (xem `docs/spec/nhieu-nguoi-choi.md` §6.1).

## 3. Thành phần

| Thành phần | Vị trí | Nội dung |
|---|---|---|
| Khối `MSG` | `index.html`, sau khối `RT`, trước `newDayState()` | Trạng thái: `timer`, `beatT` (lần ghi online gần nhất), `items` (tối đa 100 tin mới nhất), `online` (tập id nhân vật đang online), `unread`, `seen`, `primed`, `busy`, `failedAt`, `fails` |
| `msgStart()` | `index.html`, khối `MSG` | Hỏi ngay, rồi hỏi mỗi 25 giây. Gọi trong `cloudEnter()`, sau `rtStart()`. Bỏ qua nếu đã chạy |
| `msgStop()` | `index.html`, khối `MSG` | Dừng bộ hẹn giờ, bỏ lắng nghe tab, xóa dữ liệu hộp thư trong bộ nhớ, ẩn huy hiệu. Gọi trong `memberLogout()` và `cloudConflict()`, sau `rtStop()` |
| `msgTick()` | `index.html`, khối `MSG` | Một lần hỏi: ghi online (khi đến hạn), đọc `online` và `messages`, cập nhật huy hiệu, toast, chấm xanh. Lỗi: lùi dần, ghi `dlog` |
| `msgOnVisible()` | `index.html`, khối `MSG` | Khi tab hiện lại, gọi `msgTick()` ngay |
| `msgSetBadge()` | `index.html`, khối `MSG` | Hiện hoặc ẩn nút ✉ và chấm đỏ số tin chưa đọc |
| `msgApplyOnline()` | `index.html`, khối `MSG` | Thêm " 🟢" sau tên trên nhãn NPC của nhân vật đang online (trừ chính mình) |
| `msgOpenInbox()` | `index.html`, khối `MSG` | Mở popup "✉ Hộp thư", rồi đánh dấu tin gửi đến chưa đọc là đã đọc |
| `#b-mail`, `#mail-dot` | `index.html`, HUD | Nút ✉ ở thanh trên, bên phải, trước nút 🎥. Chấm đỏ có số tin chưa đọc |
| `docs/sql/hop-thu.sql` | `docs/sql/` | Hàm `my_char()`, bảng `online` và `messages`, chỉ mục, RLS, quyền |

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
| `thread_id` | uuid, có thể rỗng | Trả lời trong cùng luồng (chưa dùng ở giai đoạn A) |
| `from_char`, `to_char` | text | Người gửi, người nhận (không được trùng nhau) |
| `kind` | `chat`, `task` hoặc `note` | Tin thường, việc giao, giấy nhớ càm ràm |
| `body` | text, 1 đến 300 ký tự | Nội dung |
| `due` | `today`, `tomorrow`, `none` hoặc rỗng | Hạn của việc (chỉ `task`) |
| `done`, `done_at` | boolean, timestamptz | Việc đã xong (chỉ `task`, dùng từ giai đoạn B) |
| `read_at` | timestamptz | Người nhận đã mở xem |
| `ref` | uuid, có thể rỗng | Giấy nhớ trỏ về việc gốc. Chỉ `note`, tối đa một giấy nhớ cho mỗi việc |
| `created_at` | timestamptz | Thời điểm gửi |

Chỉ mục: `messages_one_note_per_task` (duy nhất theo `ref` khi `kind = 'note'`), `messages_to_idx`, `messages_from_idx`.

### 4.3 Hàm `my_char()`

Trả về `char_id` trong bảng `progress` của người đang đăng nhập (`auth.uid()`). Khai báo `security definer` với `search_path = public`. Quyền thực thi cấp cho `authenticated`.

### 4.4 Quyền truy cập (RLS và GRANT)

| Bảng | Đọc | Ghi |
|---|---|---|
| `online` | Mọi thành viên đã đăng nhập | Thêm và sửa `last_seen`, chỉ với dòng có `char_id` của mình |
| `messages` | Chỉ tin mình gửi hoặc mình nhận | Thêm: `chat` và `task` chỉ dưới tên mình. `note`: chỉ khi mình là người nhận (máy người nhận ghi thay người giao, vì người giao có thể đang offline). Sửa `done`, `done_at`, `read_at`: khi mình là người gửi hoặc người nhận |

Quyền ở tầng dữ liệu không phân biệt cột. Người gửi cũng sửa được `done` (xem §7, giới hạn). Giai đoạn B cần siết lại.

## 5. Luồng hoạt động

| Việc | Cách làm |
|---|---|
| Bắt đầu | Đăng nhập thành viên: `msgStart()` hỏi ngay, sau đó mỗi 25 giây |
| Hỏi định kỳ | Mỗi 25 giây, chỉ khi tab đang hiện. Khi tab hiện lại, hỏi ngay |
| Ghi online | Lần hỏi kế tiếp ghi `online` (upsert) nếu đã quá 55 giây từ lần ghi trước. Kiểm tra chạy theo nhịp 25 giây, nên thực tế ghi khoảng mỗi 75 giây (§7) |
| Đọc dữ liệu | `online` (dòng trong 3 phút gần nhất), và `messages` (tối đa 100 dòng, mới nhất trước) |
| Tin mới | Tin gửi đến mình, chưa đọc, chưa thấy ở lần hỏi trước. Toast 3,5 giây "✉ <tên>: <40 ký tự đầu>…", chỉ khi đang chơi. Lần hỏi đầu tiên sau đăng nhập không có toast, để không báo lại tin cũ |
| Đánh dấu đã đọc | Mở hộp thư: mọi tin gửi đến chưa đọc được gắn `read_at`. Không có tin chưa đọc thì không gửi yêu cầu |
| Lỗi | Ghi `dlog` (chỉ khi chạy trên localhost hoặc có `?debug`). Sau lỗi thứ n, chờ 25 giây × 2^n trước khi hỏi lại: 50 giây, 100 giây, 200 giây, tối đa 300 giây (5 phút). Thành công thì đặt lại về 0. Không hiện thông báo cho người chơi |
| Dừng | Đăng xuất, hoặc xung đột "đang được mở ở nơi khác": dừng hỏi, bỏ lắng nghe tab, xóa dữ liệu trong bộ nhớ, ẩn huy hiệu và chấm xanh |

Ước tính lượng yêu cầu REST (chưa đo): một thành viên có tab đang hiện gửi 2 truy vấn đọc mỗi 25 giây (4,8 yêu cầu/phút) và khoảng 1 lần ghi online mỗi 75 giây (0,8 yêu cầu/phút). Tổng khoảng 5,6 yêu cầu/phút. Tab ẩn: không gửi. Giới hạn REST của gói Free chưa được kiểm tra.

## 6. Giao diện

- **Nút ✉** (`#b-mail`): hiện khi thành viên đã đăng nhập và hộp thư đang chạy. Chấm đỏ hiện số tin chưa đọc (trên 9 hiện "9+", bằng 0 thì ẩn). Chỉ bấm được ở chế độ chơi.
- **Chấm 🟢** sau tên trên nhãn NPC: nhân vật đang online (trừ chính mình). Nhãn của người thật đang hiện trong `RT.peers` (giai đoạn 2) chưa có chấm này (§7).
- **Popup "✉ Hộp thư"**: 30 tin mới nhất. Mỗi dòng ghi "<người gửi> → bạn" hoặc "bạn → <người nhận>", thời gian, và nội dung. Tin `task` có tiền tố "📌 Việc: ", tin `note` có "📝 Giấy nhớ: ". Tin gửi đến chưa đọc có viền sáng. Khi chưa có tin: "Chưa có tin nào. (Soạn tin và giao việc sẽ có ở bản sau.)". Nút "Đóng". Chỉ đọc.
- **Toast**: như §5.
- **Văn bản**: luôn hiển thị dưới dạng chữ. Hàm `h()` tạo nút chữ bằng text node (không dùng innerHTML), và `toast()` dùng `textContent`. Đã kiểm tra với tin chứa HTML (mock): hiện đúng dạng chữ.

## 7. Giới hạn đã biết

- **Nhịp ghi online**: thực tế khoảng 75 giây, không phải 55 giây như thiết kế. Nguyên nhân: kiểm tra chạy theo nhịp 25 giây và chỉ ghi khi đã quá 55 giây. Cửa sổ 3 phút vẫn đủ. Chủ dự án quyết định có đổi ngưỡng không.
- **Tab ẩn hoặc máy ngủ**: không ghi online, nên sau khoảng 3 phút người khác thấy ngoại tuyến.
- **Chưa chạy SQL**: nếu chưa chạy `docs/sql/hop-thu.sql`, nút ✉ vẫn hiện, hộp thư báo "Chưa có tin nào", không có chấm xanh, và lỗi chỉ có trong nhật ký gỡ lỗi.
- **Số lượng tin**: huy hiệu và toast chỉ tính 100 tin mới nhất. Tin cũ hơn chưa đọc không được đếm.
- **Nhãn người thật**: chấm 🟢 không hiện trên nhãn của người thật (`rtPeer()`, giai đoạn 2).
- **RLS không phân biệt cột**: người gửi cũng sửa được `done` và `read_at` (§4.4). Chấp nhận cho giai đoạn A vì chưa có việc giao. Giai đoạn B phải siết lại.
- **Hàm `my_char()`**: có thể được gọi bởi vai trò `anon` nếu dự án cấp quyền mặc định. Với khách không có `auth.uid()` nên hàm trả về rỗng. Chưa kiểm tra bằng truy vấn.
- **Giới hạn độ dài và số việc**: chỉ có ràng buộc trong bảng (1 đến 300 ký tự, giá trị hợp lệ của `kind` và `due`). Giới hạn số việc mỗi ngày (giai đoạn B) chỉ kiểm tra ở máy khách.
- **Quyền riêng tư**: chủ dự án đọc được mọi tin qua bảng điều khiển Supabase. Cần báo cho thành viên trước khi dùng.
- **Bàn phím điện thoại**: chưa kiểm tra. Giai đoạn A chưa có ô soạn tin. Kiểm tra khi có ô soạn tin ở giai đoạn B.

## 8. Các giai đoạn tiếp theo (chưa làm)

Theo quyết định với chủ dự án (2026-11-04). Các giai đoạn này chia nhỏ giai đoạn 5 trong `docs/spec/nhieu-nguoi-choi.md` §5.

| Giai đoạn | Nội dung | Ghi chú |
|---|---|---|
| B | Soạn tin và trò chuyện theo luồng (tự gõ). Việc giao (`kind = task`) có nút "Xong": người nhận tick hoặc trả lời trong luồng. Người giao mở lại được việc. Chọn hạn khi giao (mặc định hôm nay). Tối đa khoảng 5 việc mỗi người giao mỗi ngày. NPC đưa tin chạy đến bàn người chơi | Giới hạn số việc chỉ ở máy khách. Siết quyền cột `done` (§7) |
| C | Càm ràm cuối ngày: khi người nhận tan ca lúc 18:00 (`docs/spec/tan-ca-18-gio.md`), việc quá hạn và chưa tick làm NPC người giao càm ràm, rồi để lại giấy nhớ (`kind = note`) trên bàn người nhận. Giấy nhớ hiện ngày hôm sau và ghi trong nhật ký. Câu càm ràm lấy từ lời thoại có sẵn của nhân vật, có trích tên việc. Người giao nhận tóm tắt đầu ngày. Việc quá 48 giờ thực thì chuyển sang "lỡ" | Máy người nhận ghi giấy nhớ thay người giao. Theo thiết kế, chỉ người nhận thấy giấy nhớ (RLS hiện cho cả người gửi, §4.4) |
| D | Nút khen và càm ràm. Chat nhanh | Chọn nhanh hoặc tự gõ |
| E | Thông báo ngoài game: email qua Supabase, hoặc Web Push | Web Push trên iPhone cần cài game như ứng dụng web |
| F | Tùy chọn "họp trực tiếp": bật Realtime của giai đoạn 2 khi cần | Không bật mặc định, để giữ trong hạn mức |

## 9. Tiêu chí chấp nhận

| ID | Tiêu chí | Trạng thái |
|---|---|---|
| AC-M59 | `docs/sql/hop-thu.sql` chạy không lỗi trong SQL Editor (chạy một lần) | Not done (chủ dự án) |
| AC-M60 | Chấm 🟢 hiện trên nhãn NPC của người đang online | Verified (mocked client, headless Chrome, 2026-11-04). Real server: not verified |
| AC-M61 | Tin mới hiện huy hiệu và toast. Mở hộp thư đánh dấu đã đọc | Verified (mocked client, 2026-11-04). Real server: not verified |
| AC-M62 | Lỗi liên tiếp: chờ 50 s, 100 s, 200 s, tối đa 300 s. Thành công thì đặt lại | Verified (mocked client, 2026-11-04) |
| AC-M63 | Đăng xuất và xung đột: dừng hỏi, xóa huy hiệu và chấm xanh | Verified (mocked client, 2026-11-04) |
| AC-M64 | Tin chứa HTML hiện dạng chữ | Verified (mocked client, 2026-11-04) |
| AC-M65 | RLS: thành viên không đọc được tin của cặp khác, không gửi được tin dưới tên người khác | Not verified (cần hai tài khoản thật) |
| AC-M66 | Chỉ hỏi máy chủ khi tab đang hiện. Hiện lại thì hỏi ngay | Code read only (2026-11-04) |
| AC-M67 | Toast chỉ hiện ở chế độ chơi, không hiện khi đang mở menu | Code read only (2026-11-04) |
| AC-M68 | Hai tài khoản thật: thấy chấm xanh và huy hiệu của nhau. Chấm tắt khoảng 3 phút sau khi đóng tab | Not verified |
| AC-M69 | Số yêu cầu thực tế với 3 người trở lên khớp ước tính §5 | Not measured |
