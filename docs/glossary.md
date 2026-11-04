# Glossary

Format: **Term** — Definition. New terms are added at the end. Existing definitions are curated by humans and are not rewritten by automation.

**Một Ngày Ở Công Ty** — The game's title, meaning "One Day at the Office". *(Outdated as of v1.0.3: renamed to "Một Ngày Ở MinhLee". Kept for history.)*

**Ngày làm** — A single work day in the game, from 08:30 to 17:30 in game time.

**Đồng nghiệp (NPC)** — One of the 12 computer-controlled coworkers. Defined by an entry in `NPC_PROFILES`. *(Outdated as of v1.0.2: there are 13 coworkers, including Thông.)* *(Outdated as of v1.2.0: there are 14 coworkers, including Nguyên.)*

**Hồ sơ đồng nghiệp** — A coworker profile: name, role, desk, look, habits, stats, dialogue. Section 2 of `index.html`.

**Bàn (desk index)** — The seat number (0–11) a coworker is assigned to. *(Outdated as of v1.0.2: range is 0–12.)* *(v1.2.0: Nguyên has no desk, `desk: null`.)* *(Outdated as of v1.3.0: desks 0–8 are the two long tables, 9–12 the lower row. See `docs/spec/van-phong-layout.md` §3.)*

**Mốc (milestone)** — A named time window in the day with a goal hint (e.g. "Họp ngắn" at 10:00). Defined in `MS`.

**Điểm tương tác (spot)** — A fixed place the player can interact with (desk, pantry, cabinet, printer, notice board, sofa, front door). Defined in `SPOTS`.

**Năng lượng (energy)** — Player stat from 0 to 100, shown as ⚡. Drops over time, restored by food and rest.

**Tâm trạng (mood)** — Player stat from 0 to 100, shown as a face and label. Affects the summary comment.

**Thân thiết (affinity)** — Per-coworker closeness from 0 to 100, shown as hearts. Saved across days.

**Hợp gu (taste)** — A coworker's preference for conversation tone: warm, joke, or work. Affects how they react to what the player says.

**Nhiệm vụ tài liệu (document quest)** — The afternoon favor where a coworker asks the player to fetch a named file from the cabinet. Defined in `DOC_QUESTS`.

**Sự kiện (daily event)** — One random event per day: printer jam or cake party. *(Extended in v1.1.0: separate surprises, called Bất ngờ, also happen each day.)*

**Tiệc nhỏ (cake party)** — The daily event from 15:20 to 15:55 in the pantry, organized for a coworker's birthday.

**Pantry** — The break and lunch area (top left of the office). Serves drinks in the break window and meals at lunch.

**Lời nhắn (sticky note)** — The end-of-day note the player leaves for one coworker. Limited to 50 characters.

**Tổng kết (summary)** — The end-of-day screen showing stats, moments, and notes received.

**Nhật ký (diary)** — Saved list of past days, newest first, capped at 40 entries. *(Outdated as of v1.1.0: capped at 150 entries.)*

**Khoảnh khắc (moments)** — Short highlights recorded during the day and shown in the summary and diary.

**Bong bóng thoại (speech bubble)** — Text shown above a character during conversation or small talk.

**Thẻ hội thoại (card)** — The popup panel with a character's text and choice buttons.

**Chế độ đơn giản (list mode / lite mode)** — Fallback used when WebGL is unavailable. The game shows buttons instead of the 3D scene. Defined by `LITE` and `#lite`.

**Tua nhanh (fast-forward)** — Time-speed toggle that runs the clock 4 times faster.

**Lưu dữ liệu (localStorage)** — The browser's on-device storage used for saves. Key `mot-ngay-o-cong-ty.v1`.

**Three.js** — The open-source 3D JavaScript library used for rendering. Version 0.160.0, loaded from a CDN.

**Import map** — The HTML `<script type="importmap">` that maps the name `three` to the CDN URL.

**Web Audio** — The browser API used to synthesize sound effects in code.

**Dlog (debug log)** — The project's gated logging helper. Prints only on localhost or with `?debug` in the URL.

**Chibi** — Cartoon character style with a large head and small body, used for the 3D characters.

**Bảo** — Real name of the Product coworker who appears in game as "Anh Bảo" (desk 11). Not the player. See **Anh Bảo** below. *(Outdated as of v1.3.0: desk 2, not 11.)*

**Biệt danh (nick)** — Optional nickname in a coworker's profile (`nick`), shown on the conversation card. Example: Thông, "Bamboo".

**Tên thật (real)** — Optional real name in a coworker's profile (`real`), shown on the conversation card when it differs from the in-game name. Example: the in-game name Chủ tịt, real name Thạnh.

**Chủ tịt** — In-game name of the leader Thạnh (desk 0), who hosts the 10:00 meeting. Spelled "Chủ tịt" everywhere, not "Chủ tịch" (confirmed 2026-11-04). *(Outdated as of v1.3.0: desk 1, not 0.)*

**Chức danh (job title)** — *(needs definition)*

**traits (ghi chú tính cách)** — *(needs definition)*

**Mình / bạn (peer address)** — *(needs definition)*

**tui / ông (same-age banter)** — *(needs definition)*

**Người chơi (player)** — The character you control: a new employee who types an optional name and picks a gender on the title screen. Not a coworker. Bảo is an NPC.

**Giới tính (gender choice)** — Title-screen option Nam, Nữ, or Không nêu (`khac`, default). Sets anh / chị in NPC lines.

**{ten} (placeholder)** — Placeholder in NPC lines, replaced by the player's name, or "bạn" if the name is empty. Filled by `fill()`.

**{anh} / {Anh} (placeholder)** — Placeholder in NPC lines, replaced by anh, chị, or anh/chị according to the player's gender. `{Anh}` is the capitalized form. Filled by `fill()`.

**Chú 7** — QC coworker. Real name An. *(v1.4.0: young. "Chú" is a nickname, not an age term. Loves tea and teases Chị Ba in surprise `khiatra`.)*

**Chị Ba** — Business Support coworker (product research: runs user surveys, builds reports, analyses numbers). Real name An. Asks the player for the user survey report ("Báo cáo khảo sát người dùng"). Playfully "punches" colleagues. Updated v1.6.1. Stand-up catchphrase and reply from Chú 7: see `Bực bội quá… thằng bánh tét đâu rồi!` below. Updated v1.7.1.

**Thông** — R&D coworker, nickname "Bamboo", at desk 12 (center of the lower row). Added in v1.0.2. *(Outdated as of v1.3.0: desk 9, the left end of the lower row.)*

**Tán gẫu bàn (visit)** — A short chat in three stages, started when a seated coworker walks to a colleague's desk during the visit windows (09:05–09:50, 13:35–14:45, 15:40–16:50). Ends after 3 stages or 15 seconds.

**visitAnim** — Optional profile field: the animation the visitor plays at the start of a visit. Only Chị Ba sets it (`punch`).

**Thói quen (quirk)** — A coworker's scheduled line or action around a set time (`quirks`). Fires once per day.

**Mời nước (treat)** — Thạnh's drinks event at 11:05 and snacks event at 14:10. Gives the player energy and mood, plus a diary moment. *(Extended in v1.1.0: milk-tea days add treats at 09:55 and 16:00.)* *(Name note, v1.2.0: Thạnh is shown in game as Chủ tịt.)*

**Góc nhìn (camera preset)** — One of three camera views: Gần, Vừa (default), Xa (nhìn từ trên). Defined by `CAM_PRESETS`, saved in `settings.cam`.

**🎥 (camera button)** — HUD button (`#b-cam`) that cycles the camera presets.

**Nhìn trước (look-ahead)** — The camera aims 1.3 m ahead of the player so the player sees what is coming.

**Đấm nhẹ (punch)** — Chị Ba's playful shoulder-punch animation (`punch`), used as a joke.

**khìn khìn** — Nam's recurring verbal habit. Used as-is in dialogue; not translated.

**Là sao?** — Yến's recurring catchphrase, roughly "what do you mean?". Used as-is in dialogue.

**Một Ngày Ở MinhLee** — *(needs definition)*

**MinhLee** — *(needs definition)*

**App Dating** — *(needs definition)*

**Em nói thiệt** — *(needs definition)*

**Nhân quả** — *(needs definition)*

**Hợp đồng đối tác game** — *(needs definition)*

**Chủ đề họp (meeting topic)** — *(needs definition)*

**Bộ sắp xếp dự án (sort set)** — *(needs definition)*

**Caro (gingham)** — *(needs definition)*

**Look (tạo hình nhân vật)** — *(needs definition)*

**Thế giới liên tục (endless world)** — *(needs definition)*

**Tuần (week)** — *(needs definition)*

**Thứ Hai … Thứ Sáu (weekday)** — *(needs definition)*

**Cuối tuần (weekend note)** — *(needs definition)*

**Số người dùng (user count)** — *(needs definition)*

**Bản app Dating (app version)** — *(needs definition)*

**Họp đầu tuần (Monday meeting)** — *(needs definition)*

**Sinh nhật đồng nghiệp (birthday cycle)** — *(needs definition)*

**Bạn thân (friend)** — *(needs definition)*

**Bất ngờ (surprise)** — *(needs definition)*

**Hộp quà bí ẩn (mystery gift box)** — *(needs definition)*

**Cặp đôi tán gẫu (duo)** — *(needs definition)*

**Chủ đề ngày (day theme)** — *(needs definition)*

**Ngày mưa (rainy day)** — *(needs definition)*

**Ngày trà sữa (milk-tea day)** — *(needs definition)*

**Huy hiệu cuối ngày (badge)** — *(needs definition)*

**Tin đồn văn phòng (office gossip)** — *(needs definition)*

**Bảng thông báo (notice board)** — *(needs definition)*

**recentEv** — *(needs definition)*

**lastTheme** — *(needs definition)*

**Họa tiết (pattern)** — *(needs definition)*

**Sọc ngang (stripe)** — *(needs definition)*

**Tóc mái (fringe)** — *(needs definition)*

**Ria mép (mustache)** — *(needs definition)*

**Kính gọng chữ nhật (rect glasses)** — *(needs definition)*

**patternMat(kind)** — *(needs definition)* *(v1.4.1: kinds are `gingham`, `stripe`, `plaid`.)*

**Primitive (Three.js primitive)** — *(needs definition)*

**Anh Bảo** — Display name of the Product coworker at desk 11. Real name Bảo (see the `Bảo` placeholder above). The oldest in the office, so others call him "Anh Bảo". Used in surprises, duos, gossip, and meeting text from v1.2.0. *(Outdated as of v1.3.0: desk 2, not 11.)*

**Thạnh (real name)** — Real name of the leader whose in-game name is Chủ tịt (see the `Chủ tịt` placeholder above). Shown on the conversation card and in the `real` profile field.

**Xưng hô (address terms)** — How coworkers address each other in lines. Mostly first names. The special cases are in `docs/spec/dong-nghiep.md` §2.

**Nguyên** — The remote developer, 14th entry in `NPC_PROFILES`, with no desk. Role "Developer (làm từ xa)" is tentative. Comes into the office on about 3 days in 10 and rests on the pantry daybed. Added in v1.2.0. *(Corrected 2026-11-04: role is Designer, not tentative. Comes into the office on about half of the days. No gender is recorded.)*

**Làm từ xa (remote work)** — Working from home. A coworker with `habits.attendance` below 1 is in the office only on that share of days.

**Giường nằm (daybed)** — The pantry daybed at (−7.0, −4.2), where Nguyên lies when he is in the office. An obstacle the player walks around. *(Outdated as of v1.3.0: moved to the north wall, east of the pantry, at (−4.6, −6.9).)*

**LOUNGE_SEAT** — Code constant for the daybed seat (`lie: true`). Only one coworker uses it.

**habits.lounge** — Profile flag. When `true`, the coworker's default idle goal is the daybed instead of a desk.

**habits.attendance** — Profile number from 0 to 1: the chance that the coworker comes into the office on a given day. Missing means always in.

**lie (pose)** — Character pose for lying down, used by Nguyên on the daybed.

**Kính tròn (round glasses)** — *(needs definition)*

**Tóc bob (bob)** — *(needs definition)*

**look.glassColor** — *(needs definition)*

**look.glassThick** — *(needs definition)*

**Kẻ caro đỏ-xanh (plaid)** — *(needs definition)*

**Bố cục theo sơ đồ (floor-plan layout)** — *(needs definition)*

**so-do-van-phong-2.svg** — *(needs definition)*

**planX / planZ** — *(needs definition)*

**DOOR / DOOR_GAP** — *(needs definition)*

**Lối đi (walkway)** — *(needs definition)*

**Bàn dài (long table)** — *(needs definition)*

**LONG_TABLES** — *(needs definition)*

**DESKS** — *(needs definition)*

**Bàn riêng hàng dưới (lower row)** — *(needs definition)*

**PLAYER_DESK / Bàn của bạn (player desk)** — *(needs definition)*

**COLUMNS / Cột (column)** — *(needs definition)*

**Phòng họp (meeting room)** — *(needs definition)*

**MEET_ROOM / MEET_TABLE / MEET_SEATS** — *(needs definition)*

**Cửa ra vào (front door)** — *(needs definition)*

**PANTRY_SPOTS** — *(needs definition)*

**SOFA_SEATS / Ghế sofa** — *(needs definition)*

**PRINTER_SPOT / Máy in (printer spot)** — *(needs definition)*

**Tủ tài liệu (filing cabinet)** — *(needs definition)*

**Vật cản (obstacle, addObst)** — *(needs definition)*

**buildOffice() / buildSpots()** — *(needs definition)*

**Offset sinh nhật (birthday offset)** — *(needs definition)*

**Nhậu** — Vietnamese for going out for a drink after work. In the game, Tùng often invites people to one, kept light and friendly. Added v1.4.0. *(Tone pending the user's check, see `docs/tasks.md`.)*

**Thử thách (dare)** — A playful challenge from a coworker. Example: Tùng's "MinhLee" ten-times tongue-twister (surprise `tungthach`, request in `NPC_PROFILES`). Added v1.4.0. *(needs definition)*

**Khịa (teasing)** — Playful teasing between coworkers, such as Chú 7 teasing Chị Ba (surprise `khiatra`). Added v1.4.0. *(needs definition)*

**Trà ô long (oolong tea)** — A tea that Chú 7 loves to brew and share. Added v1.4.0. *(needs definition)*

**Trà sen (lotus tea)** — A tea Chú 7 and Chị Ba debate over ô long. Added v1.4.0. *(needs definition)*

**Quán ngon (good-food tip)** — A restaurant, drink shop, or dish that Thảo recommends. Thảo is known as the office foodie. Added v1.4.0. *(needs definition)*

**Thảo (Bella)** — HR coworker at desk 11, nickname "Bella". Known as the office foodie: chats, greetings, and requests are about food. Brings the birthday cake. Added v1.4.0 personality. *(Definition is factual; curation pending.)*

**Nhân Quả (cat name)** — The name of Chủ tịt's cat, in the cat lines and the surprises `cat` and `thanhmeo`. Added v1.4.2. *(needs definition)*

**Tùng** — Mobile Dev coworker at desk 8. Often invites people out for a light after-work drink and loves dares. Added v1.4.0 personality. *(Definition is factual; curation pending.)*

**Mèo bông (cat plush)** — Stuffed cat on Chủ tịt's desk (seat index 1 in `buildOffice()`). Added v1.4.2. *(needs definition)*

**Chú mèo lạc (stray cat)** — Surprise `cat`: a stray tabby cat walks into the office. Chủ tịt is the related coworker. Added v1.4.2. *(needs definition)*

**Ảnh mèo của Chủ tịt (cat photos)** — Surprise `thanhmeo` and the 12:50 quirk: Chủ tịt shows photos of his cat. Added v1.4.2. *(needs definition)*

**Xưng hô khiêm nhường (humble address)** — Chủ tịt's speech style: he calls himself "em" and most people "anh" / "chị", including in group talk. Normal "anh" / "em" is kept with younger coworkers and Chị Ba. Added v1.4.3. See `docs/spec/dong-nghiep.md` §2. *(needs definition)*

**Đồng nghiệp nhỏ tuổi (younger coworker)** — Coworker for whom Chủ tịt keeps normal "anh" / "em". Hiện is stated as the youngest. Chú 7, Trung, and Nguyên are assumed. Added v1.4.3. *(needs definition)*

**Bản offline (offline build)** — `index-offline.html`: the game with Three.js inlined, so it runs with no network. Generated by `tools/build-offline.py`. Added v1.5.0. See `docs/spec/phan-phoi-offline.md`. *(needs definition)*

**Inline (nhúng sẵn)** — Putting the Three.js library source inside the HTML file instead of loading it from the CDN. Used by `index-offline.html`. Added v1.5.0. *(needs definition)*

**data: URL** — A URL that carries its content inside the address (here, base64-encoded JavaScript). The offline build's importmap uses one for `three`. Added v1.5.0. *(needs definition)*

**build-offline.py** — The generator script in `tools/` that writes `index-offline.html` from `index.html`. Run it after every edit to `index.html`. Added v1.5.0. *(needs definition)*

**tools/three.module.min.js** — Cached copy of the Three.js 0.160.0 library, downloaded by the build script on first run. Added v1.5.0. *(needs definition)*

**Ngữ cảnh (ctx)** — Optional field on a quirk. The activity the coworker must be doing for the quirk to speak. Values: `desk` (default: seated and working at a desk), `eat` (seated, eating at a desk), `lounge` (seated on the pantry daybed), `any` (not moving). Read by `ctxOk()`. Added v1.4.4. *(needs definition)*

**Thẻ thời gian (time tag)** — Prefix on a line in a `say` array: `@am ` (before 11:00), `@noon ` (11:00 to 13:29), `@pm ` (13:30 onward). The tag is removed and the line is used only in its window. Added v1.4.4. *(needs definition)*

**pickSay()** — Function that picks one line from a `say` pool and applies time-tag filtering. Section 1 of `index.html`. Added v1.4.4. *(needs definition)*

**lineFor()** — Function that picks a coworker's line from the situation: pantry lines at the pantry, "Đang họp" in the meeting, otherwise greet or idle lines. Section 9 of `index.html`. Added v1.4.4. *(needs definition)*

**Đang họp (meeting line)** — The line "Đang họp, lát nói chuyện nhé." (I'm in a meeting, let's talk later), said by a coworker who is in the meeting. Added v1.4.4. *(needs definition)*

**Neo đầu (head anchor)** — The point above a coworker's head where a speech bubble is placed. Height from `npcHead()`: standing 1.85 m, seated 1.8 m, lying 1.0 m. Added v1.4.4. *(needs definition)* *(Outdated as of v1.8.4: a lying coworker uses the lying anchor, see `docs/spec/dong-nghiep.md` §7.1. The 1.0 m value was never used by the code.)*

**Bubbles.onScreen()** — Check that a point is in front of the camera and in the view below the top bar (112 px) and above the bottom margin (50 px). Gates ambient bubbles. Added v1.4.4. *(needs definition)* *(Since v1.8.4 the ambient gate in `tryNpcSay()` tests the bubble anchor `npcAnchor()`, so a lying coworker is tested at the lying anchor.)*

**Ứng dụng macOS (macOS app)** — `dist/MinhLee.app`: the offline game in its own Mac window, built by `tools/build-mac-app.sh`. Added v1.6.0. See `docs/spec/phan-phoi-offline.md` §8. *(needs definition)*

**WKWebView** — Apple's built-in web view, which the macOS app uses to show the game. Used in `tools/macapp/main.swift`. Added v1.6.0. *(needs definition)*

**Universal binary (tệp universal)** — One executable that holds both Apple Silicon (arm64) and Intel (x86_64) code. `dist/MinhLee.app` uses one. Added v1.6.0. *(needs definition)*

**lipo** — Apple's command-line tool that joins per-architecture binaries into one universal binary. Used by `tools/build-mac-app.sh`. Added v1.6.0. *(needs definition)*

**Ký ad-hoc (ad-hoc signing)** — Signing an app without an Apple developer identity. The app runs on the Mac that built it, but other Macs show a Gatekeeper warning. Added v1.6.0. *(needs definition)*

**Gatekeeper** — macOS check that warns before opening apps that are not signed by a known developer or notarized. Added v1.6.0. *(needs definition)*

**Công chứng (notarization)** — Apple's automated check of a signed app. Not done for MinhLee. Added v1.6.0. *(needs definition)*

**Thuộc tính cách ly (quarantine attribute, `com.apple.quarantine`)** — macOS flag set on downloaded files. `xattr -dr com.apple.quarantine` removes it and skips the first-open warning. Described in `docs/deploy.md` option 4. Added v1.6.0. *(needs definition)*

**Bundle ID** — The macOS app's identifier, `com.minhlee.mot-ngay-o-cong-ty`, set in `tools/macapp/Info.plist`. Added v1.6.0. *(needs definition)*

**--selftest** — Launch flag for the macOS app. Loads the game, clicks the start button, prints `PHASE1` and `PHASE2` JSON, and exits. Added v1.6.0. *(needs definition)*

**dist/ and dist/.build** — The build output folder. `dist/.build/` holds intermediate binaries and is not for sharing. Added v1.6.0. *(needs definition)*

**"Có chút trục trặc"** — The alert title the macOS app shows when the game cannot load. The app then quits. Added v1.6.0. *(needs definition)*

**Business Support (job title)** — Chị Ba's job title in the game. In the game it means product-research support (user surveys, reports, number analysis), not accounts or paperwork. Added v1.6.1. *(needs definition)*

**Báo cáo khảo sát người dùng (user survey report)** — The document Chị Ba asks the player to fetch in the afternoon quest (`DOC_QUESTS`, `DOC_NAMES`). Added v1.6.1. *(needs definition)*

**Khảo sát người dùng (user survey)** — Product research in the game. Chị Ba runs surveys and reports on them. The survey report in her desk request has 40 respondents. Added v1.6.1. *(needs definition)*

**Nghiên cứu người dùng (user research)** — Sort-game project in `SORT_SETS` set 2, with notes "Tổng hợp kết quả khảo sát" and "Vẽ biểu đồ phản hồi người dùng". Added v1.6.1. *(needs definition)*

**Trình duyệt trong ứng dụng (in-app browser)** — A web view inside a chat or social app (Zalo, Messenger, Facebook, Instagram, TikTok, Line, WeChat, Snapchat). 3D often does not show there. Detected by a user-agent check (`window.__env.inApp`). Added v1.7.0. *(needs definition)*

**Mở bằng trình duyệt (open in browser)** — The menu choice inside a chat app that opens the link in Chrome or Safari. Named in the in-app banner. Added v1.7.0. *(needs definition)*

**Module script (`type="module"`)** — The ES module script that holds the game code. Browsers without module support cannot run it. Added v1.7.0. *(needs definition)*

**HTMLScriptElement.supports** — Browser function used by the environment check to ask whether import maps are supported (`'importmap'`). Added v1.7.0. *(needs definition)*

**Kiểm tra môi trường (env check, `window.__env`)** — The classic script in `<head>` of `index.html` that runs before the module. It sets `noMap` and `inApp`, and shows the too-old or in-app message. Added v1.7.0. *(needs definition)*

**WebGL** — The browser graphics API the 3D scene uses. Can be unavailable or disabled by policy. Added v1.7.0. *(needs definition)*

**Khử răng cưa (antialias)** — Smoothing of jagged edges. The renderer is created with antialias on first, then off if creation fails. Added v1.7.0. *(needs definition)*

**Mất ngữ cảnh WebGL (WebGL context lost)** — The browser drops the graphics context, for example after a GPU reset. The game waits 4 s for `webglcontextrestored`, then switches to list mode. Added v1.7.0. *(needs definition)*

**Bộ giám sát khung hình (render watchdog)** — Check on the 150th counted frame: if the renderer made 0 draw calls, the game switches to list mode. Runs once. Added v1.7.0. *(needs definition)*

**Lệnh vẽ (draw call)** — One request from the renderer to the graphics card to draw something. Zero draw calls on a frame means nothing was drawn. Added v1.7.0. *(needs definition)*

**fallbackToLite(why) / LITE_WHY** — Function that switches the running game to list mode, and the variable that records why (`'user'`, `'webgl'`, `'render'`, `'lost'`). Added v1.7.0. *(needs definition)*

**settings.lite / `?lite`** — Saved setting (`settings.lite` in the save) and URL parameter that force list mode at load. The title-screen button writes the setting. Added v1.7.0. *(needs definition)*

**Nút "Không thấy hình? Dùng chế độ đơn giản" / "Thử lại chế độ 3D" (`#btn-lite`)** — Title-screen button that switches between 3D and list mode. Its label depends on why the game is in list mode. Added v1.7.0. *(needs definition)*

**`#env-note`, `#boot-error`** — Title-screen message box for environment and WebGL notes, and the boot-error box shown if the game has not started after 10 s. Added v1.7.0. *(needs definition)*

**Bản classic (classic bundle, non-module build)** — A possible build without module or import-map syntax, for browsers older than the minimums. Not built. Added v1.7.0. *(needs definition)*

**bánh tét** — Chị Ba's teasing nickname for Chú 7 (An). Used in her stand-up line and in one of Chú 7's chat lines. Added v1.7.1. *(needs definition)*

**Bực bội quá… thằng bánh tét đâu rồi!** — Chị Ba's stand-up catchphrase (`say.stand`, 3 variants). Shown when she gets up from her seat, on about 55% of stand-ups (about 90% on a `busy` day), at most once per 60 s. Chú 7 answers with "Dạ có em đây chị Ba! (nép sau ly trà)" about 1.8 s later (`say.standReply`). Added v1.7.1. *(needs definition)*

**say.stand** — Optional profile array of stand-up lines. A line is picked when the coworker is sent from a seat to a new goal (`standUpLine()`, called by `setGoal()`). Generic: any coworker may use it. Used by Chị Ba. Added v1.7.1. *(needs definition)*

**say.standReply** — Optional profile field `{ id, line }`. Coworker `id` says `line` 1.8 s after a stand-up line. Used by Chị Ba to call Chú 7. Added v1.7.1. *(needs definition)*

**say.absent** — Optional profile field `{ who, lines }`. A seated coworker says one of `lines` while coworker `who` has not arrived yet (for `thanh`, before 09:20). Stops when `who` arrives. Generic: any coworker may use it. Used by Nam. Added v1.7.1. *(needs definition)*

**Ngày chạy nước rút (busy day)** — Day theme `busy`: the App Dating update is near release and the office is busy. Chị Ba's stand-up line fires more often on this theme (about 90% against 55%). Added v1.7.1. *(needs definition)*

**bé Hạnh** — Nam's playful teasing nickname for Chủ tịt (Thạnh), a joke between colleagues. Used in Nam's `say.absent` lines (he misses Thạnh while Thạnh is late), Nam's idle and chat lines, the playful `nam`–`thanh` duo, and Thạnh's chat line in which he says the nickname is familiar by now. Meaning confirmed by the product owner on 2026-11-04. Added v1.8.1. Wording to be curated by a human.

**Thẻ mục tiêu (goal card, `#hud-obj`)** — *(needs definition)*

**Bảng nhiệm vụ (mission board, `missionBoard()`)** — *(needs definition)*

**Việc cần làm bây giờ (current goal)** — *(needs definition)*

**Việc nhỏ hôm nay (side tasks, `extraTasks()`)** — *(needs definition)*

**Trạng thái mốc (milestone status)** — *(needs definition)*

**Đã qua (passed milestone, ⏭)** — *(needs definition)*

**Bảng tên (name tag)** — *(needs definition)* The floating label with a coworker's name, placed by `Bubbles.makeTag()` in `createNpcs()`. Added v1.8.4.

**Neo nằm (lying anchor)** — *(needs definition)* The tag and bubble position for a lying coworker, from `npcAnchor()`: 0.6 m (tag) and 1.05 m (bubble) toward the head, on the body. Added v1.8.4. See `docs/spec/dong-nghiep.md` §7.1.

**isLying()** — *(needs definition)* True when a coworker's `goal.anim` is `'lie'` and `state` is `'seated'` or `'seatIn'` (Nguyên on the daybed). Section 9 of `index.html`, next to `createNpcs()`. Added v1.8.4.

**Hướng đầu (head direction)** — *(needs definition)* The direction a lying coworker's head points, `-(sin yaw, cos yaw)`, used to place the lying anchors. Added v1.8.4.

**Nhiều kịch bản cho một cặp (multi-script pair)** — *(needs definition)* A pair in `DUOS` may have several scripts. One is picked at random for each visit (`runVisit()`). Nam and Chủ tịt (Thạnh) is the only pair with two. Added v1.8.2. See `docs/spec/noi-dung-bat-ngo.md` §2.

**Custom look (ngoại hình tùy chỉnh)** — *(needs definition)* A coworker `look` set by hand in `NPC_PROFILES` (colours, hair style, glasses, shirt) rather than left at the defaults. Used for the primitive-built stylized characters. Added v1.8.5. See `docs/spec/mot-ngay-o-cong-ty.md` §4.4.

**Ảnh tham chiếu (reference photo)** — *(needs definition)* A photo the user supplies to base a character's look on. Used for Nguyên's look (v1.8.5). The photo is not embedded in the game. Added v1.8.5. See `docs/spec/mot-ngay-o-cong-ty.md` §4.4.
**npcAnchor()** — *(needs definition)* The function that returns the anchor point for a coworker's name tag (`forTag` true) or speech bubble (`forTag` false): standing or seated height above the root, or the lying anchor when `isLying()` is true. Defined next to `createNpcs()` in `index.html`. Added v1.8.4. See `docs/spec/dong-nghiep.md` §7.1.


**D.work (desk task state)** — *(needs definition)* The day's current desk task, kept in the day state `D` (`newWork()`, `workActivity()`, `startMiniGame()`). Fields: `kind` (`sort` or `order`), `set` (index into `SORT_SETS` or `ORDER_SETS`), `from` (requester id), `order` (shuffled item indexes), `done`, `next`, `elapsed`, `wrong`. Kept when the player pauses the task. Set to `null` when the task is finished, and reset by `newDayState()` at a new day. Added v1.8.6. See `docs/spec/mot-ngay-o-cong-ty.md` §4.2 and AC-72.

**Đầu việc (desk task item)** — *(needs definition)* One small job at the player's desk, numbered "Đầu việc nhỏ số N/3" on the work card. Up to `CFG.MAX_TASKS` (3) per day. Two kinds: sort notes into project groups (`sort`), or put items in deadline order (`order`). Takes about 30–60 seconds, with no score and no penalty. Added v1.8.6.

**Người nhờ (requester)** — *(needs definition)* The coworker who asks the player for a desk task, stored as `from` in `SORT_SETS` and `ORDER_SETS`: `bao` (Anh Bảo) or `an3` (Chị Ba). The work card shows them with the role "Đang nhờ bạn". On completion they gain +3 affinity and send a reply card. Added v1.8.6.

**Nhãn Bàn của bạn (desk label, `deskTag`)** — *(needs definition)* The yellow "💻 Bàn của bạn" label above the player's desk, built with `Bubbles.makeTag()` in `init()`. Its horizontal position is clamped to the screen edges to show the direction of the desk. Hidden in list mode, while sitting, after the three daily tasks, and when away from the desk. Added v1.8.6.
