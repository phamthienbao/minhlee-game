# Spec: Một Ngày Ở MinhLee

Status: v1.12.0 (2026-11-04). Round pantry table with a ring of 8 spots, and cups and dishes on the table during treats (§4.2, AC-93, AC-94). Takeaway cups, random 11:05 drink, and the pantry gathering for Chủ tịt's treats (§4.2, AC-87 to AC-90). Earlier: v1.11.0 (2026-11-04). Office layout: new lower-row desk 13 (Tùng moves there), and Nguyên sits at desk 8 (§6, `docs/spec/van-phong-layout.md`). Earlier: v1.10.1 and v1.10.0. Trung visits Nguyên, with two new duo scripts (§4.2; `docs/spec/noi-dung-bat-ngo.md` §2). Welcome-back popup on boot (AC-84; `docs/spec/the-gioi-lien-tuc.md` §11.5). Mid-day save and resume (`Store.session`, §4.2, AC-81 to AC-83; `docs/spec/the-gioi-lien-tuc.md` §11). Earlier: v1.9.2 (2026-11-04). Detailed looks for five coworkers (`look.detail`, `docs/spec/dong-nghiep.md` §8). Earlier: v1.9.0. Six new day themes with story intros, and desk items unlocked by finished desk tasks (`tasksTotal`, `unlocked`; see `docs/spec/noi-dung-bat-ngo.md` §3.2 and `docs/spec/bang-nhiem-vu.md` §9). Earlier: v1.8.6. Desk task reworked around a requester, with progress kept on pause (AC-71 to AC-73); Thông, Thảo, and Toàn looks updated from photos (§4.4). Nguyên's look is from the user's reference photo (v1.8.5). Earlier releases are in `docs/changelog.md`.

## 1. Goal

A solo, offline-playable, Vietnamese-language office-day simulation. The player is a brand-new employee who types an optional name and picks a gender on the title screen. They spend one work day (08:30–17:30) in a small office at MinhLee, a fictional company that builds mobile apps and games (flagship product: App Dating). The office has 14 fictional, computer-controlled coworkers (NPCs). There is no fail state, no score, and no ending. Each day ends with a summary and a diary entry. Days follow one another Monday to Friday, then a weekend vignette, then Monday again.

## 2. Constraints

| Area | Constraint |
|---|---|
| Delivery | Single file: `index.html`. Optional generated copy `index-offline.html` (see `docs/spec/phan-phoi-offline.md`). Optional macOS app `dist/MinhLee.app` (`docs/spec/phan-phoi-offline.md` §8). No bundler, no package manager. |
| Rendering | Three.js 0.160.0 loaded via an import map from `https://cdn.jsdelivr.net/npm/three@0.160.0/build/three.module.js` (`index.html`), or inlined as a data URL (`index-offline.html`). |
| Network | `index.html`: required on first load to fetch Three.js. `index-offline.html`: no network at all. Gameplay makes no network calls. |
| Audio | Web Audio API only, synthesized in code. No audio files. |
| Persistence | `localStorage` only, key `mot-ngay-o-cong-ty.v1`. Holds player data, the world state (`world`, `recentEv`, `lastTheme`), and the day in progress (`session`, v1.10.0). No accounts, no server. |
| Language | UI text and all dialogue in Vietnamese. |
| Art | Low-poly 3D built from primitives; chibi-style characters. |
| Fiction | All characters, MinhLee, and its products (including App Dating) are fictional. |
| Tone | Coworkers are friendly and funny. Quirks are playful, never hostile toward the player. |
| Logging | `dlog()` prints only on localhost/127.0.0.1 or with `?debug` in the URL. Release builds print nothing. |
| Input | Keyboard + mouse (desktop), touch joystick + tap (touch devices). Layout switches by pointer type. |

## 3. Acceptance criteria

Status legend: `Verified` = headless Chrome run via a throwaway harness (not in the repo). `Partly verified` = harness or screenshots only, not checked by hand. `Not recorded` = not separately checked. `Not verified` = not tested on real hardware.

| # | Criterion | Status |
|---|---|---|
| AC-1 | Title screen shows 4 selectable avatars, an optional name field (max 16 chars, no default), and gender chips Nam / Nữ / Không nêu (default Không nêu). | Not recorded |
| AC-2 | "Bắt đầu ngày mới" starts a day at 08:30 with the player inside the office. | Verified (full simulated day) |
| AC-3 | Clock advances from 08:30 to 17:30; at 17:30 the player is prompted to go home. | Verified (full simulated day) |
| AC-4 | Movement via WASD/arrows is collision-free against furniture and walls. | Verified (no collision violations: v1.1.0 12-day run with 13 NPCs; v1.2.0 re-run with 14 NPCs). The v1.1.0 long run recorded transient NPC overlap samples, and v1.0.3 recorded one. Both are logged in `docs/tasks.md` as known minor issues |
| AC-5 | Interactions appear as the large action button (or E/Space/Enter) when near a spot or coworker. | Verified (activities completed) |
| AC-6 | Milestones 08:30 → 17:00 show the correct hint and mark done when complete. | Verified (full simulated day) |
| AC-7 | Morning task (mini-game) can be completed; task counter increases; max 3 per day. | Verified (activities completed) |
| AC-8 | Meeting (10:00–10:55) can be joined; if missed, a summary note is granted. | Verified (activities completed) |
| AC-9 | Break/lunch at pantry sets the break/lunch flags; lunch window 12:00–13:40. | Verified (activities completed) |
| AC-10 | Document favor quest (from 13:45) can be accepted and completed at the cabinet. | Verified (activities completed) |
| AC-11 | Daily event: printer jam (14:30) or cake party (15:20–15:55), never both. | Verified (activities completed) |
| AC-12 | Wrap-up: optional sticky note (max 50 chars) to one coworker, then summary modal. | Verified (full simulated day) |
| AC-13 | Summary is written to `localStorage` and appears in the diary (max 150 entries since v1.1.0; was 40). | Verified (localStorage write). The 150-entry cap is Not recorded (see AC-36 in `the-gioi-lien-tuc.md`) |
| AC-14 | Diary and data reset ("Xóa dữ liệu") work from title and diary screens. | Not recorded |
| AC-15 | Without WebGL, the game falls back to list mode (`#lite`) with buttons for coworkers and spots. | Verified (no-WebGL list mode) |
| AC-16 | No uncaught JavaScript errors during a full simulated day. | Verified (no JS errors: v1.1.0 12-day run with 13 NPCs; v1.2.0 re-run with 14 NPCs) |
| AC-17 | Touch joystick, tap action button, drag-to-rotate, safe-area layout on phones. | Not verified (no real phone or touch input) |
| AC-18 | Audio output audible on real devices; mute toggle silences output. | Not verified (no audio output check) |
| AC-19 | Rendering and input on Safari, Firefox, Android Chrome. | Not verified |
| AC-20 | NPC lines fill `{ten}` and `{anh}`/`{Anh}` from the player's name and gender; empty name shows "bạn". No raw placeholders in bubbles or cards. Nam's `{{anh}}` defect fixed in v1.0.2. | Partly verified (no raw placeholders in a 13-NPC run; name/gender combinations not separately recorded) |
| AC-21 | 🎥 HUD button cycles the camera presets Gần / Vừa / Xa (nhìn từ trên); the choice persists in `settings.cam` and is applied at the start of each day. | Partly verified (harness and screenshots only) |
| AC-22 | Chủ tịt's (Thạnh's) treat events at 11:05 and 14:10 fire once each when Chủ tịt is on the floor (energy, mood, affinity, diary moment, toast). | Partly verified (harness and screenshots only) |
| AC-23 | Chị Ba's punch animation plays on her 09:12 quirk and as her visit opener. | Partly verified (harness and screenshots only) |
| AC-24 | Portrait phone camera framing (FOV 58, look-ahead, pitch range) keeps desks from hiding people. | Not verified (headless Chrome only) |
| AC-25 | Branding: window title and title panel read "Một Ngày Ở MinhLee"; north-wall logo sign reads "MinhLee"; front-door mat reads "MinhLee". | Not recorded (strings checked in `index.html`; not checked visually in a browser) |
| AC-26 | Content pools: meeting topic (`MEETING_TOPICS`) and sort-game projects (`SORT_SETS`) use the v1.0.3 text, and no old project names appear in rendered text. | Not recorded (strings checked in `index.html`; a random draw was not recorded per topic or set) |
| AC-27 | Diary intro (`showDiary()`): during day 1 the diary does not say "0 ngày làm việc"; mid-day it shows the workday number and that the entry is written at day's end (day 1 with no entries adds the first-day line); on the title screen it shows days worked, or "Chưa có ngày làm nào được ghi lại." when 0. | Verified (headless Chrome unit check of mid-day day 1, mid-day day 2, and title screen, reported by the requester). Not on devices. Vietnamese wording not reviewed by a native speaker |
| AC-71 | Desk task (`workActivity()`) opens a work card naming the requester (role "Đang nhờ bạn"), a briefing (N notes to sort, or N tasks to order), "about 30–60 seconds", and "no score, no penalty". "▶ Bắt đầu làm" starts a new task. "▶ Làm tiếp" resumes an unfinished one. | Partly verified (headless Chrome only, reported by requester; not re-run in the doc pass) |
| AC-72 | Pausing a desk task ("Để lát nữa (không mất gì)" or "⏸ Tạm dừng (giữ nguyên tiến độ)") keeps `D.work`: the same set, done items, and order. The task resumes from there. `D.work` clears only on completion, or at a new day. | Partly verified (headless Chrome only, reported by requester; not re-run in the doc pass) |
| AC-73 | Requester reaction on completion: +3 affinity for the requester, and a card with their reply. Mini-game hints: a group or item is outlined (`.glow`) after 2 wrong answers. | Partly verified (headless Chrome only, reported by requester; not re-run in the doc pass) |
| AC-81 | Closing the tab or reloading mid-day, then reopening, shows the welcome-back popup (AC-84) with "▶ Tiếp tục ngày đang dở", and the title-screen button "▶ Tiếp tục ngày đang dở (hh:mm)". Pressing either restores the minute, tasks, energy, mood, desk task progress, position, affinity, day theme, NPC times, and surprises. | Partly verified (headless Chrome, 2026-11-04: snapshot fields restored and button visibility checked). Real browser restart and real devices not tested |
| AC-82 | The session is cleared at day end, on exit to title, and on "🔄 Bắt đầu lại ngày này". The next start is a new day at 08:30. | Partly verified (headless Chrome: session cleared. Coverage of each clear path not recorded) |
| AC-83 | A failed restore logs the error and stack, clears the session, and starts a new day. The player sees no raw error. | Source check only (2026-11-04). Not run |
| AC-84 | On boot with saved data (`days > 0` or a valid session) the welcome-back popup shows "Chào mừng <tên> quay lại!" and its buttons: "▶ Tiếp tục ngày đang dở" or "▶ Tiếp tục chơi", "🆕 Chơi mới" (a confirmation; "Xóa hết và chơi mới" clears all saved data, "Thôi, quay lại" returns to the popup). While the popup is open, the name and gender form (`#title`) is hidden; it appears only after the confirmed reset. A first-time player with no data sees the name screen directly. | Partly verified (headless Chrome, 2026-11-04: popup text and buttons, continue resumes at 13:10 with 1 task, back keeps data and keeps the form hidden, clear leads to 0 days and shows the form, fresh player sees no popup). Not tested across a real browser restart or on a real device |
| AC-87 | Chủ tịt's 11:05 treat picks at random among trà sữa, rau má, and nước mía. The 14:10 treat is đồ ăn vặt (snack, no cups). The toast names the item and ends with "Ra pantry nhé!" | Partly verified (v1.12.0, headless Chrome: all three drink kinds appeared across runs. Draw spread not measured) |
| AC-88 | Up to 8 present coworkers (Chủ tịt first) join the treat at the pantry for 30 game-minutes. Each other present coworker gets a cup on their desk | Partly verified (v1.12.0, headless Chrome: 8 joined, 14 got a cup, 7 at the pantry in one test. Not on a real device) |
| AC-89 | Joiners carry the takeaway cup in hand until 12 minutes after the gathering ends, then it sits on their desk until 110 minutes after the treat starts. The cup looks like a takeaway cup | Partly verified (v1.12.0, headless Chrome: desk cups present later. Close-up renders reviewed. In-game visibility at the default camera distance not verified; not checked on a real device) |
| AC-90 | The mid-day session saves and restores `EVENT.treat`, and each coworker's `joinsTreat` and `treat` | Partly verified (v1.12.0, headless Chrome: session saved `treat`. Restore after a reload not recorded for this release) |
| AC-93 | The pantry has a round table (`PANTRY_TABLE`) with 8 standing spots around it, all in free nav cells. During a drink treat the table shows one takeaway cup per joiner who has not yet picked theirs up, and each cup goes as its owner arrives. During the 14:10 snack treat one random dish (`FOODS`) is shown on the table for the 30-minute event. Nothing is shown after the event ends | Partly verified (v1.12.0, headless Chrome: 8 cups at the start, 1 later, 0 after the end; each of the 4 dishes shown alone; all 8 spots walkable. Full day and real device not run) |
| AC-94 | A joiner holds the takeaway cup only after reaching the pantry, or while carrying it back. Non-joiners never hold a cup; theirs goes to the desk | Partly verified (v1.12.0, headless Chrome: 7 joiners holding cups in one run. Not on a real device) |

## 4. Architecture

### 4.1 File layout

One HTML file with three parts: a `<style>` block, the static DOM (`#game`, `#hud`, `#title`, `#card`, `#modal`, `#lite`, `#toast`, `#tut`), and one `<script type="module">` split into 14 numbered sections (listed in the header comment of the script).

| § | Section | Responsibility |
|---|---|---|
| 1 | Tiện ích & cấu hình chung | Helpers, `dlog`, `CFG` (times, speed, meeting window), `fill()` (placeholders) |
| 2 | Hồ sơ đồng nghiệp | `NPC_PROFILES` (14 entries), `AVATARS`, `MEETING_TOPICS`, `DOC_QUESTS` |
| 3 | Lưu dữ liệu | `Store` wrapper around `localStorage` |
| 4 | Âm thanh | `Sfx` (Web Audio) |
| 5 | Cảnh văn phòng 3D | Scene, lights, office geometry, `LONG_TABLES`, `DESKS` (14 coworker seats), `PLAYER_DESK`, `COLUMNS`, `MEET_ROOM`, `MEET_TABLE`, `PANTRY_SPOTS`, `SOFA_SEATS`, `LOUNGE_SEAT` (pantry daybed). Coordinates: `docs/spec/van-phong-layout.md` |
| 6 | Nhân vật & hoạt ảnh | `buildCharacter`, `poseCharacter` (idle, type, check, drink, talk, wave, punch, eat, ...) |
| 7 | Dẫn đường & va chạm | Nav grid, pathing, `separateCharacters`, speech bubbles |
| 8 | Người chơi & điều khiển | `P`, `CAM`, `CAM_PRESETS`, `updateCamera`, `INPUT`, keyboard/pointer/joystick handling |
| 9 | Đồng nghiệp AI | `NPCS`, daily schedule, `updateNpc`, `npcAmbient`, `runVisit` |
| 10 | Giao diện | Card, modal, HUD (incl. 🎥 button), tutorial, pause menu, milestones `MS` |
| 11 | Hoạt động & trò nhỏ | `SPOTS`, desk task mini-game, meeting, pantry, cabinet, printer, notice board |
| 12 | Hội thoại & tình huống | `startTalk`, quest flow, note flow |
| 13 | Nhật ký | `showDiary` |
| 14 | Vòng đời một ngày | `newDayState`, `startDay`, `setCamPreset`, `processTimeEvents`, `tickClock`, `endDay`, `showSummary`, `frame`, `init` |

### 4.2 Runtime model

- **Modes:** `G.mode` is one of `title`, `play`, `dialog`, `modal`, `paused`, `summary`. `update()` skips simulation in `title` and `paused`.
- **Clock:** `tickClock(dt)` advances `D.minute` at `CFG.SPEED` (1.25 game-minutes per real second). A full day is about 7.2 real minutes; fast-forward multiplies by `CFG.FAST` (4).
- **Day state:** `D` is recreated by `newDayState()` each day. It holds minute, tasks, energy, mood, talked/greeted sets, flags, quest stage, moments (max 14), the day `theme`, the day's `surprises` list, and `work` (`D.work`, the current desk task, or `null`). `D.work` is kept when the player pauses the task, set to `null` when the task is finished, and reset at a new day by `newDayState()` (v1.8.6).
- **Persistent state:** `Store` holds name, gender, avatar, day count, diary (max 150), affinity per coworker, settings (`sound`, `tutorial`, `cam`), and the world state (`world.users`, `recentEv`, `lastTheme`). Affinity `AFF` is loaded from `Store` at boot. `Store.session` (v1.10.0) holds a snapshot of the day in progress, written every 5 s of play and when the tab hides. It is cleared at day end and on exit to title. Details: `docs/spec/the-gioi-lien-tuc.md` §11.
- **Diary intro (v1.7.2):** `showDiary()` picks the intro line from context. During a day (previous mode `paused` or `play`, `D` set, not ended), it shows the workday number (`Store.days + 1`) and says the entry is written at the end of the day. On day 1 with no entries, a second line explains the first entry. Outside a day (title screen, summary), it shows days worked, or "Chưa có ngày làm nào được ghi lại." when `days` is 0. Exact strings in `docs/changelog.md` v1.7.2.
- **Calendar and world:** day N is weekday `(N-1) % 5` of week `floor((N-1)/5)+1`; there is no ending. Details in `docs/spec/the-gioi-lien-tuc.md`.
- **Placeholders:** `fill(text)` replaces `{ten}` with the saved name (or "bạn" if empty) and `{anh}` / `{Anh}` with "anh" (`nam`), "chị" (`nu`), or "anh/chị" (`khac`). It runs when bubbles and cards are rendered.
- **Milestones:** `MS` is an ordered list of 7 entries with a `from` time, a hint, and a `done()` predicate. `currentMilestone()` returns the latest entry whose `from` has passed. The goal card and the pause-menu board both read `MS` (`docs/spec/bang-nhiem-vu.md`).
- **Spots:** `SPOTS` entries have position, radius, icon, label, `enabled()` and `run()`. `computeNearest()` picks the closest enabled spot or coworker in range.
- **Coworker schedule:** each NPC has `habits` (arrive, coffee, lunch, leave, joinsMeeting, and in v1.2.0 `lounge` and `attendance` for the remote worker Nguyên, see `docs/spec/dong-nghiep.md` §3) and `stats` (outgoing, focus, team). `decideGoal()` and `updateNpc()` drive movement and states. Chủ tịt's (Thạnh's) `arrive` is 09:20 (the late-arrival note is in `traits`, a maintainer note only). Pace (v1.3.0): `CFG.NPC_SPEED` is 1.9 (was 1.55), lunch lasts 55 minutes (was 45), and each coffee window is 16 minutes (was 13).
- **Quirks:** `quirks` entries fire once per day within 8 game minutes of their `at` time, only when the optional `ctx` matches (default `desk`). The optional `anim` plays for 3.5 s when the line is shown. Rules in `docs/spec/dong-nghiep.md` §7.
- **Visits:** a coworker may visit a seated colleague's desk during windows 09:05–09:50, 13:35–14:45, and 15:40–16:50. A visit ends after 3 completed stages (then a 70–150 s cooldown) or after 15 seconds (ends without that cooldown). Visits are started from the cooldown loop in `npcAmbient()`, not from a daily count. On stage 0, the visitor plays `visitAnim` for 2.4 s if the profile sets one (only Chị Ba: `punch`). Nineteen coworker pairs have scripted duo lines, 23 scripts in total (see `docs/spec/noi-dung-bat-ngo.md`). Nguyên may also start a visit (v1.10.0), but only to Chị Thảo's desk (she must be at `desk:work`); he never visits from the daybed. Trung may visit Nguyên instead: 40% per visit attempt while Nguyên is at his desk, on a sofa seat, or on the daybed. Since v1.11.0 Nguyên has desk 8, so Trung walks to that desk's visit point (`noi-dung-bat-ngo.md` §2).
- **Treat events (Chủ tịt):** `processTimeEvents()` fires two events when the clock crosses 11:05 and 14:10, including on a time skip. Each fires only if Chủ tịt is not hidden. Effects: +8 energy, +3 mood, +2 affinity with Thạnh, one diary moment, a toast, a chime, and a line from Thạnh. Since v1.12.0 the 11:05 drink is random (trà sữa, rau má, or nước mía). The pantry table (`PANTRY_TABLE`) shows the cups, or one dish at 14:10 (AC-93). Up to 8 present coworkers gather at the pantry for 30 game-minutes (`startTreat()`); the others get a takeaway cup on their desk. Details: `docs/spec/noi-dung-bat-ngo.md` §3.1.
- **Camera presets:** `CAM_PRESETS` has three entries, all viewed from above: Gần (pitch 0.98, distance 7.5), Vừa (pitch 1.12, distance 10.5, default), and Xa (nhìn từ trên) (pitch 1.3, distance 14). The 🎥 HUD button (`#b-cam`) cycles them. `setCamPreset()` stores the index in `settings.cam` and shows a toast. `startDay()` applies the saved preset.
- **Camera framing:** `updateCamera()` aims 1.3 m ahead of the player along the camera's yaw, so the player can see what is coming. Field of view: 58 when the aspect ratio is below 0.8 (portrait), 50 below 1.2, otherwise 44. Drag changes pitch within 0.6–1.4. The camera distance is limited so it stays within the office bounds (`updateCamera` clamps it against the room limits).
- **Content pools (per day):** `D.meetTopic` is picked from `MEETING_TOPICS` in `newDayState()`, or from `mondayTopic()` on Mondays. Each desk-task mini-game picks one set from `SORT_SETS` or `ORDER_SETS`. The document favor picks from `DOC_QUESTS`. The day theme, surprises, and gossip use the v1.1.0 pools (see `docs/spec/noi-dung-bat-ngo.md`).
- **Fallback:** if both `new THREE.WebGLRenderer` attempts (antialias on, then off) throw, `LITE = true`; `refreshLite()` renders the interaction list into `#lite`, and `update()` runs on a 100 ms `setInterval`. v1.7.0 adds a render watchdog and a 4 s context-loss timer that switch to list mode mid-game (`docs/spec/tuong-thich-trinh-duyet.md` §2).
- **Pause:** `G.mode` is set to `paused` by `pauseGame()` (P/Esc, ⏸, tapping the goal card `#hud-obj`, or tab hidden). The pause menu shows the mission board under "▶ Tiếp tục". `resumeGame()` returns to `play`. Simulation and the clock do not advance while paused. A desk task has its own pause button (`pauseBtn()`), which saves `D.work` and returns to `play` without opening this menu (v1.8.6).
- **Spots on time skip:** skipping to a milestone (`skipTo`) releases occupied spots (`snapNpcsToSchedule` calls `releaseSpots`) and clears active visits, so pantry slots are free after the jump. Time-based events in `processTimeEvents()` still fire for skipped times.
- **Errors:** every `catch` calls `dlog(...)` before handling. User-visible errors use friendly Vietnamese text (`toast`, `#boot-error`). The frame loop stops after 50 caught errors and asks the user to reload.

### 4.3 Dependencies

| Dependency | Use | Source |
|---|---|---|
| Three.js 0.160.0 | 3D rendering, math | CDN (import map) in `index.html`; inlined in `index-offline.html` |
| Web Audio API | Sound effects | Browser |
| `localStorage` | Save data | Browser |
| System font stack | UI text | Browser (no web fonts) |

No other libraries, frameworks, or assets are used.

### 4.4 Character rendering

- Characters are built by `buildCharacter(look, isPlayer)` in `index.html` from Three.js primitives (boxes, spheres, cylinders, circles) and a canvas texture. No photos, GLB/glTF models, or sprite images are embedded.
- Each NPC's `look` field in `NPC_PROFILES` drives skin/hair/shirt colours (hex), and these options:

| Field | Values | Effect |
|---|---|---|
| `style` | `short`, `long`, `bob`, `bun`, `fringe` | Hair shape (`fringe` = side fringe) |
| `glasses` | `false`, `true` (round), `'rect'` (thin rectangular) | Glasses type |
| `glassColor` | hex colour | Frame colour for `'rect'` (default `0x1c1c1c`) and round glasses (default `0x2b2220`) |
| `glassThick` | `true` | Round glasses only: lenses scaled to 1.15 wide, 2.2 deep (thick rims) |
| `mustache` | `true` | Small mustache in hair colour |
| `pattern` | `'gingham'` (black-and-white caro), `'stripe'` (horizontal grey-teal), `'plaid'` (red-and-blue, v1.4.1) | Shirt pattern, overrides `shirt`. Drawn by `patternMat(kind)`, one cached canvas texture per kind; unknown values fall back to gingham (v1.1.1 named the gingham case `ginghamMat()`) |
| `round`, `smile` | `true` | Round face, wide smile |

- Per-coworker looks (v1.1.1 to v1.9.5) are listed in `docs/spec/dong-nghiep.md` §1 (roster) and §8 (detailed looks). They are built from primitives only. Nguyên's look was built from a user-supplied photo, which is not embedded. No plant pot is placed at desk 3 in the code.

## 5. Data model

Stored under key `mot-ngay-o-cong-ty.v1` as JSON:

| Field | Type | Description |
|---|---|---|
| `name` | string | Player name, max 16 chars. Default empty (`''`), no fallback name. Coworkers say "bạn" when empty |
| `gender` | string | `nam`, `nu`, or `khac` (default). Chosen on the title screen. Drives anh / chị in NPC lines |
| `avatar` | number | Index into `AVATARS` (0–3) |
| `days` | number | Completed day count. Day N+1 is the next day (weekday and week are derived from it) |
| `diary` | array | Up to 150 entries (v1.1.0; was 40), newest first. Each: `day`, `date`, `tasks`, `energy`, `moodFace`, `moodLabel`, `talked[]`, `moments[]` (max 8), `noteLeft` (`{to, text}` or null), `comment`. Since v1.1.0 also `label` (e.g. "Tuần 2 · Thứ Ba"), `theme`, `badges[]`, and `world` (the users and version line) |
| `affinity` | object | Map of coworker id to 0–100 |
| `settings` | object | `sound` (bool), `tutorial` (bool), `cam` (number 0–2, camera preset index, default 1 = Vừa) |
| `world` | object | v1.1.0. `{ users }`: App Dating user count in thousands, default 12 |
| `recentEv` | array | v1.1.0. Ids of the last 8 surprises that fired (used to avoid repeats) |
| `lastTheme` | string | v1.1.0. Id of the previous day's theme (default empty) |
| `session` | object or null | v1.10.0. Snapshot of the day in progress: `v: 1`, `day`, and the day state. Written every 5 s of play and when the tab hides. Cleared at day end, on exit to title, and on start-over. Fields in `docs/spec/the-gioi-lien-tuc.md` §11 |

Reset ("Xóa dữ liệu") removes the key and clears in-memory affinity.

On load, the diary is filtered to well-formed entries and `affinity` is reset to `{}` if it is not an object. A missing or malformed `world` resets to `{ users: 12 }`. A missing `recentEv` resets to `[]`. Unreadable data falls back to defaults and logs via `dlog`. Missing `settings.cam` falls back to 1. Loading a v1.0.3 save under v1.1.0 was not separately recorded (see `docs/tasks.md`). v1.9.0 adds `tasksTotal` (number, desk tasks finished across all days) and `unlocked` (array of desk item ids); missing values read as `0` and `[]`, no migration (`docs/spec/bang-nhiem-vu.md` §9).

## 6. Content rules

- 14 coworker profiles in `NPC_PROFILES`, all computer-controlled. Roster, names, and address conventions: `docs/spec/dong-nghiep.md`. Field definitions are in the section 2 header comment of `index.html`.
- Profile fields: `name` (in-game name), optional `nick` (nickname shown in the conversation card), optional `real` (real name, shown when different from `name`), `role` (job title, shown on the card and in the invite list), `desk`, `traits` (maintainer note only, not shown in the game), optional `visitAnim` (animation for the visitor's opening stage).
- Desks 0–13 are fixed seat indexes; `desk` values must stay unique. Desks 0–3 are the left long table, 4–8 the right long table, and 9–13 the lower row of own desks (`docs/spec/van-phong-layout.md` §3).
- All 14 coworkers have a desk (0–13), all used (desk 13 added in v1.11.0; Nguyên at desk 8, `docs/spec/dong-nghiep.md` §3). The player's own desk is a separate yellow spot at the bottom left, left of Thông's desk (`Làm việc` spot, `Bàn của bạn`). This position is an assumption (layout spec §6).
- Editing a profile is data-only; text, look, desk, or habit tweaks need no other code changes.
- Note presets and quest documents live in `noteText()`, `DOC_QUESTS`, and `DOC_NAMES`. Document names include "Báo cáo khảo sát người dùng" (Chị Ba's quest, v1.6.1) and "Hợp đồng đối tác game".
- Meeting topics (`MEETING_TOPICS`, 3 entries): one asks whether to accept a partner's request to push the App Dating feature deadline by 2 days.
- Sort-game projects (`SORT_SETS`): set 1 is App Dating, Game mới, App tiện ích; set 2 is Quảng bá app Dating, Nghiên cứu người dùng, Đào tạo người mới. Each set has `from` (requester `'bao'` = Anh Bảo or `'an3'` = Chị Ba, v1.8.6) and `descs` (one line per group). `ORDER_SETS` also has `from`.
- Branding: `<title>` and the title panel `h1` read "Một Ngày Ở MinhLee". The north-wall logo (section 5, `logo`) reads "💘 MinhLee" with "Apps & Games". The front-door mat (`matMesh`) reads "MinhLee".
- Variety pools (v1.1.0): `SURPRISES` (19 entries), `DUOS` (15 pairs), `DAY_THEMES` (5), `WEEKENDS` (8), `GOSSIP_*`, `FRIEND_GREET`. Ids, weights, and effects are in `docs/spec/noi-dung-bat-ngo.md`.

## 7. Out of scope

- Multiplayer, accounts, cloud save, analytics.
- Win/lose conditions or scoring.
- Localization beyond Vietnamese.
- Build tooling, minification, service worker.

## 8. Related docs

- Player guide: `docs/product-guide.md`
- Open work: `docs/tasks.md`
- Release notes: `docs/changelog.md`
- Terms: `docs/glossary.md`
- Goal card and pause-menu mission board: `docs/spec/bang-nhiem-vu.md`
- Endless calendar, weekend, world state, birthdays, notice board: `docs/spec/the-gioi-lien-tuc.md` (AC-27 to AC-36)
- Surprises, duos, day themes, treats, badges: `docs/spec/noi-dung-bat-ngo.md` (AC-37 to AC-45)
- Coworkers, address terms, remote worker Nguyên, daybed: `docs/spec/dong-nghiep.md` (AC-46 to AC-51)
- Office layout, seats, spots, door, meeting room (v1.3.0): `docs/spec/van-phong-layout.md` (AC-52 to AC-60)
