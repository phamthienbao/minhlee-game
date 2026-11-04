# Spec: Thẻ mục tiêu và bảng nhiệm vụ (goal card, mission board)

Status: v1.16.0 (2026-11-04). The `wrap` milestone starts at 17:30 (was 17:00), with the new hint (§3.2). Earlier: v1.13.0 (2026-11-04). The document-quest row and the afternoon hint no longer name the document (§3.3, §3.5; `docs/spec/nhiem-vu-tai-lieu.md`). Earlier: v1.9.0 (2026-11-04). Pause menu gets a "🎁 Đồ trên bàn làm việc" button (§2). Desk items unlocked by finished tasks are in §9 (AC-78 to AC-80). The goal card and board layout are as shipped in v1.8.0. v1.8.6 changes the morning hint (§3.1, §3.4), adds the desk world label (§2), and notes that the desk-task pause button is separate from the pause menu (§4).

Source of truth: `index.html`, section 10 (HUD, pause menu) and the `.obj` / `.qb` CSS in `<style>`. Parent spec: `docs/spec/mot-ngay-o-cong-ty.md` (§4.2 milestones and pause).

## 1. Goal

Two playtest findings:

- The objective line at the top of the screen was hard to see.
- The pause menu did not show what to do during the day.

The goal card is larger and tapping it opens the pause menu. The pause menu shows a mission board. The board reads the same data as the goal card (`MS` milestones and the side tasks), so the two never disagree.

## 2. Surfaces

| Element | Element id / class | Built by | Behavior |
|---|---|---|---|
| Goal card | `#hud-obj`, class `.obj`, inside `.hud-obj` | `updateHud()` | Shows "🎯 <milestone name>: <hint>" and a small line "Chạm để xem cả bảng nhiệm vụ". Tap pauses the game (§4). |
| Pause menu | `#modal` (via `Modal.open`) | `pauseGame()` | Title "⏸ Tạm dừng", a sub-line "Ngày N · HH:MM · <milestone>", then the buttons and the board. |
| Mission board | class `.qb` | `missionBoard()` | Three parts: current goal card, milestone list, side tasks (§3). |
| Desk world label | `Bubbles.makeTag()` in `init()` (`deskTag`), placed each frame in `frame()` | Text "💻 Bàn của bạn", above the player's desk (v1.8.6) | Shown in play mode, not in list mode, not while sitting, with fewer than `CFG.MAX_TASKS` tasks done, and within 10 m of the desk. Its horizontal position is clamped to the screen edges, so it points toward the desk when the desk is off-screen to a side. Hidden when its projected point is above 130 px or below `innerHeight - 40`. Not part of the board; listed here because it is the only HUD-style cue for the desk. |

Pause menu order: "▶ Tiếp tục" (resume), mission board, "⏭ Bỏ qua tới …" (only when a later milestone exists), "📖 Nhật ký ngày làm", "🎁 Đồ trên bàn làm việc" (v1.9.0, §9), "🔊 Bật/tắt âm thanh", "❓ Xem lại hướng dẫn", "🏠 Về màn hình chính".

The board is built once when the pause menu opens. The clock does not run while paused (`update()` skips simulation in `paused` mode), so the board does not need to refresh.

## 3. Mission board content

### 3.1 "🎯 Việc cần làm bây giờ"

- Milestone: `currentMilestone(D.minute)`.
- Text: the milestone's `hint()`. If its `done()` is true, the text is "Xong mốc này rồi! Cứ thong thả khám phá thêm."

The goal card uses the same rule with a different wording ("✔ … Xong mốc này! Cứ thong thả khám phá thêm.").

### 3.2 "Các mốc trong ngày": status of each milestone

One row per entry of `MS`: icon, start time (`fmtTime(from)`), name. Icons are chosen in this order:

| Order | Icon | Condition | Row style |
|---|---|---|---|
| 1 | ✅ | `done()` is true | `.row` (plus `.cur` if it is the current milestone) |
| 2 | ▶️ | Current milestone and not done | `.row.cur`. Its hint is shown underneath |
| 3 | ⏭ | Not done, and the clock has passed the next milestone's `from` | `.row.skip` (50% opacity). Underneath: "Đã qua, không sao cả, ngày vẫn tiếp tục" |
| 4 | ⏳ | Anything else (upcoming) | `.row` |

"Next milestone's `from`" for the last entry (`wrap`, 17:30 since v1.16.0; was 17:00) is `CFG.END + 1` (18:01). The clock reaches 18:01 only during the farewell scene (`docs/spec/tan-ca-18-gio.md`), when the board cannot be opened. So the `wrap` milestone is never ⏭ in play. Its `done()` is always false, so it shows ▶️ from 17:30 until the day ends.

### 3.3 "Việc nhỏ hôm nay": side tasks (`extraTasks()`)

Rows appear in this order. Done rows show ✅, open rows show 🔹.

| Row | Appears when | Done when |
|---|---|---|
| "Làm việc ở bàn của bạn (n/3)" | Always | `D.tasks >= 1`. The count is `D.tasks` out of `CFG.MAX_TASKS` (3) |
| "Giúp <name> tìm hồ sơ đã nhờ ở tủ tài liệu" | `D.quest.stage >= 1` | `D.quest.stage >= 3` |
| "Xem giúp chiếc máy in đang kẹt giấy" | `EVENT.printer` set and `D.minute >= EVENT.printer.start` | `EVENT.printer.solved` |
| "Dự tiệc sinh nhật <name> ở pantry" | `EVENT.cake` set and start ≤ time < end + 30 min | `D.flags.party` |
| "Để lại lời nhắn cho một đồng nghiệp trước khi về" | `D.minute >= 16:00` | `D.noteLeft` is set |

The afternoon file quest and printer jam are generated per day (`DOC_QUESTS`, `EVENT.printer`). See `docs/spec/mot-ngay-o-cong-ty.md` §4.2 and `docs/spec/noi-dung-bat-ngo.md`.

### 3.5 Afternoon hint with the document quest (v1.13.0)

The 13:30 milestone's `hint()` is `afternoonHint()` (section 10). The document quest adds two lines, and neither names the document:

- Stage 1 (asked): "<name> đang cần nhờ gì đó. Ghé bàn nói chuyện nhé."
- Stage 2 (accepted): "Tìm hồ sơ <name> đã nhờ ở tủ tài liệu (góc phải phía dưới, gần cửa). Quên thì ghé hỏi lại nhé."

The printer-jam line takes priority while that event is open. Rules: `docs/spec/nhiem-vu-tai-lieu.md`.

### 3.4 Morning hint (v1.8.6)

The "Buổi sáng" (09:00) milestone's `hint()` reads: "Đến bàn của bạn (có nhãn “💻 Bàn của bạn”, góc dưới bên trái, cạnh bàn Thông) rồi bấm nút “Làm việc”." Its `done()` is `D.tasks >= 1`, unchanged. The same text appears on the goal card and on the board (§3.1, §3.2), because both read `MS`.

For a signed-in member (v2.0.1-alpha), the location phrase "góc dưới bên trái, cạnh bàn Thông" is left out, because the member's desk is their character's own desk (`docs/spec/nhieu-nguoi-choi.md` §9). The label "💻 Bàn của bạn" stays.

## 4. Tap to open

- `init()`: `$('#hud-obj')` click calls `Sfx.click()`, then `pauseGame()` if `G.mode === 'play'`.
- `pauseGame()` does nothing when `G.mode !== 'play'` (title, dialog, card, modal, summary) or when `P.lock` is set (the player is sitting down or standing up).
- Only `.obj` receives taps. `.hud-obj` has `pointer-events: none` so the rest of the HUD row does not block the scene.
- The same pause path is used by P / Esc, the ⏸ button (`#b-pause`), and tab hidden.
- A desk task has its own button, "⏸ Tạm dừng (giữ nguyên tiến độ)", shown inside the mini-game. It is not this menu: it saves the task's progress (`D.work`, §4.2 of `docs/spec/mot-ngay-o-cong-ty.md`) and returns to play.
- `#hud-obj` is a `div` with a click handler. It has no `role`, no `tabindex`, and no Enter / Space handler, so keyboard users cannot focus it. P, Esc, and ⏸ cover keyboard and button users. See §7.

## 5. Acceptance criteria

| ID | Criterion | Status |
|---|---|---|
| MB-1 | Goal card shows 🎯, milestone name, hint, and "Chạm để xem cả bảng nhiệm vụ" | Partly verified (headless Chrome and 500 px screenshot, reported by requester) |
| MB-2 | Board at 08:30 shows the current goal and milestone icons | Verified (headless Chrome unit check, reported by requester) |
| MB-3 | Board at 14:50 shows the current goal and milestone icons | Verified (headless Chrome unit check, reported by requester) |
| MB-4 | Tapping the goal card pauses and opens the pause menu with the board | Verified (headless Chrome, reported by requester) |
| MB-5 | Board and goal card are readable at 500 px width | Verified by screenshot (reported as readable by requester) |
| MB-6 | Tap works on a real touch screen and phone safe area | Not verified (no real phone) |
| MB-7 | Wording reviewed by a native Vietnamese speaker | Not verified |
| MB-8 | Tap does nothing outside play mode or during a sit / stand transition | Not recorded (code reading only) |
| MB-9 | macOS app self-test passes on the rebuilt app | Verified (reported by requester) |
| MB-10 | Morning hint (§3.4) names the "💻 Bàn của bạn" label and the desk location, on the goal card and the board | Not recorded (text checked in `index.html`, code check only, 2026-11-04) |
| AC-78 | Each finished desk task adds 1 to `tasksTotal`. Each item unlocks when `tasksTotal` reaches its `need`, cumulative across days (§9.1, §9.2). | Verified (v1.9.0, headless Chrome: unlock thresholds) |
| AC-79 | Unlocked items appear on the player's 3D desk at day start and right after the unlock. Locked items are not drawn. All 8 items build (§9.3). | Partly verified (v1.9.0, headless Chrome: 8 items built. Look not reviewed visually; not on a real device) |
| AC-80 | The collection screen lists all 8 items. Unlocked ones show emoji, name, and description. Locked ones show the name and the tasks left (§9.4). | Not recorded (source check only, v1.9.0) |
| MB-11 | Desk world label (§2) shows in play mode, hides while sitting, after 3 tasks, and in list mode, and pins to the side edge when the desk is off-screen sideways | Not recorded (code check only, 2026-11-04). Headless Chrome only, per the v1.8.6 report; not re-run in the doc pass |

## 6. Data sources

| Source | Used for |
|---|---|
| `MS` (section 10) | Milestones, times, names, hints, `done()` |
| `currentMilestone(m)` | Current milestone |
| `CFG.MAX_TASKS`, `CFG.END` | Desk task cap and the end-of-day sentinel |
| `D` (day state) | `minute`, `tasks`, `quest`, `flags`, `noteLeft` |
| `EVENT` | `printer`, `printerNpc`, `cake` (daily events) |
| `fmtTime()` | Time labels |

## 7. Open items

- Not keyboard reachable. Options: `role="button"`, `tabindex="0"`, and an Enter / Space handler. Not decided. Tracked in `docs/tasks.md`.
- The `wrap` milestone (17:30 since v1.16.0) never shows ⏭ and stays ▶️ until the player leaves (§3.2). Decide whether it should show ✅ when the day ends.
- No real-phone test (MB-6). Wording review (MB-7).

## 8. Related docs

- `docs/spec/mot-ngay-o-cong-ty.md`: milestones, pause, HUD (§4.2, §10), desk task (AC-71 to AC-73)
- `docs/product-guide.md`: "The mission board" (player-facing)
- `docs/glossary.md`: goal card, mission board, milestone status
- `docs/tasks.md`: v1.8.0 follow-ups

## 9. Desk collection and unlocks (v1.9.0)

Source of truth: `index.html`, `UNLOCKS` (variety block, between sections 2 and 3), `awardWork()`, `showUnlocks()`, `nextUnlockLine()`, `showCollection()` (section 11), and `buildDeskItems()` (section 5).

### 9.1 Counting

- `Store.tasksTotal` counts every finished desk task, across all days. It is not reset each day.
- `D.tasks` is the per-day count, still capped at `CFG.MAX_TASKS` (3). `D.tasks` is not used for unlocks.
- Only a finished task counts (`finish(true)` in `startMiniGame()`). A paused or unfinished task does not count.
- The last item (25 tasks) needs at least 9 working days at the 3-task cap.

### 9.2 Items

| Need (tasks) | id | Item | Desk shape (primitives, `buildDeskItems()`) |
|---|---|---|---|
| 1 | `mug` | ☕ Cốc cà phê MinhLee | Red cylinder with a white label strip |
| 2 | `cactus` | 🌵 Chậu xương rồng mini | Terracotta pot, green cylinder, one side arm |
| 4 | `duck` | 🦆 Vịt cao su “Debug” | Yellow body, head, orange beak |
| 6 | `cat` | 🐱 Mèo may mắn | White body and head, two ears, red collar |
| 9 | `lamp` | 💡 Đèn bàn ấm áp | Dark base, grey pole, yellow shade |
| 13 | `frame` | 🖼 Khung ảnh cả team | Wooden frame with a light blue pane, turned |
| 18 | `phones` | 🎧 Tai nghe chống ồn | Dark headband and two earcups |
| 25 | `trophy` | 🏆 Cúp “Người đồng hành” | Wooden base, gold stem and cup |

Each item has a `slot` (x, z offset from the desk centre). The group sits at (`PLAYER_DESK.sx`, 0.75, `PLAYER_DESK.sz`) with y 0.75. For a signed-in member the desk is the character's own desk, and the group is rotated by π when the chair is on the north side of a long table (v2.0.1-alpha, `applyPlayerDesk()`, `docs/spec/nhieu-nguoi-choi.md` §9).

### 9.3 Unlock flow

1. A desk task finishes. `awardWork()` increments `tasksTotal`, adds every item whose `need` is reached to `unlocked`, and rebuilds the desk group if anything was added.
2. The requester's reply card shows first (if there is a requester). Then `showUnlocks()` shows one card per new item, with a "Xem tiếp" button while more remain.
3. The next desk task's work card shows the next item and how many tasks it needs (`nextUnlockLine()`). The line is not shown for a resumed task. After all items: "Bạn đã mở khóa hết đồ trên bàn."
4. `buildDeskItems()` runs at `startDay()` and after each unlock. It returns early in list mode (`LITE`) and with no scene. Unlocks are still saved in list mode, but nothing is drawn.

### 9.4 Collection screen

- Opened from the pause menu button "🎁 Đồ trên bàn làm việc" (§2).
- Header: "Hoàn thành đầu việc để mở khóa đồ cho bàn của bạn. Đã làm tổng cộng N việc."
- Unlocked item: emoji, name, description. Locked item: 🔒, name, and "Làm thêm N việc để mở khóa." (N is at least 1).
- "Đóng" returns to the pause menu.

### 9.5 Save data

- `tasksTotal` (number) and `unlocked` (array of ids) are read with `|| 0` and `|| []`. Existing saves load with both at zero or empty. The save key `mot-ngay-o-cong-ty.v1` is unchanged.
- "Xóa dữ liệu" removes the key, so both fields clear with it. See `docs/spec/mot-ngay-o-cong-ty.md` §5.

### 9.6 Open items

- Item looks are not reviewed visually (headless Chrome only). The 3D shapes are placeholders built from primitives.
- Not checked on a real phone or in Safari or Firefox.
- In list mode (`LITE`) the desk items are not drawn. The collection screen still works there (§9.3, step 4).
