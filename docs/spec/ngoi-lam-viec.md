# Spec: Ngồi làm việc và nhắc việc cuối ngày (sit-and-work, end-of-day nag)

Status: v1.16.0 (2026-11-04). Mailbox phase C (uncommitted, 2026-11-05): a human nag from the assigner runs before the NPC nag (§3.2a). The workday ends at 18:00 (was 17:30). The time-lapse stops at 18:00 and the farewell scene starts (§2.4, `docs/spec/tan-ca-18-gio.md`). The early-leave confirm is before 17:40 (was 17:10, §3.2). Earlier: v1.15.0 (2026-11-04). Sit-and-work time-lapse at the player's desk (§2). Unfinished-work reaction from the assigner at day end (§3). Every coworker assigns desk work (§3.4). Parent spec: `docs/spec/mot-ngay-o-cong-ty.md` (§4.2, AC-100 to AC-116 listed there). Desk task rules: `docs/spec/bang-nhiem-vu.md` §9 and `docs/spec/mot-ngay-o-cong-ty.md` AC-71 to AC-73.

Source of truth: `index.html`. Section 11: `workActivity()`, `startTimelapse()`, `endTimelapse()`, `workNag()`, `workBrief()`. Section 14: `update()`, `endDay()`. Variety block (between sections 2 and 3): `SORT_SETS`, `ORDER_SETS`, `WORK_VOICE`, `WORK_QUOTA`, `WORK_NAG`. DOM: the `#tl` overlay (`#tl-clock`).

## 1. Goal

Two changes to the desk task and the end of the day:

- The player can sit at the desk and let the clock run (time-lapse), instead of doing the task now.
- At the end of the day (18:00 farewell scene, `docs/spec/tan-ca-18-gio.md`), or on an early leave, a player who finished fewer than `WORK_QUOTA` desk tasks is reminded by the coworker who gave the work.

## 2. Sit-and-work time-lapse

### 2.1 Entry

The desk work card (`workActivity()`) shows three choices, in this order:

| # | Label | Action |
|---|---|---|
| 1 | "🪑 Ngồi làm việc (thời gian trôi qua)" | `startTimelapse()` (§2.2) |
| 2 | "▶ Bắt đầu làm" (new task) or "▶ Làm tiếp" (unfinished task) | Sit, then `startMiniGame()` |
| 3 | "Để lát nữa" | Close the card, stand up (`playerStand`) |

When `D.tasks` is at `CFG.MAX_TASKS`, the rest card replaces the work card and the time-lapse is not offered.

### 2.2 Start

`startTimelapse()`:

- If the player is already seated (`P.lock.type === 'seated'`), it starts at once. Otherwise it calls `playerSit(PLAYER_DESK.seat)` and starts when seated. The pose is `type`.
- Saves the camera and fast state in `G.tl = { fast, yaw, dist, pitch, ms }`, where `ms` is the current milestone id.
- Sets `G.mode = 'timelapse'` and `G.fast = true`. Fast mode is `CFG.SPEED` × `CFG.FAST`, about 5 game minutes per real second.
- Sets `CAM.dist = 13` and `CAM.pitch = 0.85`.
- Shows the `#tl` overlay with the clock (`#tl-clock`) and the text "⏳ Đang ngồi làm việc… chạm bất kỳ đâu để dừng".

### 2.3 While running

- `update()` (section 14) ticks the clock and runs the coworker simulation, as in play mode. The player stays seated.
- Pause does not work in this mode. `pauseGame()` only runs in `play`, and Esc is taken by the time-lapse key handler.
- Camera: `updateCamera()` uses `G.tl` to move the look target to (0, 0.5). `update()` adds `CAM.yaw += dt * 0.2`, about one orbit every 31 seconds.
- No task credit. `D.tasks` and `D.work` are not changed.
- A full 08:30 to 18:00 day takes about 114 real seconds at this speed (v1.16.0; was 108 for 08:30 to 17:30). The clock stops at 18:00 and the farewell scene starts (§2.4).

### 2.4 Exit

| Trigger | Result |
|---|---|
| Tap or click `#tl`, or Space, Enter, or Esc | `endTimelapse(true)`: restores `G.fast`, camera yaw, distance and pitch. Hides the overlay. Calls `updateCamera(0, true)` (not in list mode). Sets `G.mode = 'play'` and reopens the work card. The player stays seated. |
| Next milestone (`currentMilestone(D.minute).id` differs from `G.tl.ms`) | `endTimelapse(true, "🕘 hh:mm · <milestone>")`: as above, plus a toast for 3.2 s. |
| 18:00 (`startFarewell()`, v1.16.0), or early leave (`endDay()`) | `endTimelapse(false)`: restores camera and fast state, no card. At 18:00 the farewell scene runs first (`docs/spec/tan-ca-18-gio.md` §4). The end-of-day flow (§3.2) follows. |

After an automatic stop the work card is open and the player is still at the desk. Starting the time-lapse again is possible.

### 2.5 Standing up

The player stands up only through "Để lát nữa" (`playerStand`). While the work card is open after a time-lapse, the player stays seated.

### 2.6 List mode (LITE)

The overlay and the clock work. The camera orbit does not run, because `updateCamera()` is not called in list mode.

### 2.7 Touch

The overlay is a full-screen tap target. Not tested on touch devices (§5).

## 3. Unfinished work at end of day

### 3.1 Quota

`WORK_QUOTA = 2` (variety block). `D.tasks` counts finished desk tasks for the day (`finish(true)`). Time-lapse does not count, so a day of only time-lapse always triggers the reaction.

### 3.2 Flow

`endDay()` (section 14), in order:

1. `D.ended = true`, `Card.hide()`, `endTimelapse(false)`, and all coworkers are unfrozen.
2. `msgNagFlow(next)` runs first (§3.2a). If it nagged, the NPC nag is skipped. Otherwise, if `D.tasks < WORK_QUOTA`, it calls `workNag(showNote)`; if not, it calls `showNote()` directly.
3. `workNag(next)`:
   - Uses `D.work`, or creates one with `newWork()` (`sort` when `D.tasks` is even, `order` when odd). The assigner is `D.work.from`.
   - Picks one line at random from `WORK_NAG[from].lines`, filled with `fill()`.
   - Effects: affinity −`aff` (`changeAff`), mood −`mood` (`addMood`), the assigner added to `D.talked`, `Sfx.wrong()`, `D.stats.nagged` +1, and one moment: "Chưa xong việc <name> giao, bị <name> nhắc."
   - Bubble with the line (`sayNpc`). Chị Ba (`punch: true`) plays the `punch` animation for 2.4 s.
   - Card: "Sắp về mà việc <name> giao vẫn chưa xong, <name> ghé qua bàn bạn." If the assigner is not in the office (`n.state === 'hidden'`), it says "<name> nhắn tin hỏi bạn" instead. The line is quoted below. One button, "Dạ, em xin lỗi, mai em làm", gives affinity +1 and calls `next()`.
   - If the assigner is not found (`npcById` returns nothing), it calls `next()` with no effects.
4. `showNote`: card "Trước khi về…". "📝 Có, viết một dòng" opens the note flow, then the summary. "Hôm nay thôi" goes to the summary.

Early leave: the confirm card "Bạn muốn kết thúc ngày làm sớm chứ?" (shown before 17:40, `CFG.END - 20`; was 17:10 before v1.16.0) calls `endDay()`, so the same check runs. From 17:40 the door calls `endDay()` with no confirm card.

At 18:00 the day ends through the farewell scene instead (`docs/spec/tan-ca-18-gio.md`). Its end card has "🏠 Về thôi", which calls `endDay()`, so the same check runs there too.

### 3.2a Human nag (mailbox phase C, uncommitted)

The company mailbox adds a nag from the person who gave the task. Mailbox rules and limits: `docs/spec/hop-thu-cong-ty.md` §8.1.

- Picks the oldest task given to the member that is not done, has no desk note yet, and is overdue (`taskOverdue`). `none` never; `tomorrow` from the next calendar day; `today` at every end of day until it is done. At most one per day.
- Same effects as `workNag` (affinity and mood from `WORK_NAG[assigner]`, one diary moment, bubble, card). The task title is quoted on the card. The apology button does not give affinity back.
- Leaves a desk note (`kind = note`, written by the member's own client) that shows on the member's desk. A task that already has a note is not nagged again.
- Needs a mailbox poll before the day end (`MSG.primed`), a signed-in member, and a known assigner. Otherwise it does nothing and the NPC nag runs.

### 3.3 Reaction by assigner

Values come from `WORK_NAG` (`aff` = affinity loss, `mood` = mood loss). All 14 coworkers have an entry (v1.15.0).

| Coworker | id | Affinity | Mood | Punch | Tone and lines |
|---|---|---|---|---|---|
| Chị Ba | `an3` | −3 | −5 | yes | Scolds, mock-angry, playful light punch. 2 lines |
| Yến | `yen` | −2 | −3 | no | Puzzled, "Ủa, là sao?". 2 lines |
| Thảo | `thao` | −1 | −1 | no | Gentle, offers food or a drink. 2 lines |
| Anh Bảo | `bao` | −1 | −2 | no | Asks why, offers to move the deadline. 1 line |
| Chủ tịt (Thạnh) | `thanh` | −1 | −1 | no | Humble, karma joke. 1 line |
| Nam | `nam` | −1 | −1 | no | Peer-level, "khìn khìn". 1 line |
| Phú | `phu` | −1 | −1 | no | "Chắc mình xui lây qua bạn rồi". 1 line |
| Trung | `trung` | −1 | −2 | no | "Em nói thiệt", late work is double work. 1 line |
| Toàn | `toan` | −1 | −1 | no | Very short, quiet. 1 line |
| Hiện | `hien` | −1 | −1 | no | Polite, apologises for asking in a hurry. 1 line |
| Tùng | `tung` | −1 | −1 | no | "Tui thách bạn" a 10 o'clock challenge, a drink bet. 1 line |
| Chú 7 | `an7` | −1 | −1 | no | Easy-going, offers tea, asks not to tell Chị Ba. 1 line |
| Thông | `thong` | −1 | −1 | no | Calm, has a "phương án B", will sit beside you. 1 line |
| Nguyên | `nguyen` | −1 | −1 | no | Sleepy, chill. 1 line |

Wording is not native-reviewed. Roster and address terms: `docs/spec/dong-nghiep.md` §1 and §2.

### 3.4 Assigners and work voice

Every coworker can assign desk work (v1.15.0). Each sort set and each order set has a `from` field: 14 sort sets (one per coworker) and 15 order sets (one per coworker, and Chủ tịt has two). `newWork(kind)` picks one set of the right kind at random, among the sets whose assigner is in the office today (`times.arrive < 99999`). On a remote day Nguyên is not picked. If no assigner is in the office, it falls back to all sets.

Sets are picked uniformly, so Chủ tịt is more likely to assign an order task (2 of 15 sets) than any other coworker (1 of 15).

| Assigner | Sort set (projects, 6 notes) | Order set (items) | Voice on the card (`WORK_VOICE`) |
|---|---|---|---|
| Anh Bảo (`bao`) | App Dating, Game mới, App tiện ích | Báo giá, slide họp, thư mục, email của Nam | None. The generic line is used for both kinds |
| Chị Ba (`an3`) | Quảng bá app Dating, Nghiên cứu người dùng, Đào tạo người mới | Số liệu khảo sát, biên bản họp, bảng việc nhóm, ý tưởng cuối năm | "Em xếp mỗi ghi chú vào đúng nhóm giùm chị, nhanh nhanh nha." / "…đừng để chị phải nhắc lần hai." |
| Yến (`yen`, QC) | Lỗi giao diện, Lỗi kết nối, Lỗi chạy chậm | Kiểm lỗi đăng nhập, báo cáo lỗi, bảng theo dõi lỗi cũ, thử máy cũ | "Ủa, bạn xếp giùm chị mấy cái này vô đúng nhóm nha." / "Bạn xếp giùm chị mấy việc này…" |
| Thảo (`thao`, HR) | Tuyển dụng, Sự kiện nội bộ, Đào tạo | Lịch phỏng vấn, bánh sinh nhật, quán team building, danh sách nhân sự | "…Giúp chị đi, chị mua đồ ăn cho!" / "…Chị cảm ơn nhiều!" |
| Chủ tịt (`thanh`) | Nghiên cứu sản phẩm, Release, Doanh thu & hệ thống | Set 1: release chốt chưa, doanh thu tuần, bug, đối thủ. Set 2: doanh thu hôm nay, hỏi Yến về bug, nhắc Bảo chốt ghi chú, đọc nghiên cứu | Humble "Dạ, {anh} xếp giúp em…", karma joke |
| Nam (`nam`) | Màn hình mới, Lỗi cần sửa, Chờ design | Sửa app văng khi xoay, build thử cho Yến, màn hình chọn sở thích, dọn code cũ | "Bạn xếp giúp mình…" with "khìn khìn" |
| Phú (`phu`) | Máy chủ, Dữ liệu, Bảo mật | Máy chủ chậm, sao lưu, đổi mật khẩu quản trị, dọn dữ liệu trùng | "Hôm nay mình xui lắm, nhờ bạn cho chắc" |
| Trung (`trung`) | API, Xử lý nền, Báo cáo | API đăng nhập chậm, hàng đợi thông báo, tài liệu API, số liệu báo cáo tháng | "Em nói thiệt…" |
| Toàn (`toan`) | Thông báo, Lưu trữ, Thử nghiệm | Lỗi lưu ảnh, nén ảnh, thử mạng yếu, dọn bản nháp | Very short, no filler |
| Hiện (`hien`) | Mini game, Hình ảnh, Học hỏi | Hỏi lại yêu cầu, icon con mèo, tài liệu app chạy nhanh, viết lại đã học | Polite "Dạ, {anh}…", a student's worry |
| Tùng (`tung`) | Thử thách, Cuối tuần, Màn hình app | Sửa hiệu ứng ghép đôi, màn hình lịch sử trò chuyện, chốt quán thứ Sáu, nghĩ trò thử thách | "Tui thách bạn…", a drink bet |
| Chú 7 (`an7`) | Thử thủ công, Thử tự động, Báo cáo lỗi | Thử lại lỗi đăng nhập, chạy bộ thử tự động, ghi lỗi mới, pha trà | Offers tea |
| Thông (`thong`) | Nghiên cứu, Phương án dự phòng, Kế hoạch dài hạn | Phương án B cho máy chủ, thử gợi ý ghép đôi, đọc báo cáo xu hướng, kế hoạch quý sau | "…phương án B nếu lỡ sai" |
| Nguyên (`nguyen`, remote on some days) | Giao diện, Hình ảnh, Phác thảo | Bản vẽ hồ sơ, chỉnh nút theo ý Trung, icon mới, dọn thư mục thiết kế | Sleepy, chill: "…mình vẽ tiếp" |

`workBrief()` writes the request: "<name> gửi bạn N ghi chú và nhờ: “<voice>” Xếp xong hết là hoàn thành." For order tasks it ends "Chạm từng việc, việc gấp nhất chạm trước." The voice is run through `fill()`, so `{anh}` / `{Anh}` work. Anh Bảo's generic line is used when no voice is set.

The `bao` order set's item array is not sorted. The third value of each item is its rank in deadline order, by design.

### 3.5 Reachability (v1.15.0)

Every coworker has a `WORK_NAG` entry and at least one set, so every reaction line is reachable through `workNag()`. The v1.14.0 gap (Chủ tịt and Nam never assigned work) is closed. The fallback `|| WORK_NAG.thanh` runs only for an unknown id.

## 4. Acceptance criteria

Status legend as in `docs/spec/mot-ngay-o-cong-ty.md` §3.

| # | Criterion | Status |
|---|---|---|
| AC-100 | The desk work card lists "🪑 Ngồi làm việc (thời gian trôi qua)" first, before "▶ Bắt đầu làm" / "▶ Làm tiếp", and "Để lát nữa" last (§2.1) | Verified (v1.14.0, headless Chrome: menu order) |
| AC-101 | Choosing it seats the player at the desk, sets `G.mode` to `timelapse`, shows the `#tl` overlay with the clock, and switches to fast mode (§2.2) | Verified (v1.14.0, headless Chrome: mode switch, overlay) |
| AC-102 | The clock runs about 5 game minutes per real second (§2.2) | Verified (v1.14.0, headless Chrome: 15 game minutes in 3 s) |
| AC-103 | The camera yaw orbits slowly around the office, target (0, 0.5), distance 13, pitch 0.85 (§2.3) | Partly verified (v1.14.0, headless Chrome: yaw changes. The view was not checked in a screenshot) |
| AC-104 | A tap or click on the overlay, or Space, Enter, or Esc, restores camera and fast state and reopens the work card (§2.4) | Verified (v1.14.0, headless Chrome) |
| AC-105 | The time-lapse stops at the next milestone, shows the toast "🕘 hh:mm · <milestone>", and reopens the work card (§2.4) | Verified (v1.14.0, headless Chrome: stopped at 09:00) |
| AC-106 | At 18:00 the farewell scene replaces the time-lapse (`endTimelapse(false)`), and `endDay()` restores camera and fast state (§2.4). The end card follows the scene (AC-121) | Not recorded (code reading only) |
| AC-107 | "Để lát nữa" closes the card and stands the player up (§2.5) | Not recorded (code reading only) |
| AC-108 | List mode: overlay and clock only, no camera orbit (§2.6) | Not recorded (code reading only) |
| AC-109 | Time-lapse adds no task credit, `D.tasks` is unchanged (§2.3) | Not recorded (code reading only) |
| AC-110 | At day end with fewer than 2 finished tasks, the assigner shows one reaction card with a line from `WORK_NAG`, then the note card (§3.2) | Verified (v1.14.0, headless Chrome: reaction lines for `bao`, `an3`, `yen`, `thao`) |
| AC-111 | Reaction effects: affinity −aff, mood −mood, one moment, `D.stats.nagged` +1. The apology gives affinity +1 (§3.2, §3.3) | Not recorded (code reading only; values not measured) |
| AC-112 | Chị Ba's reaction plays the `punch` animation for 2.4 s (§3.3) | Not recorded (code reading only) |
| AC-113 | With 2 or more finished tasks, no reaction card. The note card follows directly (§3.2) | Verified (v1.14.0, headless Chrome: no-nag case) |
| AC-114 | An early leave (confirmed before 17:40, v1.16.0; was 17:10) runs the same check (§3.2) | Not recorded (code reading only) |
| AC-115 | The reaction lines of Chủ tịt and Nam can be shown (§3.3, §3.5) | Partly verified (v1.15.0, headless Chrome: both have a `WORK_NAG` entry and sets, so they are reachable). Not yet seen on the end-of-day card in play |
| AC-116 | Every coworker can assign a desk task, with a sort set, an order set, a voice and a reaction line. Remote Nguyên is not assigned on remote days (§3.4) | Verified (v1.15.0, headless Chrome: 14 distinct assigners in 400 draws, absent Nguyên never assigned in 300 draws, mini-game opens for a new set). Wording not native-reviewed |

## 5. Open items

- Camera orbit not viewed in a screenshot (AC-103).
- Not tested on touch devices: the overlay tap and the work card after a time-lapse.
- Not tested over a full real-time day (about 114 seconds of time-lapse, v1.16.0).
- `WORK_QUOTA` (2) and the affinity and mood losses are not tuned.
- "▶ Bắt đầu làm" after a time-lapse calls `playerSit()` while the player is still seated. Check that the sit-down animation is correct (code reading only).
- Native-speaker review of about 40 new strings from v1.15.0 (sort and order sets, work voices, nag lines) and the v1.14.0 lines.
- Balance of Chủ tịt's two order sets (§3.4).
- Hint wording: the order hint (`set.q`, shown above the chips) reads "Việc nào có hạn chót gần nhất thì chạm trước." in the sets of `bao`, `an3`, `yen`, and `thao`, and "Việc nào gấp nhất thì chạm trước." in the other sets. Pick one wording.

## 6. Related docs

- `docs/spec/mot-ngay-o-cong-ty.md`: §4.2 (day end, modes), AC-71 to AC-73 (desk task), AC-100 to AC-116 (this feature)
- `docs/spec/bang-nhiem-vu.md` §9: desk items unlocked by finished tasks
- `docs/spec/dong-nghiep.md` §1 and §7.7: roster and address terms
- `docs/product-guide.md`: "Your day", "Ending the day"
- `docs/tasks.md`: v1.14.0 and v1.15.0 follow-ups
