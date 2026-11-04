# Đăng nhập công ty: mật khẩu, tài khoản và cờ bật tắt

Trạng thái: đã triển khai trong `index.html` (v2.1.0-alpha, 2026-11-04). Chỉ hiện với người đã bật cờ `loginEnabled` (§4). Phạm vi: đăng nhập bằng email công ty và mật khẩu do quản trị viên tạo. Bối cảnh giai đoạn 1 (bảng dữ liệu, nhận nhân vật, lưu tiến độ): `docs/spec/nhieu-nguoi-choi.md` §4, §9.

Lịch sử trong cùng bản v2.1.0-alpha: link email (v2.0.x) đã bỏ. Luồng "Lần đầu hoặc quên mật khẩu?", email khôi phục và màn tạo mật khẩu đã thêm rồi bỏ trong ngày, nên không còn trong mã nguồn (§6).

## 1. Luồng đăng nhập

| Tình huống | Hành động | Hàm | Kết quả |
|---|---|---|---|
| Mở màn chính (cờ bật) | Bấm "🔑 Đăng nhập công ty" | `showLogin()` | Popup: ô email, ô mật khẩu, "Đăng nhập", "🎮 Chơi Guest" |
| Đăng nhập đúng | Nhập email và mật khẩu, bấm "Đăng nhập" hoặc Enter ở ô mật khẩu | `auth.signInWithPassword` → `cloudEnter()` | `claim_character()`, áp dụng nhân vật, popup "Chào <tên>!" |
| Sai thông tin | Như trên | `friendlyAuthError` | Ở lại popup, hiện thông báo (bảng dưới) |
| Tài khoản chưa xác nhận | Như trên | `friendlyAuthError` | Thông báo "chưa được kích hoạt" |
| Email chưa gắn nhân vật | Đăng nhập được, nhận nhân vật lỗi | `cloudEnter()` (catch) | Đăng xuất, về màn đăng nhập kèm thông báo nhờ quản trị viên kiểm tra |
| Ô email sai định dạng | Bấm "Đăng nhập" | `okEmail()` | "Email chưa đúng, hãy nhập lại." Không gọi máy chủ |
| Ô mật khẩu trống | Bấm "Đăng nhập" | `showLogin()` | "Hãy nhập mật khẩu." Không gọi máy chủ |
| Chơi Guest | Bấm "🎮 Chơi Guest" | `setGuestPref(true)` | Ghi `localStorage['mot-ngay.guest'] = '1'`, về màn chính, `showWelcomeBack()` |
| Quên mật khẩu | Nhờ quản trị viên | (bảng điều khiển, §3) | Quản trị viên đặt mật khẩu mới. Game không có nút đặt lại |

Thông báo lỗi từ `friendlyAuthError(e)` (tiếng Việt):

| Lỗi máy chủ | Thông báo |
|---|---|
| `invalid login credentials` / `invalid_credentials` | "Email hoặc mật khẩu chưa đúng. Hãy hỏi quản trị viên nếu bạn chưa có mật khẩu." |
| `email not confirmed` | "Tài khoản chưa được kích hoạt. Hãy nhờ quản trị viên kiểm tra." |
| Quá nhiều lần (`rate`, `too many`, `seconds`) | "Thử quá nhiều lần rồi, hãy đợi vài phút rồi thử lại." |
| Mạng (`fetch`, `network`, `failed`) | "Không kết nối được. Hãy kiểm tra mạng rồi thử lại." |
| Khác | "Chưa thực hiện được. Hãy kiểm tra thông tin rồi thử lại." |

Nhánh "mật khẩu giống cũ" và "mật khẩu yếu" còn trong `friendlyAuthError` nhưng không gặp được ở màn đăng nhập (không còn bước đổi mật khẩu).

## 2. Thành phần

| Thành phần | Vị trí | Nội dung |
|---|---|---|
| `loginEnabled` | `index.html`, cạnh `CLOUD` (p6), trước `guestPref` | Cờ bật tính năng. Đọc `?login` và `localStorage['mot-ngay.dev']`. §4 |
| `#btn-login` | `index.html`, màn chính | "🔑 Đăng nhập công ty". Ẩn khi cờ tắt |
| `cloudBoot()` | khối đăng nhập sau mục 14 | Đặt hiện/ẩn `#btn-login` theo cờ. Cờ tắt: `showWelcomeBack()` ngay, không gọi `cloudInit()`, không tải supabase-js. Cờ bật: có phiên thì `cloudEnter()`; chưa chọn Guest và tải được client thì `showLogin()`; còn lại `showWelcomeBack()` |
| `showLogin(msg)` | cùng khối | Ô email và mật khẩu (`autocomplete="current-password"`), "Đăng nhập", "🎮 Chơi Guest" |
| `cloudEnter(sess)` | cùng khối | Dùng khi khởi động và sau đăng nhập: nhận nhân vật, áp dụng, popup chào. Lỗi: đăng xuất, về `showLogin()` |
| `friendlyAuthError(e)` | cùng khối | Đổi lỗi kỹ thuật thành thông báo tiếng Việt (bảng trên) |
| `AUTH_INPUT_STYLE` | cùng khối | Kiểu ô nhập của màn đăng nhập |

## 3. Tạo và quản lý tài khoản (quản trị viên)

Không gửi email nào. Không cần SMTP, không cần mẫu email, không cần Site URL cho luồng này.

- Tạo từng tài khoản trong bảng điều khiển Supabase: Authentication → Users → Add user → Create new user. Bật **Auto Confirm** (tự xác nhận), đặt mật khẩu do quản trị viên chọn. Mật khẩu nên có ít nhất 8 ký tự (quy ước, game không kiểm tra).
- Đưa mật khẩu cho từng người riêng tư. Không ghi mật khẩu, email thật hay link vào tài liệu, mã nguồn hay kênh chung.
- Quên mật khẩu: quản trị viên mở tài khoản trong Authentication → Users, đặt mật khẩu mới, rồi báo riêng cho người chơi.
- Mỗi email cần một dòng `roster` (email → nhân vật, bộ phận) trước khi đăng nhập được. Xem `docs/spec/nhieu-nguoi-choi.md` §9.1 và §6.1 (cấp quyền bảng).
- Tài khoản không có dòng `roster` đăng nhập được nhưng bị đăng xuất ngay (§1, dòng "Email chưa gắn nhân vật").

## 4. Cờ bật tắt (`loginEnabled`)

| Trạng thái | Cách đặt | Nút "🔑 Đăng nhập công ty" | Tải supabase-js | Màn đầu tiên |
|---|---|---|---|---|
| Tắt (mặc định, mọi người) | Không có `?login`, và `mot-ngay.dev` không phải `'1'` | Ẩn | Không | Guest: popup chào nếu có tiến độ, không thì form đặt tên |
| Bật | Mở game với `?login` trong địa chỉ web. Ghi `localStorage['mot-ngay.dev'] = '1'`, nhớ cho các lần sau | Hiện | Có | Màn đăng nhập, nếu chưa chọn Guest và chưa có phiên |
| Tắt lại | Mở game với `?login=off`. Xóa `mot-ngay.dev` | Ẩn | Không | Guest |

Ghi chú:

- Cờ lưu theo trình duyệt. Mỗi trình duyệt của tester cần bật riêng. Người chơi bình thường không bị ảnh hưởng.
- Đây là che giấu, không phải bảo mật. Mã nguồn công khai, ai đọc được cờ. Bảo vệ thật là RLS trên `roster` và `progress`, và tài khoản do quản trị viên tạo.
- Tắt cờ không đăng xuất. Phiên cũ có thể còn trong trình duyệt nhưng không được tải, nên người đó chơi Guest.
- Mở file trực tiếp (không qua địa chỉ web) với cờ bật: nút hiện, nhưng đăng nhập báo phải mở qua đường link web.
- Kế hoạch gỡ cờ sau khi thử nghiệm realtime xong: đặt `loginEnabled` thành luôn bật, rồi thông báo. Xem `docs/tasks.md`.

## 5. Tiêu chí chấp nhận

| ID | Tiêu chí | Trạng thái |
|---|---|---|
| AC-M22 | `index.html` có cú pháp hợp lệ | Verified (2026-11-04) |
| AC-M23 | Với cờ bật và client giả: sai mật khẩu hiện thông báo; đúng mật khẩu vào popup chào đúng nhân vật; nút Guest còn có | Verified with mocked client (2026-11-04). Máy chủ thật: AC-M28 |
| AC-M24 | Link khôi phục buộc đặt mật khẩu | Removed (v2.1.0-alpha, cùng ngày). Không còn luồng này |
| AC-M25 | Máy chủ thật: sai mật khẩu trả `invalid_credentials` | Verified (probe, 2026-11-04) |
| AC-M26 | Máy chủ thật: yêu cầu khôi phục với email lạ trả 200 | Removed. Game không còn gọi endpoint này |
| AC-M27 | Email khôi phục thật và link mở vào game | Removed |
| AC-M28 | Đăng nhập bằng mật khẩu thật (tài khoản do quản trị viên tạo); lần sau vào thẳng popup chào | Not verified |
| AC-M29 | Thông báo lỗi thân thiện với lỗi thật (sai thông tin, chưa kích hoạt, mạng, quá nhiều lần) | Sai thông tin: text checked via probe (AC-M25). Còn lại: code read only (2026-11-04) |
| AC-M30 | Cờ tắt: nút ẩn, không có client Supabase, màn đầu là form tên (chưa có tiến độ) | Verified (headless Chrome, 2026-11-04): enabled=false, nút ẩn, form tên hiện, không có client |
| AC-M31 | Cờ bật qua `?login`: enabled=true, nút hiện, client được tạo | Verified (headless Chrome, 2026-11-04) |
| AC-M32 | `?login=off` tắt lại cờ trong trình duyệt thật | Not verified |
