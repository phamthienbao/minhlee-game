# Spec: Tan ca lúc 18:00 (farewell scene)

Status: v1.16.0 (2026-11-04). The workday ends at 18:00 (was 17:30). At 18:00 a farewell scene starts: the camera orbits the office, coworkers leave one by one with a goodbye line, and the end-of-day card follows. Toàn stays late. Parent spec: `docs/spec/mot-ngay-o-cong-ty.md` (§4.2, AC-117 to AC-124). Time-lapse stop at 18:00: `docs/spec/ngoi-lam-viec.md` §2.4.

Source of truth: `index.html`. Constants `CFG.END`, `CFG.FAREWELL` (section 1). `FAREWELL_LINES` (variety block, before `UNLOCKS`). Section 14: `tickClock()`, `startFarewell()`, `farewellEndText()`, `endFarewell()`, `update()` (farewell branch), `endDay()`. Camera: `updateCamera()` (section 8, honours `G.fw`). Milestone `wrap` in `MS` (section 10).

## 1. Goal

The day used to stop at 17:30 with a prompt. Now the day runs to 18:00 and the office empties in view of the player. One coworker, Toàn, is still working when the scene ends.

## 2. Timing

| Item | Value | Where |
|---|---|---|
| Day start | 08:30 | `CFG.START` |
| Workday end | 18:00 | `CFG.END` (was 17:30) |
| Scene allowance | 40 game-minutes (`CFG.FAREWELL`), so the clock can reach 18:40 during the scene | `CFG.FAREWELL` |
| Real time, 08:30 to 18:00 at normal speed | about 456 s (7.6 min) | `tickClock()`, `CFG.SPEED` 1.25 |
| Real time, 08:30 to 18:00 in time-lapse | about 114 s (5 game-min per s) | `docs/spec/ngoi-lam-viec.md` §2.3 |
| Early-leave confirm card | shown before 17:40 (`CFG.END - 20`), was 17:10 | door spot "Ra về" (section 11) |
| Surprise skip cut-off | 17:40 (`CFG.END - 20`), was 17:10 | `tickClock()`, `docs/spec/noi-dung-bat-ngo.md` §1 |
| Front door usable | from 16:00 (unchanged) | door spot |
| Light | new keyframe at 18:40 (dusk, purple-blue light, warm windows), after the 17:30 keyframe | `TOD` (section 5) |

## 3. Coworker leave times

`habits.leave` in `NPC_PROFILES`. Each day `resetNpcDay()` adds `rand(-3, 5)` minutes, so the actual leave falls in a window around the value.

| Coworker | id | `habits.leave` | Actual window | Note |
|---|---|---|---|---|
| Chủ tịt (Thạnh) | `thanh` | 18:12 | 18:09 to 18:17 | Leaves last among those who go |
| Toàn | `toan` | 19:00 | 18:57 to 19:05 | Stays after the scene, see §4.3 |
| Nguyên | `nguyen` | 18:00 | 17:57 to 18:05 | Hidden on remote days (`attendance`) |
| Chị Ba | `an3` | 18:00 | 17:57 to 18:05 | Was 17:15 |
| Phú, Trung, Hiện, Tùng, Nam, Thảo, Yến, Chú 7, Thông, Anh Bảo | `phu`, `trung`, `hien`, `tung`, `nam`, `thao`, `yen`, `an7`, `thong`, `bao` | 18:00 | 17:57 to 18:05 | |

Before v1.16.0 Nguyên was 17:00 and Chị Ba 17:15 (`docs/changelog.md` v1.16.0).

## 4. Flow

### 4.1 Start

`tickClock()` runs at every tick. When `D.minute >= CFG.END` and the day is not ended (`!D.ended`) and no scene is running (`!G.fw`):

- If `D.fwDone` is false, it calls `startFarewell()`.
- Otherwise it shows the end card (`farewellEndText()`, button "🏠 Về thôi" → `endDay()`).

`startFarewell()`:

- List mode (LITE): sets `D.fwDone = true` and returns. No scene. The next tick shows the end card.
- Otherwise: ends any time-lapse (`endTimelapse(false)`), hides the card, closes the modal, and sets `G.fw = { yaw, dist, pitch, toanSaid: false }`. Sets `G.mode = 'farewell'`, `CAM.dist = 12`, `CAM.pitch = 0.9`. Shows the toast "🌇 Sáu giờ chiều rồi. Cả văn phòng lần lượt tan ca…" (4.2 s) and plays the chime.

### 4.2 Scene

`update()` in `G.mode === 'farewell'`:

- Ticks the clock at normal speed (`tickClock()`). The clock is capped at `CFG.END + CFG.FAREWELL` (18:40) while `G.fw` is set.
- `CAM.yaw += dt * 0.12`, about one orbit every 52 s. `updateCamera()` uses target (0, 0.5) while `G.fw` is set.
- Each coworker whose goal becomes `leave` (not hidden) says one line from `FAREWELL_LINES` (fallback "Mai gặp nha!"), once per day (`n.saidBye`).
- Input is locked. Mode is not `play`, so no pause and no actions.

### 4.3 End

`endFarewell()` runs when every coworker except Toàn is hidden, or when the clock reaches 18:40:

- Restores the saved camera (`yaw`, `dist`, `pitch`). Calls `updateCamera(0, true)` outside list mode. Sets `D.fwDone = true` and `G.mode = 'play'`.
- Shows the end card (`farewellEndText()`):
  - Toàn still in the office: "Cả văn phòng đã ra về, chỉ còn Toàn ngồi lại làm tới 7 giờ tối. Bạn cũng về chứ?"
  - Toàn hidden: "Cả văn phòng đã ra về. Bạn về chứ?"
- Button "🏠 Về thôi" calls `endDay()` (`docs/spec/ngoi-lam-viec.md` §3.2): unfinished-work reaction, note card, summary.

Toàn's own line: at `D.minute >= CFG.END + 3` (18:03), if he is seated, he says `FAREWELL_LINES.toan` once (`G.fw.toanSaid`). His 19:00 leave is after the scene, so it is never shown.

### 4.4 Skipped or changed paths

| Case | Result |
|---|---|
| Player leaves through the front door before 18:00 | `endDay()` directly. No scene |
| Player leaves through the door at 17:40 to 17:59 | `endDay()` directly, no confirm card (before 17:40 the confirm card appears) |
| Time-lapse reaches 18:00 | Time-lapse stops (`endTimelapse(false)`), then the scene starts |
| List mode (LITE) | No scene. The end card shows on the next tick |

Card.show() sets `G.mode = 'dialog'`, so the end card does not repeat each frame.

## 5. Camera and light

- `updateCamera()` (section 8): `G.fw` sets target (0, 0.5) and the scene pitch and distance are applied by `startFarewell()`.
- Saved camera is restored in `endFarewell()`. Check that the restored distance equals the player's preset (see §8).
- `TOD` (section 5) has a new keyframe at 18:40 (`sun` 0x8a78b0, purple-blue, warm windows `win` 0xffd9a0). Light keyframes are read by clock minute.
- The sun's arc in `applyTimeOfDay()` uses `t = clamp((m - CFG.START) / (CFG.END - CFG.START), 0, 1)`. It stops at 18:00, while the light keyframes keep moving to 18:40.

## 6. Goodbye lines

`FAREWELL_LINES` has one line per coworker (14 entries). Two are personality rules:

- Chủ tịt (`thanh`): "Cả nhà về cẩn thận nha. Em tắt đèn rồi mới về. Toàn ơi, đừng ở khuya quá nha!"
- Toàn (`toan`): "Mọi người về cẩn thận. Mình ở lại làm thêm chút, tới bảy giờ."

Other lines are in the code. They are not native-reviewed.

## 7. Other time changes in v1.16.0

| Where | Before | Now |
|---|---|---|
| Milestone `wrap` (`MS`, section 10) | from 17:00 | from 17:30. Hint: "Sắp hết giờ rồi! Đúng 6 giờ cả văn phòng tan ca. Nhớ để lại lời nhắn trước khi về nhé." |
| Toast at 17:30 (`processTimeEvents()`) | not recorded | "🌇 Còn nửa tiếng nữa là tan ca. Đến 6 giờ cả văn phòng sẽ ra về!" |
| `periodGreet()` (section 9) | not recorded | "Chiều rồi" until 17:30, then "Sắp tan làm rồi" |
| Desk-chat option "💼 Trao đổi công việc" in `startTalk()` | not recorded | shown from 09:00 until 17:30 |
| Tùng's quirk "Sắp tan làm rồi! Ai đi nhậu giơ tay!" | 16:50 | 17:35 (`ctx: 'any'`) |
| Light keyframe (`TOD`) | none at 18:40 | 18:40 dusk |

"Not recorded" means the previous value is not in the docs. The v1.16.0 change list gives only the new values for these rows.

## 8. Acceptance criteria

| # | Criterion | Status |
|---|---|---|
| AC-117 | The clock runs to 18:00. At 18:00 the scene starts: input locked, `G.mode` is `farewell`, toast shown | Verified (v1.16.0, headless Chrome, reported by the requester: scene entered). Not re-run in the doc pass |
| AC-118 | The camera orbits the office (target (0, 0.5), distance 12, pitch 0.9, yaw about 0.12 rad/s). The saved camera is restored at the end | Partly verified (headless Chrome: orbit and restore. Restored distance 10.5 equals the saved value; the preset was not compared. Not viewed in a screenshot) |
| AC-119 | Each coworker who starts leaving says one goodbye line, once | Partly verified (headless Chrome: 13 coworkers left in this order: nguyen, thao, nam, yen, hien, an7, an3, thong, bao, trung, tung, phu, thanh. Bubbles not viewed) |
| AC-120 | Chủ tịt leaves last of the coworkers who go. Toàn stays seated and is not gone before the scene ends | Verified (headless Chrome: Toàn seated when the scene ended) |
| AC-121 | The scene ends when all but Toàn have left, or at 18:40, then the end card shows the matching text | Partly verified (headless Chrome: ended about 18:32 with the Toàn-stays text. The text for the other branch was not recorded) |
| AC-122 | Leaving through the front door before 18:00 skips the scene. List mode shows the end card without a scene | Not recorded (code reading only) |
| AC-123 | Door confirm card before 17:40 only. From 17:40 the door ends the day with no confirm card | Not recorded (code reading only) |
| AC-124 | Milestone `wrap` starts at 17:30 with the new hint, and the 17:30 toast shows | Not recorded (code reading only) |

## 9. Known limits

- `Store.session` is saved every 5 s during the scene. A reload resumes at about 18:xx and quickly runs the end of the scene again. `validSession()` accepts only minutes below 18:01 (`S.minute < CFG.END + 1`), so a save from later in the scene is not restored.
- `D.fwDone` is not saved. After a reload at 18:00 or later the scene can play again.
- Toàn's 19:00 leave is never visible in play (the scene ends at 18:40).
- Goodbye lines are not native-reviewed. Scene not viewed as a screenshot or video. Not tested on touch devices or real phones.

## 10. Open items

- View the scene in a browser (screenshot or short video) at the default camera distance (Vừa). Check the camera framing at 18:00 and after the restore.
- Decide whether the scene should save its state, so a reload does not replay it (see §9).
- Decide whether Toàn's 19:00 leave should be shown after the end card or stay hidden.
- Native-speaker review of the 14 goodbye lines (`FAREWELL_LINES`).
- Tracked in `docs/tasks.md`: the remaining "17:30" wording in docs and strings.

## 11. Related docs

- `docs/spec/mot-ngay-o-cong-ty.md`: §4.2 (day clock, modes), §3 (pointer row for AC-117 to AC-124; the criteria are in §8 here)
- `docs/spec/ngoi-lam-viec.md`: §2.4 (time-lapse stops at 18:00), §3.2 (end-of-day flow)
- `docs/spec/dong-nghiep.md` §3: leave times and Nguyên's remote days
- `docs/spec/bang-nhiem-vu.md` §3.2: the `wrap` milestone row
- `docs/product-guide.md`: "Your day", "Ending the day"
