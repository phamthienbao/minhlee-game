# Spec: Ngồi làm việc và nhắc việc cuối ngày (sit-and-work, end-of-day nag)

Status: v1.14.0 (2026-11-04). Sit-and-work time-lapse at the player's desk (§2). Unfinished-work reaction from the assigner at day end (§3). Parent spec: `docs/spec/mot-ngay-o-cong-ty.md` (§4.2, AC-100 to AC-115 listed there). Desk task rules: `docs/spec/bang-nhiem-vu.md` §9 and `docs/spec/mot-ngay-o-cong-ty.md` AC-71 to AC-73.

Source of truth: `index.html`. Section 11: `workActivity()`, `startTimelapse()`, `endTimelapse()`, `workNag()`, `workBrief()`. Section 14: `update()`, `endDay()`. Variety block (between sections 2 and 3): `SORT_SETS`, `ORDER_SETS`, `WORK_VOICE`, `WORK_QUOTA`, `WORK_NAG`. DOM: the `#tl` overlay (`#tl-clock`).

## 1. Goal

Two changes to the desk task and the end of the day:

- The player can sit at the desk and let the clock run (time-lapse), instead of doing the task now.
- At 17:30, or on an early leave, a player who finished fewer than `WORK_QUOTA` desk tasks is reminded by the coworker who gave the work.

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
- A full 08:30 to 17:30 day takes about 108 real seconds at this speed.

### 2.4 Exit

| Trigger | Result |
|---|---|
| Tap or click `#tl`, or Space, Enter, or Esc | `endTimelapse(true)`: restores `G.fast`, camera yaw, distance and pitch. Hides the overlay. Calls `updateCamera(0, true)` (not in list mode). Sets `G.mode = 'play'` and reopens the work card. The player stays seated. |
| Next milestone (`currentMilestone(D.minute).id` differs from `G.tl.ms`) | `endTimelapse(true, "🕘 hh:mm · <milestone>")`: as above, plus a toast for 3.2 s. |
| 17:30, or early leave (`endDay()`) | `endTimelapse(false)`: restores camera and fast state, no card. The end-of-day flow (§3.2) follows. |

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
2. If `D.tasks < WORK_QUOTA`, it calls `workNag(showNote)`. Otherwise it calls `showNote()` directly.
3. `workNag(next)`:
   - Uses `D.work`, or creates one with `newWork()` (`sort` when `D.tasks` is even, `order` when odd). The assigner is `D.work.from`.
   - Picks one line at random from `WORK_NAG[from].lines`, filled with `fill()`.
   - Effects: affinity −`aff` (`changeAff`), mood −`mood` (`addMood`), the assigner added to `D.talked`, `Sfx.wrong()`, `D.stats.nagged` +1, and one moment: "Chưa xong việc <name> giao, bị <name> nhắc."
   - Bubble with the line (`sayNpc`). Chị Ba (`punch: true`) plays the `punch` animation for 2.4 s.
   - Card: "Sắp về mà việc <name> giao vẫn chưa xong, <name> ghé qua bàn bạn." with the line. One button, "Dạ, em xin lỗi, mai em làm", gives affinity +1 and calls `next()`.
   - If the assigner is not found (`npcById` returns nothing), it calls `next()` with no effects.
4. `showNote`: card "Trước khi về…". "📝 Có, viết một dòng" opens the note flow, then the summary. "Hôm nay thôi" goes to the summary.

Early leave: the confirm card "Bạn muốn kết thúc ngày làm sớm chứ?" (shown before 17:10) calls `endDay()`, so the same check runs.

### 3.3 Reaction by assigner

Values come from `WORK_NAG` (`aff` = affinity loss, `mood` = mood loss).

| Coworker | id | Affinity | Mood | Punch | Tone and lines |
|---|---|---|---|---|---|
| Chị Ba | `an3` | −3 | −5 | yes | Scolds, mock-angry, playful light punch. 2 lines ("Bực bội quá… chị đấm bây giờ đó!") |
| Yến | `yen` | −2 | −3 | no | Puzzled, "Ủa, là sao?". 2 lines |
| Thảo | `thao` | −1 | −1 | no | Gentle, "mai mình làm nhé", offers food or a drink ("Giúp chị đi, mai chị mua đồ ăn cho!"). 2 lines |
| Anh Bảo | `bao` | −1 | −2 | no | Asks why ("Vì sao vậy, có chỗ nào khó không?"), offers to move the deadline. 1 line |
| Chủ tịt (Thạnh) | `thanh` | −1 | −1 | no | Humble, karma joke. 1 line. Not reachable, see §3.5 |
| Nam | `nam` | −1 | −1 | no | Peer-level, "khìn khìn". 1 line. Not reachable, see §3.5 |

Wording is not native-reviewed. Roster and address terms: `docs/spec/dong-nghiep.md` §1 and §2.

### 3.4 Assigners and work voice

Each sort set and order set has a `from` field. Four coworkers assign work: `bao`, `an3`, `yen`, `thao`. Each has one sort set and one order set. `newWork()` picks one set of the right kind at random, so each assigner is equally likely for a given task.

| Assigner | Sort set (projects, 6 notes) | Order set (4 items) | Voice on the card (`WORK_VOICE`, sort / order) |
|---|---|---|---|
| Anh Bảo (`bao`) | App Dating, Game mới, App tiện ích | Báo giá, slide họp, thư mục, email của Nam | None. The generic line is used for both kinds |
| Chị Ba (`an3`) | Quảng bá app Dating, Nghiên cứu người dùng, Đào tạo người mới | Số liệu khảo sát, biên bản họp, bảng việc nhóm, ý tưởng cuối năm | "Em xếp mỗi ghi chú vào đúng nhóm giùm chị, nhanh nhanh nha." / "…đừng để chị phải nhắc lần hai." |
| Yến (`yen`, QC, v1.14.0) | Lỗi giao diện, Lỗi kết nối, Lỗi chạy chậm | Kiểm lỗi đăng nhập, báo cáo lỗi, bảng theo dõi lỗi cũ, thử máy cũ | "Ủa, bạn xếp giùm chị mấy cái này vô đúng nhóm nha." / "Bạn xếp giùm chị mấy việc này…" |
| Thảo (`thao`, HR, v1.14.0) | Tuyển dụng, Sự kiện nội bộ, Đào tạo | Lịch phỏng vấn, bánh sinh nhật, quán team building, danh sách nhân sự | "…Giúp chị đi, chị mua đồ ăn cho!" / "…Chị cảm ơn nhiều!" |

`workBrief()` writes the request: "<name> gửi bạn N ghi chú và nhờ: “<voice>” Xếp xong hết là hoàn thành." For order tasks it ends "Chạm từng việc, việc gấp nhất chạm trước." Anh Bảo's generic lines are used when no voice is set.

Yến and Thảo's sets were added in v1.14.0. Before that, only Anh Bảo and Chị Ba assigned work.

### 3.5 Known gap: Chủ tịt and Nam never reach their lines

`WORK_NAG.thanh` and `WORK_NAG.nam` exist, but no sort or order set has `from: 'thanh'` or `from: 'nam'`. `workNag()` only reads `WORK_NAG[w.from]`, so those two lines are never shown. The fallback `|| WORK_NAG.thanh` runs only for an unknown id. Decide whether Chủ tịt or Nam should assign work, or remove their lines (`docs/tasks.md`, v1.14.0).

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
| AC-106 | At 17:30 the end-of-day card replaces the time-lapse, and `endDay()` restores camera and fast state (§2.4) | Not recorded (code reading only) |
| AC-107 | "Để lát nữa" closes the card and stands the player up (§2.5) | Not recorded (code reading only) |
| AC-108 | List mode: overlay and clock only, no camera orbit (§2.6) | Not recorded (code reading only) |
| AC-109 | Time-lapse adds no task credit, `D.tasks` is unchanged (§2.3) | Not recorded (code reading only) |
| AC-110 | At day end with fewer than 2 finished tasks, the assigner shows one reaction card with a line from `WORK_NAG`, then the note card (§3.2) | Verified (v1.14.0, headless Chrome: reaction lines for all four assigners, `bao`, `an3`, `yen`, `thao`) |
| AC-111 | Reaction effects: affinity −aff, mood −mood, one moment, `D.stats.nagged` +1. The apology gives affinity +1 (§3.2, §3.3) | Not recorded (code reading only; values not measured) |
| AC-112 | Chị Ba's reaction plays the `punch` animation for 2.4 s (§3.3) | Not recorded (code reading only) |
| AC-113 | With 2 or more finished tasks, no reaction card. The note card follows directly (§3.2) | Verified (v1.14.0, headless Chrome: no-nag case) |
| AC-114 | An early leave (confirmed before 17:10) runs the same check (§3.2) | Not recorded (code reading only) |
| AC-115 | The Chủ tịt and Nam reaction lines are shown in play (§3.5) | Not verified (not reachable: no set assigns work from `thanh` or `nam`) |

## 5. Open items

- Camera orbit not viewed in a screenshot (AC-103).
- Not tested on touch devices: the overlay tap and the work card after a time-lapse.
- Not tested over a full real-time day (about 108 seconds of time-lapse).
- `WORK_QUOTA` (2) and the affinity and mood losses are not tuned.
- Chủ tịt and Nam lines unreachable (§3.5).
- "▶ Bắt đầu làm" after a time-lapse calls `playerSit()` while the player is still seated. Check that the sit-down animation is correct (code reading only).
- Native-speaker review of the nag lines and the work voices.

## 6. Related docs

- `docs/spec/mot-ngay-o-cong-ty.md`: §4.2 (day end, modes), AC-71 to AC-73 (desk task), AC-100 to AC-115 (this feature)
- `docs/spec/bang-nhiem-vu.md` §9: desk items unlocked by finished tasks
- `docs/spec/dong-nghiep.md` §1 and §7.7: roster and address terms
- `docs/product-guide.md`: "Your day", "Ending the day"
- `docs/tasks.md`: v1.14.0 follow-ups
