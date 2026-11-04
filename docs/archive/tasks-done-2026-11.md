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

## Done (v1.8.7 and v1.8.8, moved from tasks.md in v1.9.2)

- [x] v1.8.8 (2026-11-04): the north-wall clock shows the in-game time. The face is redrawn by `drawWallClock()` from `applyTimeOfDay()` when the minute changes. Details: `docs/changelog.md` v1.8.8, `docs/spec/van-phong-layout.md` §2, §6 and AC-74
  - [x] `WALL_CLOCK` canvas texture redrawn with hour hand, minute hand, and 12 tick marks (`drawWallClock()`, `applyTimeOfDay()` in `index.html`)
  - [x] Headless-Chrome check: face exported at 08:30, 10:10, 14:20 (three different images; 14:20 hands correct)
  - [x] Offline copies and netlify and app resources contain the v1.8.8 code (grep check in the doc pass)
  - [ ] Look at the wall clock on a real device and in Safari or Firefox (not run)
  - [ ] Rebuild `dist/MinhLee-mac.zip` and `dist/MinhLee.app` (not rebuilt in the doc pass)
  - [ ] Set `CFBundleShortVersionString` in `tools/macapp/Info.plist` and `dist/MinhLee.app/Contents/Info.plist` (still 1.8.5)
  - [x] Docs: `docs/changelog.md`, `docs/spec/van-phong-layout.md`, `docs/tasks.md`, `docs/glossary.md`. `docs/product-guide.md` not changed (it mentions only the HUD clock). `CLAUDE.md` not touched (user choice)

- [x] v1.8.7 (2026-11-04): surprise events wait for the player to stand within 4.2 m of the related coworker after their scheduled time, and are skipped after 150 game-minutes or at 17:10. Three narration strings call Chủ tịt "anh" instead of "ông". Details: `docs/changelog.md` v1.8.7, `docs/spec/noi-dung-bat-ngo.md` §1 and AC-40, `docs/product-guide.md` (Surprises)
  - [x] `tickClock()` proximity gate and skip rule (`CFG.SURPRISE_NEAR`, `sp.t + 150`, `CFG.END - 20`), `near()` check for `ev.npc` or any visible coworker
  - [x] Headless-Chrome check: far from the coworker, not fired; near, fired (reported by the requester; not re-run in the doc pass)
  - [x] Offline copies and netlify and app resources contain the v1.8.7 code (grep check in the doc pass; byte-identity not checked)
  - [x] Docs: `CLAUDE.md` not touched (user choice), `docs/changelog.md`, `docs/spec/noi-dung-bat-ngo.md`, `docs/product-guide.md`, `docs/glossary.md`, `docs/tasks.md`

## Moved from docs/tasks.md (v1.8.2 to v1.8.6, moved 2026-11-04)

- [x] v1.8.6 (2026-11-04): desk task reworked around a requester (work card, progress kept on pause, mini-game help and hints, requester reaction), "💻 Bàn của bạn" desk label, photo-based looks for Thông, Thảo, Toàn. Details: `docs/changelog.md` v1.8.6, `docs/spec/mot-ngay-o-cong-ty.md` AC-71 to AC-73 and §4.4, `docs/spec/bang-nhiem-vu.md` §2, §3.4
  - [x] Work card (`workActivity()`): requester, briefing (`workBrief()`), "about 30–60 seconds", "no score, no penalty"; "▶ Bắt đầu làm" / "▶ Làm tiếp"; "Để lát nữa (không mất gì)"
  - [x] `D.work` kept on "Để lát nữa" and "⏸ Tạm dừng (giữ nguyên tiến độ)"; cleared on finish or at a new day (`newDayState()`)
  - [x] Mini-games: "Cách làm" box, progress bar, `SORT_SETS.descs`, hint glow after 2 wrong taps, `from` on `SORT_SETS` and `ORDER_SETS`
  - [x] Requester reaction card on completion (+3 affinity for the requester)
  - [x] Desk label `deskTag` (horizontal clamp, hidden after 3 tasks, while sitting, in list mode, or away); morning milestone hint updated
  - [x] Photo-based looks: Thông (white tee), Thảo (long hair, orange blouse), Toàn (navy shirt, mustache). This was the v1.8.6 item skipped earlier
  - [x] Offline copies (`index-offline.html`, `dist/netlify/index.html`, `dist/MinhLee.app`) contain the v1.8.6 strings and are byte-identical (checked in the doc pass)
  - [x] Docs: `CLAUDE.md`, `docs/changelog.md`, `docs/spec/mot-ngay-o-cong-ty.md`, `docs/spec/bang-nhiem-vu.md`, `docs/product-guide.md`, `docs/glossary.md`, `docs/tasks.md`, `docs/archive/tasks-done-2026-11.md` (v1.6.0 and v1.6.1 moved here)

- [x] v1.8.5 (2026-11-04): Nguyên's look changed to a stylized look based on a user photo (black side-fringe hair, fair skin, black top, no glasses, relaxed expression). Details: `docs/changelog.md` v1.8.5, `docs/spec/mot-ngay-o-cong-ty.md` §4.4
  - [x] `NPC_PROFILES` `nguyen` `look` in `index.html`: `hair: 0x15110f`, `style: 'fringe'`, `skin: 0xf3d3bb`, `shirt: 0x1b1b1d`, `glasses: false`, no `smile`
  - [x] Built from Three.js primitives only; no photo, model, or Blender asset embedded
  - [x] Headless-Chrome screenshot of Nguyên lying on the daybed (reported by requester; not re-taken in the doc pass)
  - [x] `index-offline.html`, `dist/netlify/index.html`, `dist/MinhLee.app` rebuilt (reported). The three are byte-identical and contain the new look (checked in the doc pass)
  - [x] Docs: `docs/changelog.md`, `docs/spec/mot-ngay-o-cong-ty.md` §4.4, `docs/glossary.md`, `docs/tasks.md`, `CLAUDE.md` (status). `docs/product-guide.md` has no look text and was not changed
  - [x] `tools/macapp/Info.plist` and `dist/MinhLee.app/Contents/Info.plist`: `CFBundleShortVersionString` is 1.8.5 (checked in the reconciliation pass). Closes the macOS app version follow-up. `CFBundleVersion` stays 1

- [x] v1.8.4 (2026-11-04): name tag and speech bubble of a lying coworker (Nguyên on the pantry daybed) anchored to the body and head instead of the feet (user bug report with a screenshot). Details: `docs/changelog.md` v1.8.4, `docs/spec/dong-nghiep.md` §7.1 and AC-70
  - [x] `isLying()` and `npcAnchor()` in `index.html` (next to `createNpcs()`): lying tag 0.6 m toward the head at 0.75 m high, lying bubble 1.05 m toward the head at 0.85 m high, head direction `-(sin yaw, cos yaw)`. Standing and seated values unchanged
  - [x] Headless-Chrome screenshot of Nguyên on the daybed, tag and bubble placed correctly (reported by the requester; not re-run in the doc pass)
  - [x] Headless-Chrome full-day run: no JS errors, no collision violations (reported by the requester; not re-run in the doc pass)
  - [x] Ambient on-screen gate in `tryNpcSay()` now tests `npcAnchor(n, …, false)`, the same lying-aware point as the bubble (was the standing point). Closes the v1.8.4 known defect (found by reading the code; closed in the 2026-11-04 reconciliation pass)
  - [x] `index-offline.html`, `dist/MinhLee.app`, `dist/netlify/index.html` rebuilt. The three are byte-identical, match the current `index.html` apart from the importmap and comment lines, and contain the new code (checked in the doc pass)
  - [x] Docs: `CLAUDE.md`, `docs/spec/dong-nghiep.md`, `docs/glossary.md`, `docs/changelog.md`, `docs/tasks.md`

- [x] v1.8.3 (2026-11-04): on-screen help suggests Safari or an updated Chrome whenever 3D cannot show. Details: `docs/changelog.md` v1.8.3, `docs/spec/tuong-thich-trinh-duyet.md` §3
  - [x] Too-old message, in-app banner, boot-error text (first tip), title WebGL note (adds "Tăng tốc phần cứng" for Chrome), mid-game toast (9 s), list-mode panel note (automatic switch only; manual simple mode unchanged) (`index.html` `<head>` script, `init()`, `fallbackToLite()`, `refreshLite()`, `#boot-error`)
  - [x] Headless Chrome check with WebGL creation forced to fail: title note, toast, list-mode note, boot-error text contain the suggestion (reported by requester; not re-run in the doc pass)
  - [x] `index-offline.html`, `dist/netlify/index.html`, `dist/MinhLee.app` rebuilt; the three are byte-identical and contain the new strings (checked in the doc pass). `dist/MinhLee-mac.zip` rebuilt (contents not opened)
  - [x] Docs: `CLAUDE.md`, `docs/spec/tuong-thich-trinh-duyet.md` (§3 texts, toast 6 s corrected to 9 s, CP-12 to CP-14), `docs/product-guide.md` (FAQ), `docs/deploy.md` (recipient advice), `docs/changelog.md`, `docs/tasks.md`
  - [x] Boot-error tip placement accepted as-is: tip ① (Safari, or updated Chrome) comes first after the lead-in. See `docs/tasks.md` Help text (v1.8.3)
  - [x] Option 2 deploy doc: `tools/prepare-netlify.sh` is now described in `docs/deploy.md` (closes the v1.7.0 item below)

- [x] v1.8.2 (2026-11-04): serious Nam–Thạnh duo, Nam's 09:42 work quirk, random duo script per visit. Details: `docs/changelog.md` v1.8.2, `docs/spec/dong-nghiep.md` §1–2, `docs/spec/noi-dung-bat-ngo.md` §2
  - [x] Second `nam` / `thanh` script in `DUOS` (serious, 4 lines). `DUOS` now has 17 scripts for 16 pairs
  - [x] Nam's 09:42 quirk ("Thạnh ơi, 10 giờ họp nhé…", `anim: 'talk'`) in `index.html` `NPC_PROFILES`
  - [x] `runVisit()` picks randomly among all scripts for a pair, once per visit (was the first match)
  - [x] Headless-Chrome full-day run (reported by requester; not re-run in the doc pass): no JS errors, no collision violations, content ids valid
  - [x] `index-offline.html`, `dist/MinhLee.app`, `dist/netlify/index.html` rebuilt. The three are byte-identical and contain the new strings (checked in the doc pass)
  - [x] Docs: `CLAUDE.md`, `docs/spec/dong-nghiep.md`, `docs/spec/noi-dung-bat-ngo.md`, `docs/product-guide.md`, `docs/glossary.md`, `docs/changelog.md`, `docs/tasks.md`

## Done (v1.9.1 to v1.9.4, moved from tasks.md in v1.10.0)

- [x] v1.9.4 (2026-11-04): `look.detail` (detailed eyes, brows, smile, neck, hair style) enabled for the remaining nine coworkers. All 14 now use it. Looks were upgraded from the existing look data and colours. No reference photos were re-checked in this pass, so likeness is unverified. Toàn's navy polo collar closes the photo gap in the v1.8.6 item. Details: `docs/changelog.md` v1.9.4, `docs/spec/dong-nghiep.md` §8
  - [x] `NPC_PROFILES` looks for Trung, Toàn, Hiện, Tùng, Nam, Chú 7, Chị Ba, Anh Bảo, and Nguyên in `index.html` (`look.detail: true`, hair, neck, collar, glasses, lashes, lips, earrings)
  - [x] Headless-Chrome lineup render, screenshot viewed (by eye only)
  - [x] Offline copies (`index-offline.html`, `dist/netlify/index.html`, `dist/MinhLee.app/Contents/Resources/index.html`) hold the same 14 `look: {` lines as `index.html` (grep and diff check). The three copies are byte-identical; `index.html` differs only by the importmap and the comment line
  - [ ] Likeness check of the nine against the reference photos, side by side (see Follow-ups, v1.9.4)
  - [ ] Real-device check (not run)
  - [ ] `dist/MinhLee-mac.zip` and `CFBundleShortVersionString` (still 1.8.5) not rebuilt in this pass (see Follow-ups, v1.8.6 item)

- [x] v1.9.3 (2026-11-04): looks for Yến, Thạnh, and Phú re-matched to the user's reference photos (viewed this session). New `look.teeth`, `look.part`, `look.shortSleeve` and hairStyle `quiff`. Details: `docs/changelog.md` v1.9.3, `docs/spec/dong-nghiep.md` §8, `docs/glossary.md`
  - [x] `NPC_PROFILES` looks for Yến (centre part, no clip or fringe, rose-gold glasses, coral lips, gold earrings), Thạnh (`quiff`, light-silver glasses, slimmer face, gingham short sleeves), Phú (`side` hair, rect dark glasses, wider face, collared shirt) in `index.html`
  - [x] `detailFace()`, `detailHair()`, `buildCharacter()` in `index.html`: `look.teeth`, `look.part: 'center'`, `quiff`, `look.shortSleeve`
  - [x] Headless-Chrome render, screenshot viewed; compared to the photos by eye only
  - [x] Offline copies (`index-offline.html`, `dist/netlify/index.html`, `dist/MinhLee.app`) contain the v1.9.3 code (grep check; byte-identical in the doc pass)
  - [ ] Real-device check (not run)
  - [ ] Side-by-side likeness score against the reference photos (not recorded)
  - [ ] `dist/MinhLee-mac.zip` and `CFBundleShortVersionString` not rebuilt in this pass (see Follow-ups, v1.8.6 item)

- [x] v1.9.2 (2026-11-04): detailed character look (`look.detail`), still Three.js primitives in one file. Five coworkers upgraded: Thạnh, Phú, Thảo, Yến, Thông. Thảo's wavy hair gap is closed. Other coworkers unchanged. Details: `docs/changelog.md` v1.9.2, `docs/spec/dong-nghiep.md` §8, `docs/glossary.md`
  - [x] `buildCharacter()` (section 6) in `index.html`: `detailFace()`, `detailHair()`, `detailClothes()`, opt-in on `look.detail`
  - [x] Headless-Chrome render of a lineup, screenshot viewed
  - [x] Offline copies (`index-offline.html`, `dist/netlify/index.html`, `dist/MinhLee.app`) contain the code (grep check; `index-offline.html` differs from `index.html` only by the importmap and the comment line)
  - [ ] Real-device check (not run)
  - [ ] Likeness against the reference photos, side by side (not done; earlier notes only)
  - [ ] `dist/MinhLee-mac.zip` and `CFBundleShortVersionString` not rebuilt in this pass (see Follow-ups, v1.8.6 item)

- [x] v1.9.1 (2026-11-04): text-only. Chị Ba's (`an3`) lines made grumpier and visibly annoyed, still funny and never mean. Signature stand line unchanged. No logic or ids changed. Details: `docs/changelog.md` v1.9.1, `docs/spec/dong-nghiep.md` §7.6
  - [x] Lines rewritten in `index.html`: `say.greet`, `say.idle`, `say.chat`, `say.pantry`, `reply`, `request`, `meeting`, `quirks`, `DOC_QUESTS` ask, two `DUOS` lines (Chú 7, Nam), `dammhaam` result
  - [x] JavaScript syntax check and headless smoke run
  - [ ] Native-speaker review of the new Chị Ba wording (not reviewed)
  - [ ] Hand-check Chị Ba's lines in a real browser (tone and bubble fit, not recorded)

## Done (v1.9.0 and v1.9.5, moved from tasks.md in v1.11.0)

- [x] v1.9.5 (2026-11-04): Anh Bảo's look re-matched to the user's photo (by eye only: navy colour-block polo, black fringe, thin light-silver glasses). Canon fix: Chị Ba is not allergic to cats (golden cat Nghệ). Cat banter with Chủ tịt added (chat line, two duos, `th-cat` intro and options). Details: `docs/changelog.md` v1.9.5
  - [x] `NPC_PROFILES` `bao` look (`hem`, `cuff`, `shortSleeve`, navy collar, `fringe`, `rect` glasses), new look fields `look.hem` and `look.cuff` in `buildCharacter()`
  - [x] `th-cat` intro: allergy lines removed. Option 2 relabelled, option 3 result updated. Chị Ba `say.chat` line about Nghệ. Two `DUOS` entries (`an3`–`thanh`, `thanh`–`an3`): 19 scripts for 17 pairs
  - [x] JavaScript syntax check and headless render of Anh Bảo (viewed by eye)
  - [x] Docs: `docs/spec/dong-nghiep.md`, `docs/spec/noi-dung-bat-ngo.md`, `docs/glossary.md`, `docs/product-guide.md`
  - [ ] Native-speaker review of the cat banter, the `th-cat` intro, and its options (not reviewed)
  - [ ] Side-by-side likeness check of Anh Bảo against the reference photo (by eye only, not measured). Real-device look check at the default camera distance (Vừa)
  - [ ] Hand-check the Chị Ba–Chủ tịt duo visit (both script orders, bubbles) and the `th-cat` cards in a real browser (not recorded)
  - [ ] `dist/MinhLee-mac.zip` not rebuilt in this pass (see the v1.8.6 follow-up)

- [x] v1.9.0 (2026-11-04): six new day themes (demo, power, cat, hack, sick, award), each opening with a story intro at 08:50 that fires when the player is near a coworker. Desk items: finished desk tasks add up across days and unlock 8 items on the 3D desk, with a collection screen in the pause menu. Details: `docs/changelog.md` v1.9.0, `docs/spec/noi-dung-bat-ngo.md` §3.2 and AC-75 to AC-77, `docs/spec/bang-nhiem-vu.md` §9 and AC-78 to AC-80, `docs/product-guide.md`
  - [x] `DAY_THEMES` (six themes with `intro`), `UNLOCKS`, `awardWork()`, `showUnlocks()`, `nextUnlockLine()`, `showCollection()`, `buildDeskItems()` in `index.html`
  - [x] Headless Chrome: intro fires near a coworker; unlock thresholds; 8 desk items built
  - [x] Offline copies, netlify, and app resources contain the v1.9.0 code (grep check in the doc pass)
  - [ ] Look at the 8 desk items in 3D (shapes not reviewed)
  - [ ] Test the intro on a real device and in Safari or Firefox; check the far-away skip and the 11:20 cut-off (not recorded)
  - [ ] Full-day headless run covering the six new themes and all 18 intro options (AC-76, AC-77)
  - [ ] Set `CFBundleShortVersionString` to 1.9.0 and rebuild `dist/MinhLee-mac.zip` (see Follow-ups, v1.8.6 item)
  - [ ] Docs: `docs/product-guide.md`, `docs/spec/*`, `docs/glossary.md` updated. `CLAUDE.md` not touched (user choice)

## Moved from docs/tasks.md in the v1.13.0 pass (v1.10.1 and v1.10.0 done entries)

Entries are not edited.

- [x] v1.10.1 (2026-11-04): welcome-back popup hides the title screen's name and gender form while it is open, so returning players see only "▶ Tiếp tục" and "🆕 Chơi mới". The form returns only after the confirmed reset. Reason: players could miss the small "Tiếp tục" button. Details: `docs/changelog.md` v1.10.1, `docs/spec/the-gioi-lien-tuc.md` §11.5, AC-84
  - [x] `showWelcomeBack()` (`index.html` section 14): adds `hidden` to `#title` on open, unhides it after `Store.clear()` in "Xóa hết và chơi mới". "Thôi, quay lại" keeps it hidden
  - [x] Headless Chrome: `#title` hidden during the popup, kept hidden after back, shown after reset, fresh player sees no popup
  - [ ] Real browser and phone check of the popup (not tested outside headless Chrome)
  - [ ] `dist/MinhLee-mac.zip` not rebuilt in this pass (see v1.10.0 follow-up)
  - [x] Docs: changelog, `docs/spec/the-gioi-lien-tuc.md` §11.5, `docs/spec/mot-ngay-o-cong-ty.md` AC-84, `docs/product-guide.md`

- [x] v1.10.0 (2026-11-04): mid-day save and resume (closing the tab no longer restarts the day), welcome-back popup on boot (continue, new game with confirmation, or back), Anh Bảo's look (black polo collar, white cuffs, swept hair, red-and-white striped shirt), Nguyên sleeps less (one nap after lunch, otherwise works on a pantry sofa) and can visit Chị Thảo from the sofa, so his two `nguyen`→`thao` duo scripts play (21 in total). Trung also visits Nguyên (40% per visit attempt, two `trung`→`nguyen` scripts), so the total is 23 scripts for 19 pairs. Details: `docs/changelog.md` v1.10.0, `docs/spec/the-gioi-lien-tuc.md` §11
  - [x] `saveSession()`, `validSession()`, `resumeSession()`, `#btn-resume`, `Store.session` (`session: null` in the `endDay` patch, `exitToTitle`, and start-over) in `index.html` section 14 and the title code
  - [x] `showWelcomeBack()` (section 14, called from `init()`): the popup, the "Chơi mới?" confirmation, and "Thôi, quay lại". Spec `docs/spec/the-gioi-lien-tuc.md` §11.5, AC-84
  - [x] `npcAmbient()` `sofaWorker`: a sofa-seated Nguyên may start a visit, to Chị Thảo only (who must be at `desk:work`). Closes the duo defect
  - [x] `times.nap` in `resetNpcDay()`, `goalSofa()` and `decideGoal()` (section 9). Measured in 30 simulated days: lying about 10% of checked time, sofa work about 71%, other about 19%
  - [x] `NPC_PROFILES` `bao` look: `hem` removed, black polo collar (`collar: 0x1a1a1c`), white `cuff`, `hairStyle: 'swept'` (new style replaces `fringe`), `pattern: 'redwhite'` shirt (intentional, per the user)
  - [x] Arrival toast reworded to "đang ở pantry" (`processTimeEvents()`)
  - [x] Headless Chrome: snapshot fields restored, resume button visibility, session cleared. Popup: text and buttons, continue at 13:10 with 1 task, back keeps data, clear to 0 days. Nguyên visits Chị Thảo in 6 of 6 runs. The v1.10.0 code is in all four copies (grep check)
  - [x] Docs: changelog, `docs/spec/the-gioi-lien-tuc.md`, `docs/spec/mot-ngay-o-cong-ty.md`, `docs/spec/dong-nghiep.md`, `docs/spec/noi-dung-bat-ngo.md`, `docs/product-guide.md`, `docs/glossary.md`
  - [ ] Real browser restart test: close the browser (or the Mac app) mid-day, reopen, press "▶ Tiếp tục ngày đang dở". Headless only so far
  - [ ] Test on a real phone (iOS Safari, Android Chrome): `visibilitychange` and `pagehide` save, and the resume path
  - [ ] `dist/MinhLee-mac.zip` and `CFBundleShortVersionString` (still 1.8.5) not rebuilt in this pass (see Follow-ups, v1.10.0)

## Moved from docs/tasks.md in the v1.14.0 pass (v1.11.0 and v1.12.0 done entries)

- [x] v1.12.0 (2026-11-04): takeaway cups and pantry treats. Chủ tịt's 11:05 treat picks at random among trà sữa, rau má, and nước mía (14:10 stays snack). Up to 8 coworkers gather at the pantry for 30 game-minutes; everyone else gets a cup on their desk. Anh Bảo's desk has an iced black coffee cup (`cafeden`). The hand cup is now a street-style takeaway cup. Details: `docs/changelog.md` v1.12.0, `docs/spec/noi-dung-bat-ngo.md` §3.1, `docs/spec/van-phong-layout.md` §3 and AC-91, AC-92, `docs/spec/mot-ngay-o-cong-ty.md` AC-87 to AC-90
  - [x] `makeTakeawayCup()`, `setCupDrink()`, `TREAT_DRINKS` (section 6). `startTreat()` and the treat branch of `processTimeEvents()` (section 14). `goalPantry(n, 'treat')` and `decideGoal()` (section 9). `dk.treatCup` and `DESKS[2].icedCoffee`
  - [x] Headless Chrome: all random kinds appear, 8 join, 14 get cups, 7 at the pantry in one test, 14 desk cups later, the mid-day session saves `treat`. Cup close-ups rendered and viewed
  - [ ] Cups not verified in the in-game camera at the default distance (cups are small and hidden behind bodies). Not on a real device. See Follow-ups, v1.12.0
  - [x] Docs: changelog, `docs/spec/noi-dung-bat-ngo.md`, `docs/spec/dong-nghiep.md`, `docs/spec/van-phong-layout.md`, `docs/spec/mot-ngay-o-cong-ty.md`, `docs/spec/the-gioi-lien-tuc.md`, `docs/product-guide.md`, `docs/glossary.md`
  - [x] Pantry table pass: `PANTRY_TABLE` (section 5) with a `nonav` obstacle, 8 `PANTRY_SPOTS` on a ring around it (AC-93, AC-94), cups and the 14:10 dish on the table (`updatePantryTable()`, `FOODS`, `makeFood()`), hand cups only after arrival. Headless Chrome checks in `docs/changelog.md` v1.12.0

- [x] v1.11.0 (2026-11-04): office layout change. New private desk 13 in the lower row, next to Thông's (`addOwnAt(-4.4)`, x −4.4). Tùng moves from desk 8 to desk 13. Nguyên, who had no desk, takes desk 8 (Tùng's old seat, right table, south, next to Chú 7). He naps on the daybed after lunch and otherwise works at his desk. Trung's visits to Nguyên now go to his desk (same 40% gate, excluded from the normal candidate list). Nguyên's lines updated; arrival toast reads "Nguyên hiếm hoi lên công ty hôm nay!". Details: `docs/changelog.md` v1.11.0, `docs/spec/van-phong-layout.md` §3 and AC-85, `docs/spec/dong-nghiep.md` §3 and AC-46, AC-49, AC-86
  - [x] `DESKS` has 14 entries (section 5, `addOwnAt(-4.4)`). `NPC_PROFILES`: `tung` `desk: 13`, `nguyen` `desk: 8` (section 2). Nguyên's nap and desk branch in `decideGoal()` (section 9)
  - [x] Headless Chrome: `DESKS.length` 14; Tùng seats at (−4.4, 5.8) at the new desk; Nguyên at (8.1, −0.8) in `desk:work` at 10:00, nap goal `lounge`; screenshots show Nguyên at desk 8 and the new desk in the lower row
  - [x] Docs: changelog, `docs/spec/van-phong-layout.md`, `docs/spec/dong-nghiep.md`, `docs/spec/mot-ngay-o-cong-ty.md`, `docs/spec/noi-dung-bat-ngo.md`, `docs/product-guide.md`, `docs/glossary.md` (dated notes only)
  - [ ] Pathing at peak times around desks 9 and 13 and `COLUMNS[1]` not checked (Follow-ups, v1.11.0)
  - [ ] Full-day run and real-device check not done

## Moved from docs/tasks.md in the v1.15.0 pass (v1.13.0 and v1.14.0 done entries)

- [x] v1.14.0 (2026-11-04): sit-and-work time-lapse at the desk, and an end-of-day reaction when fewer than 2 desk tasks are done. Yến and Thảo now assign desk tasks. Spec: `docs/spec/ngoi-lam-viec.md`
  - [x] `startTimelapse()`, `endTimelapse()`, `workNag()`, `workBrief()` (section 11). Timelapse branch of `update()` and `endDay()` (section 14). `WORK_QUOTA`, `WORK_NAG`, `WORK_VOICE`, and the new `SORT_SETS` and `ORDER_SETS` entries (variety block)
  - [x] Headless Chrome (reported by requester): menu order, mode switch, overlay, clock 15 game min in 3 s, yaw orbit, tap restores camera and menu, auto-stop at 09:00, four assigners' reactions, no-reaction case
  - [ ] Not tested on touch, over a full real-time day, or with a screenshot of the orbit. See Follow-ups, v1.14.0
  - [x] Docs: changelog, `docs/spec/ngoi-lam-viec.md` (new), `docs/spec/mot-ngay-o-cong-ty.md`, `docs/spec/dong-nghiep.md`, `docs/product-guide.md`, `docs/glossary.md`
  - [ ] Chủ tịt and Nam's reaction lines were not reachable in v1.14.0 (`docs/spec/ngoi-lam-viec.md` §3.5). Closed in v1.15.0

- [x] v1.13.0 (2026-11-04): document quest without hints, and "Rớt mạng" wording. The cabinet card, the afternoon hint, and the mission row no longer name the document. "🔁 Hỏi lại" in the asker's talk menu repeats the ask at stage 2. A wrong pick brings the asker's reaction in their own voice (`WRONG_DOC`, 5 askers, 2–3 lines each). Yến and Thảo are new askers. `DOC_QUESTS` has 5 entries and `DOC_NAMES` 6. The `wifi` surprise is retitled "Rớt mạng" (3 strings changed). Details: `docs/changelog.md` v1.13.0, `docs/spec/nhiem-vu-tai-lieu.md`, AC-95 to AC-99
  - [x] `DOC_QUESTS`, `WRONG_DOC`, `DOC_NAMES`, and the `wifi` surprise (variety block, between sections 2 and 3). `afternoonHint()` and `extraTasks()` (section 10). `startTalk()`, `questAsk()`, `cabinetFlow()` (section 11)
  - [x] Headless Chrome (reported by requester): all 5 askers give a personality line that names the needed document, no hint text, correct pick completes at stage 3
  - [ ] Not tested over a full day or on a real device. "🔁 Hỏi lại" and the 5-button cabinet were not recorded in the headless run. Wording not native-reviewed. See Follow-ups, v1.13.0
  - [x] Docs: changelog, `docs/spec/nhiem-vu-tai-lieu.md` (new), `docs/spec/mot-ngay-o-cong-ty.md`, `docs/spec/bang-nhiem-vu.md`, `docs/spec/dong-nghiep.md` (§7.7; §8 moved to `docs/spec/ngoai-hinh-dong-nghiep.md`), `docs/spec/noi-dung-bat-ngo.md`, `docs/product-guide.md`, `docs/glossary.md`

## Closed in the v1.16.0 pass (moved from docs/tasks.md, 2026-11-04)

Moved verbatim from `docs/tasks.md` to keep that file under 300 lines. The v1.15.0 Done entry is here too.

### Done: v1.15.0

- [x] v1.15.0 (2026-11-04): every coworker assigns desk work. `SORT_SETS` has 14 sets and `ORDER_SETS` 15 (Chủ tịt has two). `WORK_VOICE` and `WORK_NAG` cover all 14 coworkers. `newWork()` skips assigners who are not in the office (remote Nguyên on remote days). Closes the v1.14.0 gap where Chủ tịt's and Nam's reaction lines were never shown. Details: `docs/changelog.md` v1.15.0, `docs/spec/ngoi-lam-viec.md` §3.3 to §3.5, AC-115, AC-116
  - [x] Data: 10 new sort sets, 10 new order sets plus Chủ tịt's second, 10 voices, 10 reaction entries (`index.html`, variety block). `newWork()`, `workNag()`, `workBrief()` (section 11)
  - [x] Headless Chrome (reported by requester): structure checks, 14 distinct assigners in 400 draws, Chủ tịt and Nguyên briefs show their own voice, absent Nguyên never assigned in 300 draws, mini-game opens for a new set
  - [ ] Not verified: playing every new set to completion, native-speaker review, a full-day run. See Follow-ups, v1.15.0
  - [x] Docs: changelog, `docs/spec/ngoi-lam-viec.md`, `docs/spec/mot-ngay-o-cong-ty.md`, `docs/spec/dong-nghiep.md`, `docs/product-guide.md`, `docs/glossary.md`

### Closed items: Known defects

- [x] (v1.10.0, closed 2026-11-04) Anh Bảo's shirt colour is not a defect. The red-and-white striped shirt (`pattern: 'redwhite'`, `index.html` line 481) is intentional, per the user's explicit request for this release. The solid polo of the first brief is not used. The look is recorded in `docs/spec/dong-nghiep.md` §8
- [x] (v1.10.0, closed 2026-11-04) Nguyên–Chị Thảo duo scripts (`nguyen`→`thao`, `index.html` `DUOS`) never played. Fixed in `npcAmbient()`: a sofa-seated Nguyên may start a visit, to Chị Thảo only, who must be seated at `desk:work`. Headless: 6 of 6 runs. Not tested on a real device
- [x] (v1.10.0, closed 2026-11-04) The arrival toast was reworded; later removed entirely in v1.11.0 at the user's request (`index.html`, `processTimeEvents()`)
- [x] (v1.8.4, closed 2026-11-04) The ambient on-screen gate in `tryNpcSay()` (`index.html`, `Bubbles.onScreen(n.pos.x, root.y + 1.8, n.pos.z)`) still tests the standing point at the coworker's position, not `npcAnchor()`. For a lying coworker the gate can pass while the bubble anchor is off screen (the bubble is then hidden), or block a bubble that would be visible. Found by reading the code, not reproduced. Decide whether the gate should use `npcHead(n)`. Not changed in v1.8.4 (scope: anchors only) **Fixed:** `Bubbles.onScreen()` now gets `npcAnchor(n, …, false)`, the same point as the bubble. Not reproduced in a browser; checked by reading the code.
- [x] (v1.1.2, resolved 2026-11-04 in source) `index.html` section 2 field comment (around line 239) lists `style` values without `'fringe'` and does not mention `mustache`, `glassColor`, or `pattern: 'stripe'`. Update the comment when `index.html` is next edited. Not changed in v1.1.2 (`index.html` was read-only). Checked 2026-11-04: the header now lists `fringe`, `glassColor`, `mustache`, and `pattern` `'stripe'`
- [x] (v1.2.0, fixed v1.3.0) Nguyên's birthday never fired. His offset `(13 × 5 + 3) % 65` = 3 equalled Chủ tịt's offset, and `NPCS.find()` returned Chủ tịt first. Fixed: offset is `(index × 4 + 3) % 65`, unique per coworker (Nguyên = 55). `docs/spec/the-gioi-lien-tuc.md` §7 and AC-35 updated. Not yet confirmed over a 65-day run (see Follow-ups).
- [x] (v1.2.0, fixed v1.3.0) The random cake party in `startDay()` could pick Nguyên on a remote day. The pick is now `NPCS.filter(n.id !== 'thao' && n.times.arrive < 99999)`, so remote coworkers are excluded. Found by reading the code, not reproduced.
- [x] `{{anh}}` defect in Nam's greeting, fixed in v1.0.2 (see Done).
- [x] (v1.4.3, resolved in source 2026-11-04, v1.4.4) Surprise `dating100k`, option 1 now reads "Em mời trà sữa!"
- [x] (v1.4.4, closed v1.6.0) Yến's greeting `say.greet[1]` ("Mới sáng ra đã… là sao?") is now tagged `@am`, and a `@pm` greeting was added. Source check only (`index.html` line 402)

### Closed items: Open questions

- [x] (resolved 2026-11-04, v1.8.1, per the user) Who is "bé Hạnh"? Nam's teasing nickname for Chủ tịt (Thạnh). Serious work talk uses "Thạnh". Was: who or what is "bé Hạnh"? It appears in 3 of Nam's `say.absent` lines ("Nhớ bé Hạnh ghê…", "Nhớ bé Hạnh… với cả ly trà sữa của Chủ tịt nữa"). The game does not explain it, so the answer is recorded only in `docs/spec/dong-nghiep.md` §1–2 and the glossary (annotated v1.8.1). Whether to explain it in the game itself is still open
- [x] (closed 2026-11-04) Nguyên's role is `Designer` (confirmed). No gender is recorded: none was stated, so the "assumed male" note is removed. `role` in `NPC_PROFILES`, the product guide, and the glossary are updated.
- [x] (closed 2026-11-04) Nam is the same age as Chủ tịt and Chị Ba. His lines are peer-level (mình / bạn). Recorded in `docs/spec/dong-nghiep.md` §2.
- [x] (closed 2026-11-04) Spelling confirmed: "Chủ tịt", not "Chủ tịch". No code or text change needed.
- [x] (closed 2026-11-04) Reading confirmed: Anh Bảo is the oldest and is called "Anh Bảo". Chị Ba calls Chủ tịt "anh".
- [x] (v1.4.0, closed 2026-11-04 in v1.4.3) Duo `an7`–`thong` (Chú 7 and Thông): the backup and worry lines are removed. Rewritten to the tea persona ("Thông ơi, uống trà không? Ô long mới…")

### Closed items: Follow-ups

- [x] (v1.14.0, closed v1.15.0) Chủ tịt and Nam reaction lines (`WORK_NAG.thanh`, `WORK_NAG.nam`) were never shown: no set assigned work from them. Both now have sets. `docs/spec/ngoi-lam-viec.md` §3.5

### Closed items: Other sections

- [x] (v1.4.1, closed in v1.9.5 by eye) Anh Bảo's look was an approximation from a written brief. Re-matched to the user's photo in v1.9.5. Side-by-side likeness check still open (v1.9.5 item)
- [x] (v1.8.5, closed 2026-11-04) Macintosh app version: `tools/macapp/Info.plist` and `dist/MinhLee.app/Contents/Info.plist` read `CFBundleShortVersionString` 1.8.5
- [x] (v1.8.5, closed 2026-11-04) Changelog entries for v1.8.1 and v1.8.4 exist (they were out of order and were reordered; no numbers skipped)
- [x] (v1.8.1, closed 2026-11-04) The changelog v1.8.1 entry exists (it was out of order and is now between v1.8.2 and v1.8.0)
- [x] (v1.6.0, closed in v1.8.5) `tools/macapp/Info.plist` `CFBundleShortVersionString` now reads 1.8.5 (it read 1.6.0 at v1.7.0 and 1.8.0 through v1.8.4). `CFBundleVersion` is still 1 by design
- [x] (v1.7.0, closed v1.8.3) `tools/prepare-netlify.sh` writes `dist/netlify/index.html` (a copy of the offline file). Now described in `docs/deploy.md` option 2 (checked in the doc pass)
- [x] (v1.8.3, accepted as-is 2026-11-04) Boot-error text: tip ① is "mở bằng Safari, hoặc cập nhật Chrome lên bản mới nhất", placed first after the lead-in "Game chưa khởi động được. Bạn thử:". Accepted as-is
- [x] (v1.8.6, Toàn's polo collar closed 2026-11-04 in v1.9.4) Photo gaps: Toàn's collar is now modelled as a navy `collar` (Thảo's wavy hair closed in v1.9.2). No desk-3 plant pot was found in the code. Confirm with the user whether that is acceptable or needs a new style
- [x] (v1.9.2, closed 2026-11-04 in v1.9.4) Next batch: all remaining coworkers are on `look.detail`. Anh Bảo's look is still an approximation (see the v1.4.1 item)

## Moved from docs/tasks.md in the v2.0.0-alpha pass (v1.16.0 done entry)

- [x] v1.16.0 (2026-11-04): the workday ends at 18:00 (was 17:30), followed by a farewell scene. `CFG.END` is 18:00 and `CFG.FAREWELL` 40. The camera orbits, coworkers leave one by one with a goodbye line, Chủ tịt leaves last, Toàn stays until 7 pm, then the end card. Details: `docs/changelog.md` v1.16.0, `docs/spec/tan-ca-18-gio.md`, AC-117 to AC-124
  - [x] Code (`index.html`): `CFG.END` and `CFG.FAREWELL`, leave times (`habits.leave`), `startFarewell()`, `endFarewell()`, `farewellEndText()`, `FAREWELL_LINES`, `TOD` 18:40 keyframe, `wrap` milestone at 17:30, Tùng's quirk at 17:35
  - [x] Headless Chrome (reported by requester): scene entered; 13 coworkers left in order (Chủ tịt last); Toàn still seated; end card at about 18:32. Not re-run in the doc pass
  - [ ] Not verified: the scene in a screenshot or video, the camera distance after the restore, touch and real devices, native review of the goodbye lines. See Follow-ups, v1.16.0
  - [x] Docs: changelog, `docs/spec/tan-ca-18-gio.md` (new), `docs/spec/mot-ngay-o-cong-ty.md`, `docs/spec/ngoi-lam-viec.md`, `docs/spec/dong-nghiep.md`, `docs/spec/bang-nhiem-vu.md`, `docs/spec/the-gioi-lien-tuc.md`, `docs/spec/noi-dung-bat-ngo.md`, `docs/product-guide.md`, `docs/glossary.md`

## Moved from docs/tasks.md in the v2.0.1-alpha pass (v2.0.0-alpha done entry and a closed known defect)

- [x] v2.0.0-alpha (2026-11-04): multiplayer stage 1, sign-in and cloud save. Guest play unchanged. Spec: `docs/spec/nhieu-nguoi-choi.md` §9. Details: `docs/changelog.md` v2.0.0-alpha
  - [x] Code (`index.html`): Supabase constants, lazy import of `@supabase/supabase-js@2.45.4`, cloud block (`cloudBoot`, `cloudClaim`, `cloudApply`, `cloudPush`, `cloudFlush`, `showLogin`, `memberLogout`), `Store` backend switch, member NPC hidden, login and welcome popups
  - [x] Server (owner, Supabase dashboard, not in repo): tables, `claim_character()`, RLS, signups off, 14 invited emails, custom SMTP, Site URL and Redirect URL. Reported by the owner, not re-checked
  - [x] Checks: syntax; project probes; supabase-js calls from Node; headless Chrome with a mocked member. Not verified: see Follow-ups, v2.0.0-alpha
  - [x] Docs: changelog, `docs/spec/nhieu-nguoi-choi.md`, `docs/spec/mot-ngay-o-cong-ty.md`, `docs/spec/phan-phoi-offline.md`, `docs/product-guide.md`, `docs/glossary.md`
- [x] (v2.0.0-alpha, fixed 2026-11-04) Member reset: `Store.clear()` now returns without doing anything while a cloud backend is set (a signed-in member cannot wipe their data from inside the game; `dlog` records the skipped call), so the next `cloudFlush()` can no longer overwrite the server row with defaults. Guest reset is unchanged. Verified in headless Chrome (member: days 5 / tasks 7 kept, nothing pushed; guest: cleared). Not done: a deliberate "reset my progress" for members, if ever wanted.

## Moved from docs/tasks.md in the v2.1.0-alpha pass (v2.0.1-alpha done entry, a closed follow-up, a closed known defect)

- [x] v2.0.1-alpha (2026-11-04): fixes after the owner's first real sign-in test. Login and cloud save work. Members sit at their own desk and are called by character name. Details: `docs/changelog.md` v2.0.1-alpha. Spec: `docs/spec/nhieu-nguoi-choi.md` §6.1, §9
  - [x] Server (owner, Supabase SQL, not in repo): grants for `authenticated` on `progress` and `roster`, schema usage. Confirmed: saving works
  - [x] Code (`index.html`): `applyPlayerDesk()`, `PLAYER_DESK.sx`/`sz`, `MEMBER_CALL`, 42501 toast in `cloudFlush()`
  - [x] Checks: headless Chrome for Bảo, Toàn, Phú, Thảo (seat, spot, items, logout). Not verified: see Follow-ups, v2.0.1-alpha
  - [x] Docs: changelog, `docs/spec/nhieu-nguoi-choi.md`, `docs/spec/bang-nhiem-vu.md`, `docs/product-guide.md`, `docs/glossary.md`
- [x] (v2.0.1-alpha, closed 2026-11-04 in v2.1.0-alpha) Decide password or magic link. Decided: email and password, with a create-password step and a recovery email (`docs/spec/nhieu-nguoi-choi.md` §10)
- [x] (v1.10.0, resolved v1.11.0) `npcAmbient()` pushed Nguyên into `duoC` twice (once by the `filter`, once explicitly), so he has double weight among the duo partners. Resolved in v1.11.0: `cands` excludes Nguyên for Trung, and the 40% gate adds him once
