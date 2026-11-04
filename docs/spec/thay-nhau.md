# Thấy nhau: người chơi thật thấy nhau (multiplayer giai đoạn 2)

Trạng thái: Phiên bản đầu đã triển khai (v2.2.0-alpha, 2026-11-04, commit `fa7ebf7`, đã đẩy lên `origin/main`). Tần suất gửi đã giảm trước khi commit, sau khi đối chiếu hạn mức tin Realtime của gói Supabase Free (§6). Chỉ kiểm tra bằng headless Chrome với kênh giả lập. Chưa kiểm tra với Supabase Realtime thật hoặc hai trình duyệt thật. Tóm tắt và kế hoạch chung: `docs/spec/nhieu-nguoi-choi.md` §4, §5, §12.

Phạm vi: thành viên đã đăng nhập thấy vị trí và tư thế của thành viên khác đang online, dưới dạng nhân vật tương ứng. Chưa có: chat, đồng hồ chung, NPC dùng chung, giao việc.

## 1. Thành phần

| Thành phần | Vị trí | Nội dung |
|---|---|---|
| Khối `RT` | `index.html`, ngay trước `newDayState()` (sau khối đăng nhập) | Trạng thái: `ch` (kênh), `peers` (Map id → người thật), `timer`, `last` (khóa vị trí đã gửi), `lastSent`, `others` (số người khác đang online, §2) |
| `rtStart()` | `index.html`, khối `RT` | Tạo kênh `office`, đăng ký Presence và Broadcast, bật bộ đếm gửi 330 ms. Gọi trong `cloudEnter()` |
| `rtStop()` | `index.html`, khối `RT` | Dừng bộ đếm, xóa mọi người thật, đặt `others = 0`, gỡ kênh. Gọi trong `memberLogout()` và `cloudConflict()` |
| `rtSend()` | `index.html`, khối `RT` | Gửi vị trí của thành viên (xem §3). Không gửi khi đứng một mình |
| `rtPeer(id)` | `index.html`, khối `RT` | Tạo nhân vật cho người thật lần đầu (ngoại hình từ `NPC_PROFILES`), gọi `rtHideNpc()` |
| `rtHideNpc(id)` | `index.html`, khối `RT` | Ẩn NPC của nhân vật đó: `times.arrive = 99999`, trạng thái `hidden`, giải phóng chỗ |
| `rtUpdate(dt)` | `index.html`, khối `RT`, gọi trong `update()` sau `updatePlayer(dt)` | Nội suy vị trí, tư thế, ẩn người thật khi im lặng quá 25 s |
| `rtDrop(id)` | `index.html`, khối `RT` | Xóa nhân vật, nhãn tên và phần tử nhãn của người thật, bỏ khỏi `peers` |
| `startDay()` | `index.html` | Gọi `rtHideNpc()` lại cho mọi người thật đang có trong `peers` |

## 2. Kênh và Presence

- Một kênh chung tên `office` cho mọi thành viên. Lý do: mỗi người có ngày game riêng và chưa có đồng hồ chung (giai đoạn 3), nên không thể tách kênh theo ngày như kế hoạch ban đầu.
- Kênh được tạo với `presence.key = MEMBER.char` (id nhân vật) và `broadcast: { self: false, ack: false }`.
- Khi kênh báo `SUBSCRIBED`: `track({ c: MEMBER.char })`. Trạng thái `CHANNEL_ERROR` hoặc `TIMED_OUT` được ghi bằng `dlog`.
- Số người khác online (`RT.others`): đếm lại từ `presenceState()` khi có Presence `sync` và `leave`, bỏ qua khóa của chính mình. Nếu đọc lỗi, đặt 1 và ghi `dlog`.
- Presence `join` của người khác: đặt lại `RT.last` và `RT.lastSent` về 0, để lần gửi kế tiếp mang vị trí của mình ngay (người mới vào thấy ta ngay, không chờ nhịp 10 s). Việc đếm người do sự kiện `sync` đảm nhận. Cần kiểm tra với Realtime thật (AC-M58).
- Presence `leave` với khóa là id nhân vật: gọi `rtDrop(key)`, rồi đếm lại.
- Kênh không đặt `private: true`. Xem §6 (khác với kế hoạch trong `docs/spec/nhieu-nguoi-choi.md` §4).

## 3. Gửi vị trí (Broadcast `pos`)

Chỉ gửi khi: có kênh, có thành viên, game đã bắt đầu (`G.started`), tab đang hiện (`!document.hidden`), và có ít nhất một người khác online (`RT.others ≥ 1`).

| Trường | Nghĩa |
|---|---|
| `c` | id nhân vật |
| `x`, `z` | vị trí trên mặt sàn, làm tròn 0,01 m |
| `y` | góc quay (yaw), làm tròn 0,01 |
| `a` | tư thế: `type` hoặc `L.anim` khi ngồi, `walk` khi đang đi, `idle` khi đứng yên |
| `s` | đang ngồi (boolean) |

- Bộ đếm chạy mỗi 330 ms, nên tối đa khoảng 3 lần mỗi giây (trước đây 200 ms, khoảng 5 lần).
- Gửi khi khóa `x,z,y,a` đổi. Khi đứng yên, gửi lại mỗi 10 s làm nhịp báo sống (heartbeat). Trước đây là 2,5 s.
- Đứng một mình: không gửi gói nào, kể cả nhịp báo sống.
- Lượng tin nhắn và hạn mức: §6.

Nhận (`ch.on('broadcast', { event: 'pos' })`): bỏ gói nếu `c` không phải chuỗi hoặc `x`, `z` không phải số. Tạo người thật nếu chưa có. Gói đầu tiên đặt vị trí ngay (không trượt). Tư thế `a` cắt còn 8 ký tự. Ghi thời điểm nhận `seen`.

## 4. Hiển thị người thật (`rtUpdate`)

- Vị trí và góc quay nội suy về đích với hệ số `1 − e^(−10·dt)`.
- Tư thế: nếu gói báo ngồi (`s`), dùng tư thế `a` và `seated = true` (độ cao 0,1 m). Nếu không ngồi, đi khi lệch quá 0,05 m hoặc `a = walk`, còn lại đứng yên.
- Nhân vật hiện khi không ở chế độ đơn giản (`!LITE`). Nhãn tên hiện khi không ở chế độ đơn giản và `G.mode === 'play'`.
- Im lặng quá 25 s: ẩn nhân vật và nhãn, giữ người thật trong `peers`. Gói mới làm nó hiện lại. Con số 25 s lớn hơn hai nhịp báo sống (10 s), nên người đang đứng yên bình thường không bị ẩn.
- Mỗi khung hình, nếu NPC của người thật chưa ở trạng thái `hidden`, gọi `rtHideNpc()` lại.

## 5. NPC của người thật

- Khi nhận gói `pos` đầu tiên, NPC tương ứng bị ẩn trên máy này. Presence báo online một mình không ẩn NPC.
- Thành viên đang ở màn hình đầu (chưa bấm bắt đầu) không gửi `pos`, nên NPC của họ vẫn hiện với người khác cho đến khi họ bắt đầu ngày.
- NPC ẩn đến hết ngày. Ngày mới (`startDay()`) reset NPC, rồi `rtHideNpc()` áp lại cho người thật đang có.
- Khi người thật rời kênh (Presence `leave`), nhân vật bị xóa, nhưng NPC vẫn ẩn đến hết ngày. Đây là hành vi hiện tại, không phải lỗi đã biết khác.
- NPC của các nhân vật khác vẫn do mỗi máy tự mô phỏng. Vị trí NPC có thể khác nhau giữa các máy.

## 6. Giới hạn, hạn mức và điểm cần quyết định

**Hạn mức Realtime (gói Supabase Free, bảng điều khiển, 2026-11-04):** 2 000 000 tin nhắn Realtime mỗi tháng, 200 kết nối đồng thời. Mỗi lần broadcast được tính 1 khi gửi, cộng 1 cho mỗi người nhận.

Công thức: tin/s = số người gửi × tần suất gửi × (1 + số người nhận). Giả định: đi liên tục gửi 3,03 lần/s (330 ms); đứng yên gửi 0,1 lần/s (10 s); số người nhận bằng số người khác online.

| Tình huống | Cũ (200 ms, nhịp 2,5 s) | Mới (330 ms, nhịp 10 s) |
|---|---|---|
| 5 người đi liên tục | 125 tin/s, 2 triệu tin trong ~4,4 giờ | 76 tin/s, ~7,3 giờ |
| 14 người đi liên tục | 980 tin/s, ~34 phút | 594 tin/s, ~56 phút |
| 5 người đứng yên | 10 tin/s, ~56 giờ | 2,5 tin/s, ~222 giờ (~9 ngày) |
| 14 người đứng yên | 78 tin/s, ~7,1 giờ | 20 tin/s, ~28 giờ |

- Ước tính (chưa đo). Chủ dự án ước tính "khoảng 20 giờ trở lên" cho 5 người đi. Bảng trên cho ~7,3 giờ khi cả 5 người đi liên tục. Con số 20 giờ chỉ đạt khi mỗi người đi khoảng một phần ba thời gian. Cần chủ dự án xác nhận giả định sử dụng.
- Số đo thật: chưa có. Kiểm tra với Supabase thật, ba người trở lên, đối chiếu số tin trên bảng điều khiển với công thức trên (AC-M58).
- Số người tối đa (14) nằm trong giới hạn 200 kết nối.

Các điểm khác:

- **Kênh công khai.** Kênh không dùng `private: true`, nên ai có khóa publishable và tên kênh có thể đăng ký nghe vị trí và Presence. §4 của `docs/spec/nhieu-nguoi-choi.md` yêu cầu kênh riêng. Cần chủ dự án quyết định: chuyển sang kênh riêng (cần chính sách RLS cho Realtime) hay chấp nhận.
- **Dự án Free bị tạm dừng sau 1 tuần không hoạt động.** Ảnh hưởng đăng nhập và lưu tiến độ. Guest không bị ảnh hưởng. Chi tiết: `docs/spec/nhieu-nguoi-choi.md` §7.
- **Mở rộng khi cần nhiều người hơn (chưa làm, chưa cần).** Hai hướng: (a) chia phòng, mỗi phòng khoảng 10–20 người với một kênh riêng; (b) Cloudflare Workers với Durable Objects làm nơi chuyển vị trí. Trang tham khảo: sansatemple.com. Chỉ đọc JS công khai để hiểu cách làm. Không dùng lại mã của trang đó.
- **Trùng khóa Presence.** Hai tab cùng một tài khoản dùng cùng khóa (id nhân vật). Giai đoạn 1 chỉ cho một nơi ghi tiến độ, nhưng chưa kiểm tra hành vi Presence khi có hai tab.
- **Không chat, không NPC dùng chung.** Không có tin nhắn chat. Mỗi máy tự chạy NPC.
- **Vị trí sao chép, không tìm đường.** Người thật được vẽ tại vị trí nhận được. Máy nhận không tự tránh bàn ghế, nên nhân vật có thể thoáng đi xuyên đồ đạc nếu đường đi của máy gửi khác.
- **Guest không tham gia.** `rtStart()` không chạy khi `MEMBER` là null. Cờ `loginEnabled` vẫn quyết định ai thấy nút đăng nhập.

## 7. Tiêu chí chấp nhận

| ID | Tiêu chí | Trạng thái |
|---|---|---|
| AC-M40 | Người thật hiện trên màn hình (nhân vật của họ) khi có gói `pos` | Verified (headless Chrome, kênh giả lập, 2026-11-04) |
| AC-M41 | NPC của người thật bị ẩn trên máy nhận | Verified (headless Chrome, kênh giả lập, 2026-11-04) |
| AC-M42 | Gói `pos` có đúng các trường `{c,x,z,y,a,s}` | Verified (headless Chrome, kênh giả lập, 2026-11-04) |
| AC-M43 | Ngồi: nhân vật người thật ở độ cao ghế (y đúng) | Verified (headless Chrome, kênh giả lập, 2026-11-04) |
| AC-M44 | Presence `leave` xóa người thật (nhân vật, nhãn) | Verified (headless Chrome, kênh giả lập, 2026-11-04) |
| AC-M45 | Gửi khi vị trí đổi, tối đa khoảng 3 lần mỗi giây (timer 330 ms) | Code read only (2026-11-04) |
| AC-M46 | Im lặng quá 25 s thì ẩn người thật, gói mới làm hiện lại | Code read only (2026-11-04) |
| AC-M47 | Ngày mới: NPC người thật online vẫn ẩn (`startDay()`) | Code read only (2026-11-04) |
| AC-M48 | Đăng xuất và xung đột: gỡ kênh, xóa người thật | Code read only (2026-11-04) |
| AC-M49 | Guest không vào kênh, chơi một mình như cũ | Code read only (2026-11-04) |
| AC-M50 | Hai trình duyệt thật của hai thành viên thấy nhau | Not verified |
| AC-M51 | Supabase Realtime thật: Presence, Broadcast, kênh công khai hay riêng | Not verified |
| AC-M52 | Tốc độ với 14 người, và giới hạn gói miễn phí | Not verified |
| AC-M53 | Điện thoại và Safari: người thật hiện đúng, không giật | Not verified |
| AC-M54 | Đứng một mình (không có người khác online): không gửi gói nào | Verified (headless Chrome, kênh giả lập, 2026-11-04) |
| AC-M55 | Có người khác online: gửi `pos`; đứng yên thì không gửi trùng, chỉ nhịp 10 s | Verified (headless Chrome, kênh giả lập, 2026-11-04) |
| AC-M56 | Người khác vừa vào (Presence `join`): gửi vị trí của mình ngay | Code read only (2026-11-04) |
| AC-M57 | Người khác rời (Presence `leave`): xóa người thật và đưa `RT.others` về đúng số | Verified (headless Chrome, kênh giả lập, 2026-11-04) |
| AC-M58 | Realtime thật, 3 người trở lên: số tin trên bảng điều khiển khớp công thức §6, và `RT.others` đúng sau khi có người vào | Not verified |
