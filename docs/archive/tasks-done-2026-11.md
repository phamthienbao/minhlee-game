# Archived tasks: completed items (v1.0.0 to v1.5.0)

Moved from `docs/tasks.md` on 2026-11-04 to keep that file under 300 lines. Entries are not edited. Current work: `docs/tasks.md`.

## Done

- [x] Single-file game `index.html`: "Một Ngày Ở Công Ty" v1.0.0 (2026-11-04)
  - [x] 3D low-poly office, fictional coworkers with schedules and behavior
  - [x] Day simulation 08:30–17:30 with 7 milestones
  - [x] Activities: morning task, meeting, pantry break/lunch, document favor, printer/cake event, wrap-up note
  - [x] Diary, affinity, data reset, localStorage save
  - [x] Web Audio sound effects (no audio files)
  - [x] No-WebGL list-mode fallback
  - [x] Headless Chrome verification via a throwaway harness (not in repo): full simulated day, no JS errors, no collision violations, activities complete, localStorage write works, no-WebGL list mode works
- [x] `docs/` folder created: spec, product guide, changelog, glossary, tasks (2026-11-04)
- [x] Project root `CLAUDE.md` created (2026-11-04)
- [x] v1.0.1 (2026-11-04): roster and player-setup changes, review fixes
  - [x] Player is a new employee who types an optional name (max 16, no default) and picks a gender on the title screen: Nam / Nữ / Không nêu (`#in-name`, `#gens`, `Store` fields `name` and `gender`, default `khac`)
  - [x] Empty name: NPC lines address the player as "bạn"
  - [x] NPC lines use `{ten}`, `{anh}`, `{Anh}`, filled by `fill()`
  - [x] Roster of 12 NPCs in `NPC_PROFILES`, desks 0–11 all used. Bảo is a Product NPC at desk 11, not the player
  - [x] Title subtitle says 12 coworkers (`index.html` line 155)
  - [x] Desk task options name Nam and Chị Ba (`index.html` lines 485–486)
  - [x] Section 11 comment says 12 coworker desks (`index.html` line 592)
  - [x] Old names removed from the roster (Chị Lan, Anh Hùng, Mai, Chị Hạnh, Tuấn, Thảo-QA, Anh Quân, Linh, Anh Đức, Chị Phương, Sơn, Vy)
  - [x] New optional profile fields `nick` and `real` (shown on conversation cards)
  - [x] Title-screen diary no longer stops the game loop
  - [x] Real pause state (`G.mode = 'paused'`), simulation and clock stop while paused
  - [x] Visits no longer stop after two
  - [x] Pantry and other spots released on time skip
  - [x] Corrupted save data validated on load (diary entries filtered, affinity reset if malformed)
  - [x] `CLAUDE.md`, `docs/spec`, `docs/product-guide.md`, `docs/glossary.md`, `docs/changelog.md` updated to match
- [x] Headless Chrome re-run after the v1.0.1 changes (2026-11-04): no JS errors, no collision violations, full day completes with 12 NPCs, no raw `{ten}`/`{anh}` in rendered bubbles or cards
- [x] v1.0.2 (2026-11-04): 13-NPC roster, personality pass, camera presets, treat events
  - [x] Thông added to `NPC_PROFILES` (nick "Bamboo", R&D, desk 12, lower row center). Desks 0–12, all used
  - [x] Title subtitle says 13 coworkers
  - [x] Personality rewrites (friendly and joking tone, no negative framing): Yến, Chị Ba, Thạnh, Phú, Trung, Nam, Toàn
  - [x] Thạnh: kind and helpful, arrives 09:20, two treat events (11:05 drinks, 14:10 snacks): +8 energy, +3 mood, +2 affinity, diary moment, toast, chime
  - [x] Chị Ba: playful "punch" animation (`poseCharacter` case `punch`), used by a 09:12 quirk and as her visit opener (`visitAnim`)
  - [x] Camera presets Gần / Vừa / Xa (nhìn từ trên) (`CAM_PRESETS`), cycled by the 🎥 HUD button (`#b-cam`), saved in `settings.cam` (default 1 = Vừa), toast on change
  - [x] Camera looks 1.3 m ahead of the player; narrower FOV (portrait 58, mid 50, landscape 44); pitch drag range 0.6–1.4. Reason: a low angle let desks hide people, and the portrait FOV was too wide
  - [x] `{{anh}}` placeholder defect fixed (Nam's first greeting now uses `{anh}`)
  - [x] Headless Chrome re-run with 13 NPCs (2026-11-04): no JS errors, no collision violations, full day completes, no raw placeholders in rendered text
  - [x] `CLAUDE.md`, `docs/spec`, `docs/product-guide.md`, `docs/glossary.md`, `docs/changelog.md`, `docs/tasks.md` updated to match
- [x] v1.0.3 (2026-11-04): MinhLee rename and content pass
  - [x] Title is "Một Ngày Ở MinhLee" (`<title>` and the title-panel `h1`). Company is MinhLee, a fictional app and game company; flagship product is the App Dating. Subtitle updated
  - [x] North-wall logo sign reads "💘 MinhLee" with "Apps & Games" (`buildOffice()`, section 5). Front-door mat reads "MinhLee" (`matMesh`)
  - [x] Sort-game project names: set 1 App Dating / Game mới / App tiện ích; set 2 Quảng bá app Dating / Sổ sách tháng / Đào tạo người mới (`SORT_SETS`)
  - [x] Meeting topic about the App Dating feature deadline (`MEETING_TOPICS`)
  - [x] Document "Hợp đồng đối tác game" (`DOC_QUESTS`, `DOC_NAMES`)
  - [x] Trung: "Em nói thiệt" catchphrase (trait, lines)
  - [x] Thạnh: karma and meditation lines; 13:20 meditation quirk added. Treat events and 09:20 arrival unchanged
  - [x] Thông: real estate, land, and investing lines; still worries ahead
  - [x] Bảo: request about the Dating-app matching suggestion feature vs the login bug
  - [x] Save key `mot-ngay-o-cong-ty.v1` kept, so existing saves still load
  - [x] Section 2 header comment fixed in source: desk `0..12`, `visitAnim` listed (closes the v1.0.2 source-comment item)
  - [x] Headless Chrome re-run after the changes (2026-11-04): no JS errors, no collision violations, full day completes. One transient NPC overlap sample in thousands of checks
  - [x] `CLAUDE.md`, `docs/spec`, `docs/product-guide.md`, `docs/glossary.md`, `docs/changelog.md`, `docs/tasks.md` updated to match
- [x] v1.1.0 (2026-11-04): endless world, persistent world state, variety content
  - [x] Endless play, no ending. Mon–Fri calendar (`calInfo()`, `WEEKDAYS`): "Tuần N · Thứ Hai..Thứ Sáu". Title button "▶ Tiếp tục: <weekday>, tuần N". Summary button "☀ Sang ngày tiếp theo" (Friday: "🌙 Qua cuối tuần")
  - [x] Weekend vignette after Friday (`weekendFlow()`, 8 `WEEKENDS` entries) gives a mood and energy bonus for Monday
  - [x] Persistent world state (`Store.world.users`, `appVersion()`): app Dating user count grows each day; app version rises each week. Shown in the summary and on the notice board
  - [x] Monday 10:00 meeting asks about the upcoming app version (`mondayTopic()`)
  - [x] Relationships persist across days (`Store.affinity`). `Store.recentEv` and `Store.lastTheme` avoid repeats (Friday exception in Known defects)
  - [x] NPC birthdays recur on a 65-day cycle and force a cake party that day
  - [x] Friends (affinity ≥ 75) greet with `FRIEND_GREET`
  - [x] 15 random surprises (`SURPRISES`), 3–4 a day, 3 options each, including the mystery gift box (`gift`, 3 boxes)
  - [x] 9 duo chats (`DUOS`) when coworkers visit each other
  - [x] 5 day themes (`DAY_THEMES`): normal, rain (grey light and rain sound), busy, chill, milk-tea. Emoji shown after the clock
  - [x] End-of-day badges (`makeBadges()`, max 4), shown on the summary and in the diary
  - [x] Procedural "Tin đồn văn phòng" on the notice board (`GOSSIP_*`)
  - [x] Thạnh's extra treats at 09:55 and 16:00 on milk-tea days (in addition to 11:05 and 14:10)
  - [x] Diary cap 40 → 150 (`Store.patch` slice in `showSummary()`)
  - [x] Save key `mot-ngay-o-cong-ty.v1` unchanged. New fields (`world`, `recentEv`, `lastTheme`) default when missing
  - [x] Acceptance criteria AC-27 to AC-45 written, in `docs/spec/the-gioi-lien-tuc.md` and `docs/spec/noi-dung-bat-ngo.md`, with a status for each
  - [x] Headless Chrome 12-day simulated run (2026-11-04, throwaway harness, not in repo): correct weekday and weekend progression, user count grows, themes vary, no JS errors, no collision violations except transient NPC overlap samples in the long run (see Known defects). All 15 surprises and every option and gift box exercised, no raw placeholders
  - [x] Docs: `CLAUDE.md`, `docs/spec/mot-ngay-o-cong-ty.md`, `docs/spec/the-gioi-lien-tuc.md` (new), `docs/spec/noi-dung-bat-ngo.md` (new), `docs/product-guide.md`, `docs/glossary.md`, `docs/changelog.md`, `docs/tasks.md`

- [x] v1.1.2 (2026-11-04): three more custom NPC looks, primitives only
  - [x] Trung (`trung`): short black hair, thin rect glasses (`glassColor`), small mustache (`mustache`), grey-teal stripe polo (`pattern: 'stripe'`)
  - [x] Tùng (`tung`): black hair with side fringe (`style: 'fringe'`), white-lavender shirt, wide smile
  - [x] Chú 7 (`an7`): short dark hair, no glasses (was grey hair with glasses), white shirt, neutral expression
  - [x] `patternMat(kind)` generalizes the gingham code (kinds `gingham`, `stripe`)
  - [x] Verified only by headless-Chrome screenshots of the new looks (2026-11-04). Not on devices
  - [x] Docs: `docs/changelog.md`, `docs/spec/mot-ngay-o-cong-ty.md` section 4.4, `docs/glossary.md`, `docs/tasks.md`, `CLAUDE.md` status

- [x] v1.2.0 (2026-11-04): 14th coworker Nguyên (remote), address conventions, in-game names, pantry daybed
  - [x] Nguyên (`nguyen`) added to `NPC_PROFILES` (14 entries). Role "Designer" (confirmed 2026-11-04; was "Developer (làm từ xa)", tentative), `desk: null`
  - [x] Remote attendance: `habits.attendance` 0.5 (raised from 0.3 on 2026-11-04), rolled in `resetNpcDay()`. Arrives 10:15 and leaves 17:00 on office days
  - [x] Pantry daybed: `LOUNGE_SEAT`, `goalLounge()`, pose `lie`, obstacle at (−7.0, −4.2). Nguyên lies there on office days
  - [x] Arrival toast (arrival + 8 min) and 11:20 quirk
  - [x] Title subtitle says 14 coworkers (`index.html` line 156)
  - [x] In-game names: Chủ tịt (real Thạnh) and Anh Bảo (real Bảo) in surprises, duos, gossip, and meeting host text
  - [x] Address conventions applied across the roster (`docs/spec/dong-nghiep.md` §2). Hiện's lines rewritten: "em" for self, anh / chị for others
  - [x] Duos: Thảo–Yến and Hiện–Anh Bảo added (11 pairs in `DUOS`)
  - [x] Gossip pool `GOSSIP_A` has 14 names (adds Nguyên)
  - [x] `PANTRY_SPOTS` keeps 8 standing spots, two relocated
  - [x] Headless Chrome, 2 runs with 14 NPCs (2026-11-04, throwaway harness): no JS errors, no collision violations. Screenshot shows Nguyên lying on the daybed
  - [x] Docs: `CLAUDE.md`, `docs/spec/dong-nghiep.md` (new, roster moved here from the main spec), `docs/spec/mot-ngay-o-cong-ty.md`, `docs/spec/noi-dung-bat-ngo.md`, `docs/spec/the-gioi-lien-tuc.md`, `docs/product-guide.md`, `docs/glossary.md`, `docs/changelog.md`, `docs/tasks.md`

- [x] v1.2.0 confirmation pass (2026-11-04): changes made after the release notes above were drafted
  - [x] Nguyên's role is `Designer`. No gender is recorded (none was stated); the "assumed male" note is removed from the docs
  - [x] Nguyên's `habits.attendance` raised from 0.3 to 0.5 (in the office on about half of the days)
  - [x] Nam rewritten peer-level (same age as Chủ tịt, mình / bạn, no "em" or "ạ"); keeps "khìn khìn". Chị Ba–Nam duo rewritten as same-age banter (tui / ông)
  - [x] Traits removed from the UI. `traits` is a maintainer note. The invite list hint shows the job title
  - [x] Address conventions and spelling confirmed (see Open questions, closed items)
  - [x] Headless Chrome re-run after these changes (2026-11-04): no JS errors, no collision violations. Not tested on devices, touch, or audio
  - [x] Docs synced: `CLAUDE.md`, `docs/spec/dong-nghiep.md`, `docs/spec/mot-ngay-o-cong-ty.md`, `docs/spec/noi-dung-bat-ngo.md`, `docs/product-guide.md`, `docs/glossary.md`, `docs/changelog.md`, `docs/tasks.md`

- [x] v1.3.0 (2026-11-04): office rebuilt to the user's floor plan, pacing tuned, birthday fix
  - [x] Layout constants in `index.html` section 5 (`planX`/`planZ`, `DOOR`, `LONG_TABLES`, `DESKS`, `PLAYER_DESK`, `COLUMNS`, `MEET_ROOM`, `MEET_SEATS`, `PANTRY_SPOTS`, `SOFA_SEATS`, `LOUNGE_SEAT`, `PRINTER_SPOT`). `buildOffice()` and `buildSpots()` updated
  - [x] Two long tables (4 seats left, 5 right, facing each other), lower row of 4 own desks, two columns, walkway, pantry at the top left
  - [x] Front door on the east wall, aligned with the walkway. NPCs spawn and leave there. The player starts beside it
  - [x] Meeting room added at the top centre (not in the plan)
  - [x] Daybed, sofa, printer, and notice board moved. Filing cabinet stays at the south east
  - [x] `NPC_PROFILES` desk indexes remapped to the plan (0 Phú to 12 Yến; Nguyên has none)
  - [x] `CFG.NPC_SPEED` 1.55 → 1.9. Lunch 45 → 55 minutes. Coffee windows 13 → 16 minutes
  - [x] Birthday offset `(index × 4 + 3) % 65`. Birthday and random cake picks skip remote coworkers. Fixes Nguyên's birthday and the remote cake pick
  - [x] Spec `docs/spec/van-phong-layout.md` (new, AC-52 to AC-60). Updated `docs/spec/mot-ngay-o-cong-ty.md`, `docs/spec/dong-nghiep.md`, `docs/spec/the-gioi-lien-tuc.md`, `docs/product-guide.md`, `docs/glossary.md`, `docs/changelog.md`, `CLAUDE.md`
  - [x] Headless Chrome harness (2026-11-04, throwaway, not in repo): no JS errors, no collision violations (one transient overlap sample), full day completes, NPCs reach the pantry (75-second lunch simulation), screenshots show tables, columns, door, meeting room
  - [x] Layout fidelity to the SVG checked by eye only (see Follow-ups)

- [x] v1.3.1 (2026-11-04): custom looks for Yến, Chị Ba, and Thảo, primitives only
  - [x] Yến (`yen`): long auburn-brown hair, thin round gold-rimmed glasses (`glassColor`), black top (was pink), smile. No glasses before
  - [x] Chị Ba (`an3`): shoulder-length brown bob, thick dark round glasses (`glassThick`), round face, black top (was purple)
  - [x] Thảo (`thao`): shoulder-length black bob, cream knit top, smile, no glasses (was bun and orange top)
  - [x] `buildCharacter()` supports `look.glassColor` on round glasses and `look.glassThick` (round glasses only)
  - [x] Verified only by headless-Chrome screenshots (faces visible behind the monitors). Not on devices
  - [x] Docs: `docs/changelog.md`, `docs/spec/mot-ngay-o-cong-ty.md` section 4.4, `docs/glossary.md`, `docs/tasks.md`

- [x] v1.4.0 (2026-11-04): personality update (Thảo, Tùng, Chú 7), 3 new surprises, 3 new duos
  - [x] Thảo (`thao`): the office foodie. Greetings, chats, pantry lines, and the request (lunch choice) are about food. Quirk 11:40 recommends lunch
  - [x] Tùng (`tung`): invites people to a light after-work drink (nhậu). Request is the "MinhLee" ten-times dare. Quirk 16:50 ("Ai đi nhậu giơ tay!")
  - [x] Chú 7 (`an7`): young ("Chú" is a nickname). Loves tea (ô long, trà sen) and teases Chị Ba. Old "worries ahead / backups" persona removed from profile lines (duo `an7`–`thong` still has it, see Open questions)
  - [x] Surprises `thaoquan`, `tungthach`, `khiatra` added. `SURPRISES` now 18 entries (17 events plus the gift box)
  - [x] Duos Chú 7–Chị Ba, Tùng–Phú, Thảo–Tùng added. `DUOS` now 14 pairs
  - [x] Headless Chrome (2026-11-04, throwaway harness): all 18 surprises x 3 options exercised, all duo and surprise ids valid, no raw placeholders, no JS errors, no collision violations (one transient overlap sample)
  - [x] Docs: `CLAUDE.md`, `docs/changelog.md`, `docs/spec/noi-dung-bat-ngo.md`, `docs/spec/dong-nghiep.md`, `docs/spec/mot-ngay-o-cong-ty.md` (counts), `docs/product-guide.md`, `docs/glossary.md`, `docs/tasks.md`

- [x] v1.4.1 (2026-11-04): custom looks for Phú, Nam, and Anh Bảo, primitives only
  - [x] Phú (`phu`): short black hair, thin rect glasses (`glassColor: 0x2a2a2e`), black shirt, smile. Was orange shirt, no glasses
  - [x] Nam (`nam`): black fringe (`style: 'fringe'`), red-and-blue plaid (`pattern: 'plaid'`), neutral expression. Was light-blue shirt
  - [x] Anh Bảo (`bao`): short neat black hair, thin dark rect glasses (`glassColor: 0x30343a`), mustard shirt, smile. Built from a written brief only (no photo), so the face is an approximation
  - [x] `patternMat(kind)` gains `plaid` (kinds now `gingham`, `stripe`, `plaid`). Unknown kinds fall back to gingham
  - [x] Chú 7: the user re-sent the photo already used for the v1.1.2 look. No change
  - [x] Verified only by headless-Chrome screenshots of isolated close-ups (2026-11-04). Not on devices
  - [x] Docs: `docs/changelog.md`, `docs/spec/mot-ngay-o-cong-ty.md` section 4.4, `docs/glossary.md`, `docs/tasks.md`

- [x] v1.4.2 (2026-11-04): Chủ tịt (Thạnh) loves cats. Content and one prop, no layout or save change
  - [x] Cat lines for Chủ tịt (`NPC_PROFILES`, `thanh`): his cat Nhân Quả in one greeting, one idle, one chat, and one pantry line. Trait `rất thích mèo`
  - [x] Quirk 12:50 (`anim: null`): looks at cat photos on his phone
  - [x] Cat plush on Chủ tịt's desk (`buildOffice()` section 5, `seatItems()`, seat index 1)
  - [x] Surprise `cat` (stray cat) now has `npc: 'thanh'` and Chủ tịt's reactions in its text and options
  - [x] New surprise `thanhmeo` ("Ảnh mèo của Chủ tịt", 3 options). `SURPRISES` now has 19 entries (18 events plus gift)
  - [x] New duo `thanh`–`hien` (Chủ tịt–Hiện, 3 lines). `DUOS` now has 15 pairs
  - [x] Gossip pool `GOSSIP_THING` gains "tấm ảnh mèo của Chủ tịt" (13 entries). Combinations 10,192 (was 9,408)
  - [x] Headless Chrome (2026-11-04, throwaway harness, not in repo): all 19 surprises x 3 options exercised, no raw placeholders, no JS errors, no collision violations
  - [x] Docs: `CLAUDE.md`, `docs/changelog.md`, `docs/spec/dong-nghiep.md`, `docs/spec/noi-dung-bat-ngo.md`, `docs/spec/mot-ngay-o-cong-ty.md`, `docs/spec/the-gioi-lien-tuc.md`, `docs/product-guide.md`, `docs/glossary.md`, `docs/tasks.md`

- [x] v1.4.3 (2026-11-04): Chủ tịt (Thạnh) speaks humbly; Chú 7–Thông duo rewritten. Content only, no layout or save change
  - [x] Humble style for Chủ tịt: "em" for himself, "anh" / "chị" for most people, including the player (`{anh}`) and in group talk. Applied to `NPC_PROFILES` `thanh` (greet, idle, chat, pantry, request, reply, meeting, quirks, note), the treat bubble in `processTimeEvents()` ("Em mua cho cả nhà nè"), the `DOC_QUESTS` ask, and surprise texts and options with Chủ tịt lines
  - [x] Exceptions: younger coworkers and Chị Ba keep normal "anh" / "em". Duo `thanh`–`hien` keeps "anh". Younger group is an assumption (see Open questions)
  - [x] Duo `thao`–`thanh` reply: "Nhân quả mà chị… lần sau em sẽ cố"
  - [x] Duo `an7`–`thong` rewritten to the tea persona (backup and worry lines removed). Closes the v1.4.0 open item
  - [x] Doc correction: duo table listed Chú 7–Thông as 3 lines; the source has 4
  - [x] Headless Chrome re-run (2026-11-04, throwaway harness, not in repo): all 19 surprises x 3 options, 15 duos, one full day. No JS errors, no collision violations. Not on devices or audio
  - [x] Source check (2026-11-04, read-only grep): one leftover "Anh mời trà sữa!" (see Known defects)
  - [x] Docs: `CLAUDE.md`, `docs/changelog.md`, `docs/spec/dong-nghiep.md`, `docs/spec/noi-dung-bat-ngo.md`, `docs/product-guide.md`, `docs/glossary.md`, `docs/tasks.md`

- [x] v1.5.0 (2026-11-04): self-contained offline build
  - [x] `index-offline.html` (~1.1 MB): `index.html` with Three.js 0.160.0 inlined in the importmap as a base64 `data:` URL. No network needed. Generated by `tools/build-offline.py` (caches `tools/three.module.min.js` on first run). `index.html` unchanged (still CDN)
  - [x] Three.js MIT license header kept at the top of the inlined library; importmap comment names version and license
  - [x] Headless Chrome, all network blocked (`--host-resolver-rules="MAP * ~NOTFOUND"`), throwaway harness (not in repo): `index-offline.html` completes a full simulated day, no JS errors, no collision violations except a couple of transient NPC-overlap samples. `index.html` correctly fails to start in the same test
  - [x] Read-only diff (2026-11-04): `index-offline.html` matches `index.html` except the importmap line and one added comment line
  - [x] Docs: `CLAUDE.md`, `docs/deploy.md` (new), `docs/spec/phan-phoi-offline.md` (new), `docs/spec/mot-ngay-o-cong-ty.md`, `docs/product-guide.md`, `docs/glossary.md`, `docs/changelog.md`, `docs/tasks.md`

- [x] v1.4.4 (2026-11-04): speech bubbles and coworker lines follow the activity. Content and UI logic only, no layout or save change
  - [x] Bubbles anchored above the speaker's head; hidden when off-screen or under the HUD, not pinned to the edge (`Bubbles.update()`, `Bubbles.onScreen`). Ambient bubbles gated by `onScreen` in `tryNpcSay()`
  - [x] Quirk `ctx` (`desk` default, `eat`, `lounge`, `any`), `lineFor()` (pantry, "Đang họp", greet or idle), talk-card intro uses it
  - [x] Time-of-day tags `@am` / `@noon` / `@pm` in `pickSay()`; tagged greetings for Chủ tịt, Trung, Nam, Thảo, Yến, Chị Ba. Chú 7 quirk 09:50 → 09:46. Treat bubble matches Chủ tịt's goal
  - [x] Headless Chrome checks reported (2026-11-04, throwaway harness): tags, `ctx`, `onScreen`, full day, no JS errors, no collision violations. Not on a real phone
  - [x] Docs: `docs/spec/dong-nghiep.md` §7 (new), `docs/spec/mot-ngay-o-cong-ty.md`, `docs/deploy.md` (options 1 and 2 added), `docs/product-guide.md`, `docs/glossary.md`, `docs/changelog.md`, `CLAUDE.md`, `docs/tasks.md`

## Done (v1.6.0 and v1.6.1, moved from tasks.md in v1.8.6)

- [x] v1.6.1 (2026-11-04): Chị Ba (`an3`, Business Support) reworked as a product-research role. Details: `docs/changelog.md` v1.6.1
  - [x] Lines, quirks (09:12, 09:48), desk request (survey report, 40 respondents, honest small-sample options), note, and meeting lines rewritten (`index.html` section 2, `NPC_PROFILES`)
  - [x] Afternoon document quest asks for "Báo cáo khảo sát người dùng" (`DOC_QUESTS`, `DOC_NAMES`)
  - [x] Sort-game set 2: project "🔎 Nghiên cứu người dùng" and notes "Tổng hợp kết quả khảo sát", "Vẽ biểu đồ phản hồi người dùng" (`SORT_SETS`). Ordering item "Gửi số liệu khảo sát cho Chị Ba" (`ORDER_SETS`)
  - [x] Chị Ba–Nam duo rewritten: she asks Nam for the survey data he forgot (`DUOS`)
  - [x] Accounts / paperwork content removed from the game text and from current docs
  - [x] `index-offline.html`, `dist/MinhLee.app`, `dist/MinhLee-mac.zip` rebuilt
  - [x] Headless-Chrome harness re-run: 19 surprises × 3 options, document quest flow, one full day. No JS errors, no collision violations
  - [x] Docs: `CLAUDE.md`, `docs/spec/dong-nghiep.md`, `docs/spec/noi-dung-bat-ngo.md`, `docs/spec/mot-ngay-o-cong-ty.md`, `docs/spec/phan-phoi-offline.md`, `docs/product-guide.md`, `docs/glossary.md`, `docs/changelog.md`, `docs/tasks.md`

- [x] v1.6.0 (2026-11-04): macOS app wrapper (`tools/macapp/`, `tools/build-mac-app.sh`). Details: `docs/spec/phan-phoi-offline.md` §8
  - [x] Cocoa window with WKWebView loads the bundled offline file from `Contents/Resources/index.html` (`tools/macapp/main.swift`, `loadFileURL`)
  - [x] Menus: app (Ẩn, Thoát), Chỉnh sửa (Cắt, Sao chép, Dán, Chọn tất cả), Hiển thị (Toàn màn hình, Tải lại game). Closing the window quits the app
  - [x] Friendly Vietnamese alert on load failure (`showFatal()`). Debug logs only in `#if DEBUG` or `--selftest`
  - [x] `--selftest` flag: prints `PHASE1` and `PHASE2` JSON, then exits
  - [x] `tools/macapp/Info.plist` (bundle id `com.minhlee.mot-ngay-o-cong-ty`, minimum macOS 11.0), `tools/macapp/AppIcon.icns`
  - [x] `tools/build-mac-app.sh`: runs `build-offline.py`, compiles arm64 and x86_64, `lipo` to a universal binary, ad-hoc `codesign`, writes `dist/MinhLee.app` and `dist/MinhLee-mac.zip` (about 1.5 MB)
  - [x] Self-test on this Mac (macOS 27, Apple Silicon, 2026-11-04): game loaded in WKWebView, `__gameReady` true, WebGL available, localStorage works and persisted across two launches, "Bắt đầu ngày mới" showed the HUD and the clock advanced (08:32)
  - [x] Universal binary checked with `lipo -info` (x86_64 arm64). Signature checked with `codesign --verify --deep --strict`. `dist/MinhLee.app/Contents/Resources/index.html` is byte-identical to `index-offline.html`
  - [x] Yến's greeting `say.greet[1]` ("Trời ơi cái mặt này! Mới sáng ra đã… là sao?") now tagged `@am`. A `@pm` greeting added as `say.greet[3]`. Closes the v1.4.4 known issue (afternoon leak). Text change in `index.html` (section 2, Yến)
  - [x] Docs: `CLAUDE.md`, `docs/deploy.md` (option 4), `docs/spec/phan-phoi-offline.md` (§8), `docs/spec/dong-nghiep.md`, `docs/spec/mot-ngay-o-cong-ty.md`, `docs/product-guide.md`, `docs/glossary.md`, `docs/changelog.md`, `docs/tasks.md`, `docs/archive/tasks-done-2026-11.md` (new)

## Done (v1.7.0 to v1.8.1, moved from tasks.md in v1.8.7)

- [x] v1.8.1 (2026-11-04): Nam's "bé Hạnh" teasing nickname for Chủ tịt (Thạnh): playful lines, a playful four-line duo, and the meaning recorded in the docs. Details: `docs/changelog.md` v1.8.1, `docs/spec/dong-nghiep.md` §1–2, `docs/spec/noi-dung-bat-ngo.md` §2
  - [x] `say.idle` and `say.chat` lines for Nam, a `say.chat` reply for Thạnh, and the playful `nam`–`thanh` duo in `DUOS` (`index.html`, section 2 and the variety block)
  - [x] "bé Hạnh" meaning recorded in `docs/glossary.md`, `docs/product-guide.md`, `docs/spec/dong-nghiep.md` (confirmed by the product owner, 2026-11-04)
  - [x] Headless-Chrome full-day run and content id checks, as reported by the requester; static check of `DUOS` and `say.absent` ids in the doc pass

- [x] v1.8.0 (2026-11-04): goal card larger and tappable, mission board in the pause menu (playtest feedback). Details: `docs/changelog.md` v1.8.0, `docs/spec/bang-nhiem-vu.md`
  - [x] Goal card (`updateHud()`, `.obj` CSS): 🎯 milestone + hint + "Chạm để xem cả bảng nhiệm vụ", 16px, stronger border; tap calls `pauseGame()` (`init()`, `#hud-obj`)
  - [x] Pause menu mission board (`missionBoard()`, `.qb` CSS) under "▶ Tiếp tục": current goal card, milestone rows with ✅ ▶️ ⏳ ⏭, side tasks from `extraTasks()`
  - [x] Headless Chrome unit check of the board at 08:30 and 14:50, and of tap-to-open (reported by requester; not re-run in the doc pass)
  - [x] Screenshots of the pause board and goal card at 500 px width (reported as readable)
  - [x] macOS app self-test passed on the rebuilt app (reported)
  - [x] `index-offline.html`, `dist/MinhLee.app`, `dist/netlify/index.html` rebuilt; the three are byte-identical (checked in the doc pass)
  - [x] Docs: `CLAUDE.md`, `docs/spec/bang-nhiem-vu.md` (new), `docs/spec/mot-ngay-o-cong-ty.md`, `docs/product-guide.md`, `docs/glossary.md`, `docs/changelog.md`, `docs/tasks.md`

- [x] v1.7.2 (2026-11-04): diary intro depends on context (no more "0 ngày làm việc" during day 1). Details: `docs/changelog.md` v1.7.2, `docs/spec/mot-ngay-o-cong-ty.md` §4.2 and AC-27
  - [x] `showDiary()` (`index.html` section 13): mid-day intro with the workday number and "written at the end of the day", day-1 line when there are no entries, days-worked or "none recorded" line on the title screen and after the day
  - [x] Headless Chrome unit check of mid-day day 1, mid-day day 2, and the title screen (reported by the requester; not re-run in the doc pass)
  - [x] `index-offline.html`, `dist/MinhLee.app`, `dist/netlify/index.html` rebuilt (app and netlify copies byte-identical to `index-offline.html`)
  - [x] Docs: `CLAUDE.md`, `docs/spec/mot-ngay-o-cong-ty.md`, `docs/product-guide.md`, `docs/changelog.md`, `docs/tasks.md`

- [x] v1.7.1 (2026-11-04): Chị Ba's stand-up catchphrase with Chú 7's reply, Nam's lines before Chủ tịt arrives, and generic speech hooks. Details: `docs/changelog.md` v1.7.1, `docs/spec/dong-nghiep.md` §7.5
  - [x] `say.stand` (3 variants) and `say.standReply` on `an3` (Chị Ba → Chú 7). Chance 55% (90% on `busy`), 60 s cooldown, only when on screen within 9.5 m (`standUpLine()`, `setGoal()`, `index.html` section 9)
  - [x] Chú 7 chat line about the "bánh tét" nickname (`say.chat`, `an7`)
  - [x] `say.absent` on `nam` (5 lines, `who: 'thanh'`), timer in `npcAmbient()` (section 9). Stops when Chủ tịt arrives
  - [x] Headless-Chrome checks (2026-11-04): Nam 2+ lines in the first 50 game minutes while Chủ tịt hidden; Chị Ba line fired 11 of 12 forced attempts on a `busy` day; full-day harness with no JS errors and no collision violations
  - [x] `index-offline.html`, `dist/MinhLee.app`, `dist/MinhLee-mac.zip`, `dist/netlify/index.html` rebuilt (`tools/build-offline.py`, `tools/build-mac-app.sh`, `tools/prepare-netlify.sh`)
  - [x] Docs: `CLAUDE.md`, `docs/spec/dong-nghiep.md` (roster rows 7, 10, 11; §2; AC-65, AC-66; §7.5), `docs/product-guide.md`, `docs/glossary.md`, `docs/changelog.md`, `docs/tasks.md`

- [x] v1.7.0 (2026-11-04): browser hardening for "no graphics" reports. Details: `docs/changelog.md` v1.7.0, `docs/spec/tuong-thich-trinh-duyet.md`
  - [x] Environment check before the module runs: too-old browser (`#env-note`, "Trình duyệt chưa hỗ trợ" button), in-app browser banner ("Mở bằng trình duyệt") (`index.html` `<head>` script)
  - [x] Renderer creation tries `antialias` on, then off; WebGL failure gives list mode and a title-screen reason (`init()`, `#env-note`)
  - [x] Title-screen toggle `#btn-lite` (3D ↔ list mode) using `settings.lite` and `?lite`
  - [x] Runtime fallbacks to list mode with a toast: render watchdog (150th counted frame, 0 draw calls) and context lost for more than 4 s (`frame()`, `webglcontextlost`, `fallbackToLite()`)
  - [x] Boot-error text lists three things to try (`#boot-error`)
  - [x] Headless Chrome: 3D full-day run, `?lite` run, mid-game `fallbackToLite()` run
  - [x] Real Safari 27.0.1 on macOS 27: 3D scene rendered (226 draw calls, 6128 triangles, no errors). Temporary on-page diagnostic only
  - [x] `index-offline.html`, `dist/MinhLee.app`, `dist/MinhLee-mac.zip` rebuilt. `--selftest` passed again
  - [x] Docs: `CLAUDE.md`, `docs/spec/tuong-thich-trinh-duyet.md` (new), `docs/spec/phan-phoi-offline.md`, `docs/spec/mot-ngay-o-cong-ty.md`, `docs/deploy.md`, `docs/product-guide.md`, `docs/glossary.md`, `docs/changelog.md`, `docs/tasks.md`
