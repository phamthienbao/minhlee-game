# Changelog

All notable changes to "Một Ngày Ở MinhLee" (formerly "Một Ngày Ở Công Ty", renamed in v1.0.3). Newest first. Entries are appended, never rewritten.

## v1.10.0 — 2026-11-04

Mid-day save and resume: closing the tab during a workday no longer restarts that day. A welcome-back popup opens on boot when saved data exists, with continue, new game, and a confirmed reset. Anh Bảo's white lower hem is removed, and he gets a black polo collar, white cuffs, short sleeves, a men's swept haircut, and a red-and-white striped shirt (set by the user's explicit request, so the solid polo of the first brief is not used). Nguyên sleeps much less: one short nap after lunch, otherwise he works from a pantry sofa, and from the sofa he can now visit Chị Thảo, so his two duo scripts play. Trung now sometimes visits Nguyên (sofa or daybed) to talk about the design, with two new `trung`→`nguyen` scripts. Save key `mot-ngay-o-cong-ty.v1` and its existing fields are unchanged. The new `session` field is added beside them, with no migration needed.

Also in this release: Hiện no longer wears glasses (`glasses: false`), as the user stated (earlier looks had given him round glasses).

### Added

- Mid-day save, `index.html` section 14, `saveSession()`: writes a snapshot to `Store.session` (`v: 1`) every 5 s of play, on `visibilitychange` (tab hidden), and on `pagehide`. The snapshot holds: `day`, `minute`, `tasks`, `energy`, `mood`, `sets`, `moments`, `flags`, `quest`, `stats`, `work` (desk task), `meetTopic`, the day theme id, `surprises` (`t`, `id`, `fired`), `noteLeft`, `aff`, player position and yaw, `EVENT` (cake, printer), and per-NPC `times`, `attends`, `meetSeat`, `joinsCake`.
- Title screen, `#btn-resume` (`index.html` line 191): "▶ Tiếp tục ngày đang dở (hh:mm)", shown when `validSession()` finds a session for the current day number. Its click handler calls `resumeSession()`, which rebuilds the scene through `startDay()`, overwrites `D`, `EVENT`, and NPC state from the snapshot, then calls `snapNpcsToSchedule`. If restoring throws, `resumeSession()` logs with `dlog` and clears the session, and the player starts a new day.
- Nguyên's nap window: `times.nap`, one window of 30–50 min starting 55–80 min after his lunch start (`ls + 55 + rand(0, 25)`). Set in `resetNpcDay()`, read in `decideGoal()`.
- Nguyên's pantry line "Chị Thảo ơi, nay có ai mời nước không?" (`say.pantry`), a 10:35 quirk on the same line (`wave`), and two `DUOS` entries `nguyen`→`thao` (`DUOS` had 21 scripts, 18 pairs at this point; 23 scripts, 19 pairs after the Trung entry below). The two duo scripts play through the sofa-visit rule under Changed.
- Trung visits Nguyên (`npcAmbient()` and `decideGoal()`, section 9):
  - Trigger: Trung is seated at `desk:work` in a visit window and not already visiting. Each visit attempt then has a 40% chance (`Math.random() < 0.4`) to add Nguyên to the partner candidates, if Nguyên is seated on a sofa seat or the daybed (goal id `sofa*` or `lounge*`), not frozen, and not visiting.
  - Preference: when a `trung`↔`nguyen` duo exists, Nguyên is pushed into the duo pool (`duoC`) explicitly, so he is preferred like other duo partners. He is pushed twice (once by the `filter`, once explicitly), so he has double weight in that pool.
  - Partners without a desk: `decideGoal()`'s visit branch now handles a partner with `p.desk == null`. The visitor stands at the partner's seat approach point (`seat.ax` / `seat.az`, facing the seat), or at `LOUNGE_SEAT` if the partner's goal has no seat.
  - Scripts (`DUOS`, two new entries):
    - Trung asks Nguyên to change the design a bit, because it is too hard to build ("Nguyên ơi, đổi design lại chút đi, cái này khó quá."). Nguyên answers sleepily that he will think about it after lying down ("Để mình nằm nghĩ rồi tính. (ngáp)").
    - Second script: Trung says the button is pretty but took three days of code; Nguyên says he drew it in half an hour.
  - Verification: headless Chrome only, 1 of 6 short runs. Trung reached Nguyên's approach point and the duo was picked (consistent with 40%). Not tested over a full day. Wording not native-reviewed.
- Welcome-back popup, `index.html` section 14, `showWelcomeBack()`, called from `init()` after boot. It opens only when `Store.days > 0` or `validSession()` is set (first-time players see the name screen directly):
  - Title: "Chào mừng <tên> quay lại!" (or "Chào mừng bạn quay lại!" when the name is empty).
  - Body: with a session, "Ngày làm thứ N đang dở lúc hh:mm. Bạn có thể làm tiếp đúng chỗ đã dừng."; without one, "Bạn đã làm ở MinhLee N ngày. Ngày mới đang chờ bạn."
  - "▶ Tiếp tục ngày đang dở" (with a session, `resumeSession()`, falling back to `startDay()`) or "▶ Tiếp tục chơi" (without one, `startDay()`).
  - "🆕 Chơi mới" opens a confirmation, "Chơi mới?". "🗑 Xóa hết và chơi mới" calls `Store.clear()`, clears `AFF`, refreshes the title, and shows a toast. "Thôi, quay lại" returns to the popup.
  - The title-screen buttons `#btn-resume` and `#btn-start` are unchanged.

### Changed

- Session lifecycle: `Store.session` is cleared at end of day (`session: null` in the `endDay` patch), on `exitToTitle`, and when the player chooses to start the day again. Save key and other fields are unchanged.
- Title screen: when a valid session exists, the start button reads "🔄 Bắt đầu lại ngày này" and discards the session (`refreshTitle()`). Without a session it keeps its old labels.
- Anh Bảo's look (`NPC_PROFILES` `bao`, `index.html` line 481, section 2):
  - Removed the white lower-half hem (it read as a skirt). `look.hem` still exists in `buildCharacter()` but no profile uses it now.
  - Shirt: `shirt: 0xd6322f`, `pattern: 'redwhite'`. `patternMat('redwhite')` draws full-width horizontal red bands (8 px on a 16 px pitch) on off-white, and the pattern overrides `shirt`. The red-and-white shirt is the user's explicit request for this release. The solid polo of the first brief (`0x1f2f5f`) is not used. This closes the earlier colour mismatch.
  - Collar: `neck: 'collar'`, `collarStyle: 'polo'`, `collar: 0x1a1a1c` (black neck band, V flaps, and back band, drawn in `buildCharacter()`).
  - Sleeves: `cuff: 0xf4f1ea` (white sleeve cuffs), `shortSleeve` (bare forearms).
  - Glasses: `glasses: 'rect'`, `glassColor: 0xb9bfc4` (thin silver rectangles).
  - Hair: `hairStyle: 'swept'` (new style, men's short hair, drawn in `detailHair()`). Replaces `style: 'fringe'`, which read as feminine.
- Nguyên's routine (section 9): he no longer lies down for most of the day.
  - Within the nap window he lies on the pantry daybed (`decideGoal()` calls `goalLounge()`).
  - Otherwise `goalSofa()` gives him a free pantry sofa seat (`SOFA_SEATS`, `sofaOwner`), where he works on his laptop (`anim: 'type'`).
  - He lies down only if all sofa seats are taken (`goalSofa()` falls back to `goalLounge()`).
  - Measured in 30 simulated days, 10:30–16:50: lying about 10% of checked time, sofa work about 71%, other (lunch, coffee, visits) about 19%.
- Nguyên's visits (`npcAmbient()`, section 9): a seated coworker with `habits.lounge` (Nguyên) on a sofa seat (goal `sofa:N`) may start a visit. This is the `sofaWorker` check. Such a visit goes only to Chị Thảo (`x.id === 'thao'`), and Chị Thảo must be seated at `desk:work`. He never visits from the daybed. The rule for everyone else is unchanged. Trung is the one exception: he visits Nguyên, who has no desk (see Added, Trung visits Nguyên).
- Arrival toast in `processTimeEvents()` (`index.html` line 2390): "😴 Nguyên hiếm hoi lên công ty hôm nay, đang ở pantry!" (was "đang nằm ở pantry", which no longer matched his routine).

### Fixed

- Closing the tab, or reloading, in the middle of a day restarted the day from 08:30. Only the end-of-day summary was saved. Now the day resumes from the last snapshot (at most 5 s of play is lost).
- The two `nguyen`→`thao` duo scripts (`DUOS`) never played, because a visit could not start from Nguyên. Fixed by the sofa-visit rule under Changed.

### Build and artifacts

- The v1.10.0 code is present in `index.html`, `index-offline.html`, `dist/netlify/index.html`, and `dist/MinhLee.app/Contents/Resources/index.html` (grep: `btn-resume`, `validSession`, `swept`). Full byte diff between the copies not recorded in this doc pass.
- `tools/macapp/Info.plist` still reads `CFBundleShortVersionString` 1.8.5. `dist/MinhLee-mac.zip` not rebuilt in this pass (open follow-up).
- `CLAUDE.md` and `index.html` were not edited in the doc pass.

### Verification

- Headless Chrome: snapshot fields restored (minute, tasks, talked, energy, work progress, position, affinity, theme, NPC times, surprises). Resume button visibility and session clearing checked.
- Headless Chrome, welcome-back popup: popup title and buttons checked. "▶ Tiếp tục ngày đang dở" resumed at 13:10 with 1 task. "Thôi, quay lại" kept the data. "🗑 Xóa hết và chơi mới" cleared to 0 days.
- Headless Chrome, Nguyên's visits: in 6 of 6 runs he visited Chị Thảo and a `nguyen`→`thao` duo script was picked.
- Not tested across a real browser restart, a real device, or Safari/Firefox.
- Nap share (lying 10%, sofa 71%) measured by simulation, not in a real browser.
- Wording of the Nguyên lines: not reviewed by a native speaker. Anh Bảo's look was not checked by eye against the photo in this doc pass.

### Docs

- `docs/spec/the-gioi-lien-tuc.md` (§4, §11 save and resume, §11.2 lifecycle, §11.5 welcome-back popup), `docs/spec/mot-ngay-o-cong-ty.md` (status, §2, §4.2, §4.4, §5 data model, AC-81 to AC-84), `docs/spec/dong-nghiep.md` (status, §1, §3 routine, visits, and canon, §8 Anh Bảo row, AC-49), `docs/spec/noi-dung-bat-ngo.md` (status, §2 duo note and table, AC-41), `docs/product-guide.md` (saving: welcome-back popup), `docs/glossary.md` (`session`, `nap`, `showWelcomeBack()`, `look.collarStyle`, `look.cuff` note, `pattern: 'redwhite'`), `docs/tasks.md` (known defects closed, follow-ups).
- `docs/tasks.md`: v1.9.1 to v1.9.4 done entries moved to `docs/archive/tasks-done-2026-11.md`.

## v1.9.5 — 2026-11-04

Anh Bảo's look re-matched to the user's reference photo. Canon fix: Chị Ba is not allergic to cats. Her cat is a golden cat named Nghệ, and she and Chủ tịt tease each other about whose cat is better. Look data, `buildCharacter()` options, and text only. No change to logic, schedule, save format, or save key.

### Added

- `index.html`, `buildCharacter()`: two opt-in look fields for two-tone shirts:
  - `look.hem` (colour): a cylinder band (0.25 m tall, at y 0.425) around the lower body, in its own colour, so the lower half of the top differs from the upper half.
  - `look.cuff` (colour): a 0.03 m band on each arm, at y −0.175, in its own colour (sleeve-end cuffs).
- `NPC_PROFILES` (`index.html`, section 2), Chị Ba (`an3`) `say.chat`: "Mèo vàng nhà chị tên Nghệ, ngoan hơn mấy đứa trong phòng này nhiều. Anh Thạnh nói gì thì nói, mèo chị đẹp hơn."
- `DUOS` (`index.html`, section 2): two cat-banter scripts for the same pair, one each way:
  - `an3` → `thanh`: Chị Ba asks whether Thạnh's cat can open the fridge; Thạnh says his cat meditates; Chị Ba says the cat is only lazy.
  - `thanh` → `an3`: Thạnh says Chị Ba's cat is a little chubby; Chị Ba says plump means lucky.
  - `DUOS` now has 19 entries for 17 pairs (was 17 entries for 16 pairs). The pick is per visit (`runVisit()`, both directions match).

### Changed

- `NPC_PROFILES` look for Anh Bảo (`bao`), matched to his photo by eye:
  - Navy colour-block polo: `shirt: 0x1f2f5f` (navy top), `hem: 0xf0f0f0` (white lower half), `cuff: 0xf0f0f0` (white sleeve cuffs), `shortSleeve: true`.
  - Navy collar: `neck: 'collar'`, `collar: 0x1f2f5f`. The yellow collar (`0xd4ac4d`) and `hairStyle: 'side'` are removed.
  - Hair: `style: 'fringe'` (no `hairStyle`), `hair: 0x1a1410` (black), fringe swept over the forehead.
  - Glasses: `glasses: 'rect'`, `glassColor: 0xb9bfc4` (thin light-silver rectangles).
  - `skin: 0xe6c09c` (slightly tanned), `smile: true` (slight closed smile), `detail: true`.
- `DAY_THEMES` `cat` intro `th-cat` (`index.html`, section 3 block), text and options:
  - Intro: Chị Ba's allergy lines are removed. She now says her golden cat is prettier ("Mèo vàng nhà chị đẹp gấp mười.").
  - Option 2 is now "Hỏi Chị Ba cho xem ảnh mèo vàng nhà chị". Chị Ba shows her photos, and Chủ tịt cuts in with his own. Effects as they stand in the code: mood +7, `aff` `an3` +4, `thanh` +1 (the spec table had `thanh` −1 and an older label; corrected in `noi-dung-bat-ngo.md` §3.2).
  - Option 3 result: Chị Ba posts a photo of her golden cat to the group chat, and Chủ tịt reacts with three cat photos.
- Canon: Chị Ba is not allergic to cats. The cat lines of Chị Ba and Chủ tịt (cat Nhân Quả) now tease each other about whose cat is better, mock-gruff and friendly.

### Fixed

- Cat canon contradiction: the `th-cat` intro had Chị Ba allergic to cats. Removed. Her cat is now Nghệ.
- The player's allergy option in surprise `thanhmeo` ("Em hơi dị ứng lông mèo") is not changed. It is the player's own line, not Chị Ba's.

### Build and artifacts

- `index-offline.html`, `dist/netlify/index.html`, and `dist/MinhLee.app/Contents/Resources/index.html` each contain the v1.9.5 Bảo look (`hem: 0xf0f0f0`) and the Nghệ line (grep check in the doc pass). `index.html` differs from them only by the importmap line and the offline comment line.
- `dist/MinhLee-mac.zip` was not rebuilt in this pass.

### Verification

- JavaScript syntax check on `index.html`. Headless render of Anh Bảo, viewed by eye.
- Anh Bảo was compared with the reference photo by eye only, not measured. Not checked on a real device or in any other browser.
- Wording of the cat banter, the `th-cat` intro, and the options is not reviewed by a native speaker.

### Docs

- `docs/spec/dong-nghiep.md` (status, roster rows for Chủ tịt, Chị Ba, Anh Bảo; §2 cat canon row; §7.6 teasing; §8 Anh Bảo row and heading), `docs/spec/noi-dung-bat-ngo.md` (§2 duo table and count; §3.2 `th-cat` rows, corrected to match the code), `docs/glossary.md` (`look.hem`, `look.cuff`, `Nghệ`), `docs/tasks.md` (Done entry, follow-ups), `docs/product-guide.md` (Chị Ba row).
- `CLAUDE.md` and `index.html` not changed in this pass.

## v1.9.4 — 2026-11-04

`look.detail` (detailed eyes, brows, smile, neck ring or collar, and hair style) is now enabled for the remaining nine coworkers. All 14 coworkers use it. Look data only. No change to logic, schedule, text, save format, or save key.

### Changed

- `NPC_PROFILES` looks (`index.html`, section 2), `look.detail: true` added to nine coworkers, with the existing look data and colours kept where they were set:
  - Trung: reverted to his original face (no `look.detail`) at the user's request, since it looked closer to him; original look kept: striped shirt, rect glasses, mustache.
  - Toàn: `hairStyle: 'side'`, `neck: 'collar'`, navy collar (`collar: 0x1f2a5c`). This closes the "no polo collar" gap in `docs/tasks.md`. Mustache, no glasses, `round` face.
  - Hiện: `hairStyle: 'quiff'`, round glasses (`glasses: true`), `neck: 'crew'` with purple `neckColor: 0x654a8c`, smile.
  - Tùng: `neck: 'crew'` with pale lilac `neckColor: 0xd9d4e6`, fringe (`style: 'fringe'`), smile.
  - Nam: `neck: 'collar'`, `collar: 'pat:plaid'`, smile, `teeth: true`.
  - Chú 7: `hairStyle: 'tousled'`, `neck: 'crew'` with cream `neckColor: 0xdedbd0`, smile.
  - Chị Ba: bob kept (`style: 'bob'`), `lashes`, `lip: 0xb8525a` (muted), `earring: 0xd0d0d0` (silver), `neck: 'crew'` with dark grey `neckColor: 0x2c2c30`, thick round glasses, `browUp` set, no smile.
  - Anh Bảo: `hairStyle: 'side'`, `neck: 'collar'`, yellow `collar: 0xd4ac4d`, smile.
  - Nguyên: `neck: 'crew'` with black `neckColor: 0x2a2a2d`, detailed eyes and brows, no glasses.
- Thảo, Yến, Thông, Chủ tịt, and Phú were already on `look.detail` and are unchanged in this release.

### Verification

- Headless Chrome: a lineup render was taken and viewed by eye.
- Not checked against the reference photos in this pass. Likeness is unverified for the nine coworkers above.
- Not run on a real device or in any other browser.

### Build and artifacts

- `index-offline.html`, `dist/netlify/index.html`, and `dist/MinhLee.app/Contents/Resources/index.html` are byte-identical to each other, and each holds the same 14 `look: {` lines as `index.html` (grep and diff check). `index.html` differs from them only by the importmap line and the offline comment line.
- `dist/MinhLee-mac.zip` was not rebuilt in this pass. `CFBundleShortVersionString` still reads 1.8.5 (see `docs/tasks.md`).

### Docs

- `docs/spec/dong-nghiep.md` (status, §8 table now lists all 14 coworkers, §6 resolved items collapsed to one line, §3 and §2 rows merged, Toàn's duplicate row removed), `docs/tasks.md` (Done entry, polo-collar gap closed, follow-ups for the likeness and real-device checks).
- `CLAUDE.md` and `docs/glossary.md` not changed in this pass.

## v1.9.3 — 2026-11-04

Looks for Yến, Thạnh, and Phú re-matched to the user's reference photos. Look data only, plus two small rendering options in `buildCharacter()`. No change to logic, schedule, text, save format, or save key.

### Added

- `index.html`, `detailFace(look, mk, head)`: `look.teeth` adds a white tooth strip under the smile (opt-in, used with `look.detail`).
- `index.html`, `detailHair(look, mk, head)`:
  - `look.part: 'center'` (used with `hairStyle: 'sleek'`) draws a centre parting with two side panels instead of the side fringe.
  - `hairStyle: 'quiff'`: short hair, a slight lift at the front, short sides.
- `index.html`, `buildCharacter()`: `look.shortSleeve: true` adds skin-coloured forearms below the shirt sleeves (short-sleeve shirts).

### Changed

- `NPC_PROFILES` looks (`index.html`, section 2):
  - Yến: long copper-brown hair (`hair: 0x8b4526`), `hairStyle: 'sleek'` with `part: 'center'`, no hair clip, no side fringe. Thin rose-gold round glasses (`glassColor: 0xd9a98f`), coral lips (`lip: 0xe8704f`), small gold earrings (`earring: 0xe0b45a`), black top (`shirt: 0x1d1d1f`, `neckColor: 0x2a2a2d`), `teeth: true`.
  - Thạnh (Chủ tịt): `hairStyle: 'quiff'` (was `side`), thin light-silver rectangular glasses (`glassColor: 0xc9c5ba`), slimmer face (the `round` option removed), black-and-white gingham short-sleeve shirt (`shortSleeve: true`, collar kept), `teeth: true`.
  - Phú: neat short side-parted hair (`hairStyle: 'side'`, was `tousled`), rectangular dark glasses (`glassColor: 0x2a2a2e`), wider face (`round: true`), black collared shirt (`neck: 'collar'`, `collar: 0x141416`, was `crew`), `teeth: true`.
- Tooth and sleeve options are opt-in. Coworkers without them (Thảo, Thông, Nguyên, and the rest) render as before.

### Verification

- Headless Chrome: a lineup render was taken and viewed by eye. Compared with the reference photos by eye only.
- Not run on a real device or in any other browser. No side-by-side likeness score was recorded.

### Build and artifacts

- `index-offline.html`, `dist/netlify/index.html`, and `dist/MinhLee.app/Contents/Resources/index.html` contain `shortSleeve`, `quiff`, and the `part === 'center'` branch (grep check). `index-offline.html` differs from `index.html` only by the importmap line and the offline comment line. The three copies are byte-identical.
- `dist/MinhLee-mac.zip` was not rebuilt in this pass. `CFBundleShortVersionString` still reads 1.8.5 (see `docs/tasks.md`).

### Docs

- `docs/spec/dong-nghiep.md` (status, §8 table for Thạnh, Phú, and Yến, v1.9.3 fields), `docs/glossary.md` (`look.teeth`, `look.part`, `look.shortSleeve`, `look.hairStyle` value `quiff`), `docs/tasks.md` (Done entry, look-check follow-ups).
- `CLAUDE.md` not touched (user choice). `docs/product-guide.md` not changed (it has no look text).

## v1.9.2 — 2026-11-04

Detailed character looks for five coworkers. `buildCharacter()` gains an opt-in `look.detail` flag that adds a more detailed face, hair, and neck. Still Three.js primitives in one file. No change to logic, schedule, save format, or save key. Other coworkers are unchanged.

### Added

- `index.html`, `buildCharacter(look)` (section 6), opt-in `look.detail: true`:
  - `detailFace(look, mk, head)`: eyes with white sclera (`_D.eyeW`), iris (`look.eye`), and a highlight; eyebrows (`look.brow`, `look.browUp`); optional lashes (`look.lashes`); curved smile as a `TorusGeometry` half-ring in `look.lip`. Replaces the plain eye and mouth meshes when `detail` is set.
  - `detailHair(look, mk, head)`, selected by `look.hairStyle`: `wavy` (long, over the shoulders), `sleek` (long straight, side-swept fringe, hair clip in `look.clip`), `side` (neat side part), `tousled` (thick short hair with tufts). Optional `look.earring` adds two small spheres.
  - `detailClothes(look, mk, shirtC)`, selected by `look.neck`: `crew` (neck ring in `look.neckColor`), `collar` (small collar in `look.collar`, which can take a pattern such as `pat:gingham`), `vneck` (V-neckline in `look.neckColor`).
- `NPC_PROFILES` `look.detail: true` on five coworkers:
  - Chủ tịt (Thạnh): `hairStyle: 'side'`, `neck: 'collar'`, `collar: 'pat:gingham'`.
  - Phú: `hairStyle: 'tousled'`, `neck: 'crew'`.
  - Thảo: `hairStyle: 'wavy'`, `neck: 'vneck'`, `lashes`, `earring` (gold), `lip` (pink).
  - Yến: `hairStyle: 'sleek'`, `clip` (pink), `neck: 'crew'`, `lashes`, `lip` (pink), gold round glasses (`glassColor`, torus rims).
  - Thông: `hairStyle: 'side'`, `neck: 'crew'` (light grey ring on the white tee).

### Changed

- Thảo's wavy hair is now modelled. Before, `style: 'long'` was a flat box and the photo's wavy hair had no match (see `docs/tasks.md`, v1.8.6 photo-gap item). Closed in this release.
- `look.style` values `'wavy'` and `'sleek'` on Thảo and Yến have no branch in `buildCharacter()`. Their hair comes from `look.hairStyle`. Their `style` field is left as-is.

### Verification

- Headless Chrome: a lineup render of the five coworkers was checked by eye (screenshot viewed).
- Not run on a real device or in any other browser.
- Likeness against the reference photos was judged from earlier notes only, not side by side.

### Build and artifacts

- `index-offline.html`, `dist/netlify/index.html`, and `dist/MinhLee.app/Contents/Resources/index.html` contain `detailFace` (grep check). `index-offline.html` differs from `index.html` only by the importmap line and the offline comment line.
- `dist/MinhLee-mac.zip` was not rebuilt in this pass. `CFBundleShortVersionString` still reads 1.8.5 (see `docs/tasks.md`).

### Docs

- `docs/spec/dong-nghiep.md` (status, §8 per-person table), `docs/spec/mot-ngay-o-cong-ty.md` §4.4 (Thảo's entry), `docs/glossary.md` (`look.detail`, `look.hairStyle`, `look.neck`), `docs/tasks.md` (Done entry, Thảo gap closed, follow-ups).
- `CLAUDE.md` not touched (user choice). `docs/product-guide.md` not changed (it has no look text).

## v1.9.1 — 2026-11-04

Text-only release. Chị Ba (An, `an3`) is now grumpier and visibly annoyed, while staying funny. No logic, ids, save fields, or layout changed.

### Changed

- `index.html`, Chị Ba's lines (`an3`) rewritten in a gruffer, mock-annoyed tone (short, "cọc"). Still never mean; the "đấm nhẹ" (light punch) joke stays:
  - `say.greet`, `say.idle`, `say.chat`, `say.pantry`.
  - `reply`, `request` (ask), `meeting` (positive and negative lines).
  - `quirks` (including the note line).
  - The `DOC_QUESTS` ask line for the afternoon document quest.
  - Two `DUOS` lines: the duo with Chú 7 and the duo with Nam.
  - The `dammhaam` surprise result line.
- Unchanged on purpose: the stand-up catchphrase "Bực bội quá… thằng bánh tét đâu rồi!" (`say.stand`), the `say.standReply` line from Chú 7, and the trait labels, which are still not shown in the game.
- `docs/spec/dong-nghiep.md` §7.6: new Chị Ba voice note with tone guidance for future edits.

### Verification

- JavaScript syntax check and a headless smoke run only.
- Wording not reviewed by a native speaker.

## v1.9.0 — 2026-11-04

Six new day themes, each opening with a short story at 08:50 that the player answers with one of three choices. Finished desk tasks now add up across days and unlock eight items that appear on the player's desk in 3D. A collection screen in the pause menu lists them. No change to schedule, attendance, layout, save key, or the save format's existing fields.

### Added

- `index.html`, `DAY_THEMES` (variety block, between sections 2 and 3): six themes, each with `w: 1`, `treats: []`, and an `intro` event `{ id, emoji, title, text, opts }`. `opts` uses the same `[label, result, fx]` shape as `SURPRISES`.
  - `demo` (🤝 Ngày khách tới xem demo, `extra: 1`). Intro `th-demo`.
  - `power` (🔌 Ngày wifi chập chờn). Intro `th-power`.
  - `cat` (🐈 Ngày mèo ghé thăm). Intro `th-cat`.
  - `hack` (🏁 Ngày hackathon mini, `extra: 1`). Intro `th-hack`.
  - `sick` (🤧 Ngày giao mùa). Intro `th-sick`.
  - `award` (🏆 Ngày bình chọn tháng). Intro `th-award`.
- `startDay()` (section 14): if the drawn theme has an `intro`, it is put at the front of `D.surprises` with `t = 08:50` (`D.surprises.unshift`). It uses the same proximity gate as other surprises in `tickClock()`: it waits until a visible coworker is within `CFG.SURPRISE_NEAR` (4.2 m), and is skipped at 11:20 (08:50 plus 150 game-minutes). The intro has no `npc`, so any coworker counts. It goes through `fireSurprise()`, so it counts toward `D.stats.surprise` and the "Bạn của những điều bất ngờ" badge. Intros are not in `SURPRISES`, so `recentEv` does not affect them.
- `UNLOCKS` (variety block, before `SURPRISES`): eight desk items, each with `need` (cumulative finished desk tasks), `emoji`, `name`, `desc`, and `slot` (x, z offset from the desk centre). `mug` 1, `cactus` 2, `duck` 4, `cat` 6, `lamp` 9, `frame` 13, `phones` 18, `trophy` 25.
- `awardWork()` (section 11, beside the desk task): called from `startMiniGame()`'s `finish(true)`. It increments `Store.tasksTotal`, appends every item whose `need` is reached to `Store.unlocked`, and calls `buildDeskItems()` if any were added. It returns the new items.
- `showUnlocks(list)`: one reward card per new item, shown after the requester's reply card (or directly if there is no requester). The button reads "Xem tiếp" while more items remain.
- `nextUnlockLine()`: appended to the work card for a new desk task: "🎁 Phần thưởng kế tiếp: … (còn N việc)", or a line saying all items are unlocked. Not shown for a resumed task.
- `showCollection(onBack)`: new pause-menu button "🎁 Đồ trên bàn làm việc", placed after the diary button. Unlocked items show emoji, name, and description. Locked items show 🔒, the name, and "Làm thêm N việc để mở khóa."
- `buildDeskItems()` (section 5, beside the desk and office builders): builds a `THREE.Group` at `PLAYER_DESK` (y 0.75) from box and cylinder primitives, one block per owned item. It is called from `startDay()` and after each unlock. It returns early in list mode (`LITE`) and when there is no scene. Unlocks are still saved in list mode, and the collection screen still works there. Only the 3D desk is skipped.

### Changed

- `Store` (section 3): two new fields, `tasksTotal` (number, all desk tasks ever finished) and `unlocked` (array of item ids). Neither is in `defaults()`. They are read with `|| 0` and `|| []`, so existing saves load with no migration. The save key `mot-ngay-o-cong-ty.v1` is unchanged.
- `pickTheme()`: the pool now has 17 weight units (11 before, plus 6 for the new themes at `w: 1`). The Friday milk-tea rule (50%) and the "not the same as last day" rule are unchanged.
- Text pass (in progress, another agent): more natural Vietnamese wording in the content pools (`p1_data.js`). No logic change. This entry is not part of the functional changes above.

### Verification

- Headless Chrome only: the intro fires when the player is near a coworker. Unlock thresholds were checked, and all eight desk items were built. The far-away skip and the 11:20 cut-off were not recorded.
- Item looks were not reviewed visually. Not run on a real phone or in any other browser.

### Build and artifacts

- `index.html` matches the working copy at `/private/tmp/claude-501/-Volumes-SSD-1TB-Projects-Mingle/bdfb8f79-fac3-4f27-a4e8-c631d8e88ae8/scratchpad/index.html` (byte compare in the doc pass).
- `index-offline.html`, `dist/netlify/index.html`, and `dist/MinhLee.app/Contents/Resources/index.html` contain `UNLOCKS` and the `th-demo` intro (grep check). The `dist/MinhLee-mac.zip` file was not checked in this pass.
- `tools/macapp/Info.plist` and `dist/MinhLee.app/Contents/Info.plist` still read `CFBundleShortVersionString` 1.8.5. See `docs/tasks.md`.

### Docs

- `docs/spec/noi-dung-bat-ngo.md` (§1 intro note, §3 themes, §3.2 intro events, AC-75 to AC-77), `docs/spec/bang-nhiem-vu.md` (§2 pause menu, §9 desk collection, AC-78 to AC-80), `docs/spec/mot-ngay-o-cong-ty.md` (status, data model), `docs/spec/van-phong-layout.md` (status), `docs/product-guide.md` (day types, surprises, desk items, FAQ), `docs/glossary.md`, `docs/tasks.md`.
- `CLAUDE.md` not touched (user choice, gitignored).

## v1.8.8 — 2026-11-04

The wall clock on the north wall now shows the in-game time. Before, it was a static texture that always showed the same fixed time. No change to schedule, attendance, layout, save format, or the save key.

### Fixed

- `index.html`, wall clock (section 5, `buildOffice()`): the clock face is a `WALL_CLOCK` canvas texture (128 × 128 px) on a 0.6 × 0.6 m plane at (2.2, 2.6), z −7.93. It is now redrawn by `drawWallClock(g, minutes)`, which draws the white face, the dark rim, 12 tick marks, the hour hand (30 px), and the minute hand (46 px).
- `index.html`, `applyTimeOfDay(m)` (section 5): when the in-game minute changes (`Math.floor(m)` differs from `WALL_CLOCK.userData.drawn`), the clock is redrawn and `needsUpdate` is set. Redraw runs at most once per in-game minute. It is also called after a time skip (`applyTimeOfDay(D.minute)`), so the face jumps to the new time.
- The clock is drawn once at 08:30 when built, so the first frame is correct before `applyTimeOfDay()` runs.
- `applyTimeOfDay()` returns early in list mode (`LITE`, the no-3D fallback) and when there is no scene. The clock is not drawn there, because there is no 3D office.

### Verification

- Headless Chrome only: the clock face was exported at 08:30, 10:10, and 14:20. The three images differ, and the hands at 14:20 are correct. Not viewed on a real device or in any other browser.

### Build and artifacts

- `index-offline.html`, `dist/netlify/index.html`, and `dist/MinhLee.app/Contents/Resources/index.html` contain `drawWallClock` and the `WALL_CLOCK.userData.drawn` redraw check. `diff index.html index-offline.html` shows only the importmap line and the comment line (expected). Checked in the doc pass.
- `dist/MinhLee-mac.zip` and the app bundle were not rebuilt in this doc pass. `tools/macapp/Info.plist` and `dist/MinhLee.app/Contents/Info.plist` still read `CFBundleShortVersionString` 1.8.5. See `docs/tasks.md`.

### Docs

- `docs/spec/van-phong-layout.md` (status, wall clock row in §2 and §6, AC-74), `docs/tasks.md` (v1.8.8 Done entry), `docs/glossary.md` (new term "Đồng hồ treo tường"). `docs/product-guide.md` not changed: it mentions only the clock at the top of the screen (HUD), which did not change.

## v1.8.7 — 2026-11-04

Surprise events no longer pop up at their scheduled time from anywhere. After the scheduled time, a surprise waits until the player stands within 4.2 m of the coworker it involves. If that does not happen in time, the surprise is skipped for the day. Three narration strings now call Chủ tịt "anh" instead of "ông". No change to schedule, attendance, layout, save format, or the save key.

### Changed

- `index.html`, `tickClock()` (section 14): the surprise loop now has a proximity gate. For each due surprise (`D.minute >= sp.t`, not yet `fired`):
  - Skip: if `D.minute > Math.min(sp.t + 150, CFG.END - 20)`, the surprise is marked `fired` and not shown. That is 150 game-minutes after `sp.t`, or 17:10, whichever comes first.
  - Trigger: `near(n)` requires `n.state !== 'hidden'` and a distance under `CFG.SURPRISE_NEAR` (4.2 m) between `n.pos` and `P.pos`. If `ev.npc` is set, only that coworker counts (`npcById(ev.npc)`). If not, any visible coworker counts (`NPCS.some(near)`).
  - The loop still runs only in `play` mode and when `!P.lock`, one surprise per tick.
  - Before this release the trigger was the scheduled time alone (distance ignored). A surprise was skipped only when its coworker was hidden, after 90 game-minutes.
- `index.html`, `SURPRISES` (variety block): three narration strings now call Chủ tịt "anh" instead of "ông". Vietnamese wording not reviewed by a native speaker.
- Spec: `docs/spec/noi-dung-bat-ngo.md` §1 (trigger and skip rules) and AC-40.

### Verification

- Headless Chrome only: a surprise with the player far from the related coworker did not fire. The same surprise fired once the player was near. Not run on a real phone or any other browser.

### Build and artifacts

- `index-offline.html`, `dist/netlify/index.html`, and `dist/MinhLee.app/Contents/Resources/index.html` contain the v1.8.7 proximity code (checked by grep in the doc pass).
- `tools/macapp/Info.plist` and `dist/MinhLee.app/Contents/Info.plist` still read `CFBundleShortVersionString` 1.8.5. Not changed in this pass (docs only). See `docs/tasks.md`.

### Docs

- `docs/spec/noi-dung-bat-ngo.md` (status, §1 trigger and skip, AC-40), `docs/product-guide.md` (Surprises section), `docs/glossary.md`, `docs/tasks.md` (v1.7.0 to v1.8.1 Done entries moved to `docs/archive/tasks-done-2026-11.md`).

## v1.8.6 — 2026-11-04

The desk task is reworked around a requester: a coworker asks for the task, the card says what to do and how long it takes, and progress is kept when the player pauses. The two mini-games get a "how to" box, a progress bar, group descriptions, and a hint after two wrong answers. A world label marks the player's desk. Three coworkers get looks based on user photos. No change to schedule, attendance, layout, save format, or the save key.

### Added

- `index.html`, `workActivity()` (section 11): the desk task opens a work card. The requester (`D.work.from`, looked up with `npcById()`) is shown with the role "Đang nhờ bạn". The text comes from `workBrief()`: "N ghi chú" to sort into groups, or "N việc" to put in order. The card says the task takes about 30–60 seconds, with no score and no penalty. Buttons: "▶ Bắt đầu làm" (new task) or "▶ Làm tiếp" (task in progress), and "Để lát nữa (không mất gì)" (close, progress kept).
- `index.html`, `sortGame()` and `orderGame()`: a "Cách làm" box (`howTo()`), a progress bar (`progressBar()`), and a count line. The sort game shows a one-line description under each group name (`SORT_SETS.descs`).
- Hint glow: after 2 wrong taps the sort game outlines the correct group (`.glow`) and names it in the hint. The order game outlines the item with the nearest deadline.
- Requester reaction on completion (`startMiniGame()`, finish with `ok = true`): `changeAff(requester, +3)`, requester mood +8, and a card with `replyLine(n, 'great')` ("Bạn gửi lại cho …").
- `SORT_SETS` and `ORDER_SETS` gained `from` (`'bao'` = Anh Bảo, `'an3'` = Chị Ba). `newWork()` copies it into `D.work.from`.
- World label "💻 Bàn của bạn" above the player's desk: `deskTag` (`Bubbles.makeTag()` in `init()`, placed in the per-frame tag loop). Shown only in play mode, not in list mode, not while sitting (`P.lock`), with fewer than `CFG.MAX_TASKS` tasks done, and within 10 m of the desk. Its horizontal position is clamped to the screen edges (`clampX`), so it points toward the desk when the desk is off-screen to a side. It is hidden when its projected point is above 130 px or below `innerHeight - 40`.

### Changed

- Work progress is kept. `D.work` (`{ kind, set, from, order, done, next, elapsed, wrong }`) is no longer cleared when the player stops. "Để lát nữa (không mất gì)" closes the card without touching it. "⏸ Tạm dừng (giữ nguyên tiến độ)" inside the mini-game calls `finish(false)`: it adds the time spent to `elapsed`, shows the toast "⏸ Đã lưu tiến độ…", and returns to play. The same set, done items, and order are used on resume. `D.work` is set to `null` only when the task is finished (`finish(true)`) and reset by `newDayState()` at a new day.
- The task kind alternates by the number of tasks done: `D.tasks % 2 === 0` gives `sort`, otherwise `order`.
- Morning milestone hint (`MS`, `morning`): now names the label and the location: "Đến bàn của bạn (có nhãn “💻 Bàn của bạn”, góc dưới bên trái, cạnh bàn Thông) rồi bấm nút “Làm việc”."

### Changed (looks, photo-based)

Built from user photos with primitives only. No photo is embedded.

- Thông (`id: 'thong'`): `shirt: 0xf4f4f2` (white tee). Current profile also has short black hair, smile, no glasses.
- Thảo (`id: 'thao'`): `style: 'long'` (long hair) and `shirt: 0xe8923a` (orange blouse). Current profile also has smile, no glasses.
- Toàn (`id: 'toan'`): `shirt: 0x1f2a5c` (navy) and `mustache: true`. Current profile also has short black hair, round face, no glasses.
- Gaps against the photo notes, not changed in this release: `buildCharacter()` has no "wavy" hair style, so Thảo's hair is the flat `long` box. Toàn's shirt is a plain torso with no polo collar. The code places no plant pot at desk 3. See `docs/tasks.md`.

### Build and artifacts

- `index-offline.html`, `dist/netlify/index.html`, and `dist/MinhLee.app/Contents/Resources/index.html` are byte-identical and contain the v1.8.6 strings. `diff index.html index-offline.html` shows only the importmap line and the comment line (expected). Checked in the doc pass.
- `dist/MinhLee-mac.zip`: not opened in the doc pass.
- `tools/macapp/Info.plist` and `dist/MinhLee.app/Contents/Info.plist` still read `CFBundleShortVersionString` 1.8.5. Not changed in this pass (docs only). See `docs/tasks.md`.

### Verification

- Headless Chrome only (reported by the requester). Not run on a real phone or any device. Vietnamese wording not reviewed by a native speaker.

### Docs

- `docs/spec/bang-nhiem-vu.md` (desk label, morning hint, pause note), `docs/spec/mot-ngay-o-cong-ty.md` (§3 AC-71 to AC-73, §4.2 day state and pause, §4.4 looks, §6 requesters), `docs/product-guide.md` (morning task, desk label, FAQ), `docs/glossary.md`, `docs/tasks.md` (v1.6.0 and v1.6.1 Done entries moved to `docs/archive/tasks-done-2026-11.md`), `CLAUDE.md` (status line).

## v1.8.5 — 2026-11-04

Nguyên (Designer, remote worker who naps on the pantry daybed) gets a stylized look based on a photo the user supplied. The character is still built only from Three.js primitives. No photo, model, or Blender asset is embedded. No change to behaviour, schedule, attendance, layout, save format, or the save key.

### Changed

- `index.html`, `NPC_PROFILES` entry `nguyen`, `look`:
  - `hair: 0x15110f` (black), `style: 'fringe'` (side fringe, same branch as before in `buildCharacter()`). Target look: voluminous black hair with a side fringe.
  - `skin: 0xf3d3bb` (fair).
  - `shirt: 0x1b1b1d` (black top). Was a green top.
  - `glasses: false` (no glasses).
  - `smile` not set, so `buildCharacter()` draws the flat mouth: relaxed, neutral expression.
- Nothing else in the profile changed: `role`, `desk: null`, `habits`, `lounge`, `attendance`, `say`, `reply`, `quirks`, and `note` are the same as v1.8.2.

### Build and artifacts

- `index-offline.html`, `dist/netlify/index.html`, and `dist/MinhLee.app/Contents/Resources/index.html` rebuilt (reported by the requester). The three are byte-identical and contain the new `nguyen` look (checked in the doc pass).
- `dist/MinhLee-mac.zip` rebuilt by the build script; contents not opened in the doc pass.
- `tools/macapp/Info.plist` and `dist/MinhLee.app/Contents/Info.plist`: `CFBundleShortVersionString` is 1.8.5 (checked in the doc pass). The macOS app version follow-up from v1.6.0 is closed by this release (see `docs/tasks.md`).

### Verification (as reported by the requester)

- Headless Chrome screenshot of Nguyên lying on the pantry daybed (`LOUNGE_SEAT`) shows the new look. Not re-taken in the doc pass.
- Not checked on a real phone or on any device.

### Docs

- `docs/spec/mot-ngay-o-cong-ty.md` §4.4 (Nguyên look entry), `docs/glossary.md` (custom look, reference photo), `docs/tasks.md`.

## v1.8.4 — 2026-11-04

Bug fix (user report with a screenshot): when Nguyên lies on the pantry daybed, his name tag floated far above his body. The tag and speech bubble were anchored at standing height measured from the feet. A lying coworker now gets a name tag on the middle of the body and a speech bubble at the head end. Standing and seated anchors are unchanged. No change to layout, schedule, save format, or the save key.

### Fixed

- `index.html`, `npcAnchor()` and the new `isLying()` (next to `createNpcs()`, around lines 1356–1375): a coworker is treated as lying when `goal.anim` is `'lie'` and `state` is `'seated'` or `'seatIn'`. For a lying coworker:
  - Name tag (`Bubbles.makeTag()` getter in `createNpcs()`): 0.6 m from the body position toward the head, 0.75 m high (was the standing 1.95 m height above the feet).
  - Speech bubble (`npcHead()`, which calls `npcAnchor(n, out, false)`): 1.05 m toward the head, 0.85 m high.
  - Head direction: `-(sin yaw, cos yaw)`. The body is about 1.3 m long.
- Standing and seated anchors are unchanged: tag 1.95 m, bubble 1.85 m standing and 1.8 m seated (both above the root). The player's own bubble (`meSay`, 1.9 m) is unchanged.
- `docs/spec/dong-nghiep.md` §7.1 listed a 1.0 m lying height. The code never used that value: a lying coworker in state `seated` got the seated 1.8 m. The spec now records the v1.8.4 values.
- Ambient on-screen gate (`index.html`, `tryNpcSay()`): the `Bubbles.onScreen()` check now tests the same point as the bubble, `npcAnchor(n, …, false)`, instead of the standing point at the coworker's position. For a lying coworker the gate and the bubble anchor agree. This closes the v1.8.4 known issue found by reading the code.

### Verification (as reported by the requester)

- Headless Chrome screenshot of Nguyên on the daybed: name tag on the body and speech bubble at the head end.
- Headless Chrome full-day run: no JS errors, no collision violations.
- Not checked on a real phone.
- Ambient gate change: code check only (2026-11-04, reconciliation pass). Not run in a browser.

### Build and artifacts

- `index-offline.html`, `dist/MinhLee.app` (bundled `index.html`), and `dist/netlify/index.html` rebuilt from the same `index.html`. The three are byte-identical (see the build script output), and each contains `isLying`, the `k = forTag ? 0.6 : 1.05` line, and the `npcAnchor` call in `tryNpcSay()`.
- `dist/MinhLee-mac.zip` rebuilt by the build script (1,587,223 bytes at 14:56); contents not opened in the doc pass.
- `tools/macapp/Info.plist` `CFBundleShortVersionString` read 1.8.0 when this entry was written. It reads 1.8.5 from v1.8.5 on (see that entry).
- `index.html` was not edited in the doc pass (read-only).

### Docs

- `docs/spec/dong-nghiep.md` (§7.1 anchor rows and ambient gate row, AC-70), `docs/glossary.md`, `docs/tasks.md`, `CLAUDE.md`. `docs/product-guide.md` unchanged: the guide does not describe name tags or bubble placement.

## v1.8.3 — 2026-11-04

Help text only. Every on-screen message that says 3D cannot show now also suggests opening the game in Safari, or updating Chrome to the latest version and reloading. The player is no longer left with "try another browser" alone. No change to detection logic, fallbacks, the schedule, save format, or save key.

### Changed

- `index.html`, `<head>` environment check (classic script, runs before the module):
  - `noMap` message (`#env-note`, browser too old): "Trình duyệt này quá cũ nên chưa chạy được game 3D. Hãy thử mở bằng Safari, hoặc cập nhật Chrome lên bản mới nhất rồi tải lại trang."
  - `inApp` banner (`#env-note`): tap ⋯, choose "Mở bằng trình duyệt", then open in Safari (iPhone, Mac) or the updated Chrome (Android, Windows).
- `index.html`, `#boot-error` text (generic boot error, shown after 10 s without start): the first of its three tips is now "mở bằng Safari, hoặc cập nhật Chrome lên bản mới nhất". The other two tips (in-app choice, check the network and reload) are unchanged.
- `index.html`, `init()`, WebGL note (`#env-note`, `LITE_WHY === 'webgl'`, title screen): suggests Safari or an updated Chrome, and adds "nếu dùng Chrome, nhớ bật “Tăng tốc phần cứng” trong Cài đặt" (turn on hardware acceleration in Chrome settings).
- `index.html`, `fallbackToLite()`: the mid-game toast is now two lines, the second being "Hãy thử mở bằng Safari hoặc cập nhật Chrome rồi tải lại trang." The toast still runs 9000 ms, and applies to every `why` (`render`, `lost`).
- `index.html`, `refreshLite()`: list-mode panel note.
  - Automatic switch (`LITE_WHY !== 'user'`): suggests Safari or an updated Chrome.
  - Player chose simple mode (`LITE_WHY === 'user'`): unchanged in meaning. It tells the player to go back to the title screen and tap "Thử lại chế độ 3D".
- Built artifacts reflect these texts: `index-offline.html`, `dist/netlify/index.html`, and `dist/MinhLee.app/Contents/Resources/index.html` contain the new strings. The three are byte-identical (checked in the doc pass; the offline file was rebuilt after the last `index.html` edit).

### Verification (as reported by the requester)

- Headless Chrome, with WebGL creation forced to fail: the title note, the mid-game toast, the list-mode note, and the boot-error text each contain the Safari / Chrome suggestion.
- Not re-run in the doc pass. Not checked on real affected machines (Safari on iPhone or Mac, updated Chrome on Android or Windows, in-app browsers, Chrome with hardware acceleration off).
- Wording not reviewed by a native Vietnamese speaker.

### Build and artifacts

- `index-offline.html`, `dist/netlify/index.html`, and `dist/MinhLee.app` rebuilt from this `index.html`.
- `dist/MinhLee-mac.zip` rebuilt by `tools/build-mac-app.sh`; contents not opened in the doc pass.
- `tools/macapp/Info.plist` is unchanged in this entry. `CFBundleShortVersionString` read 1.8.0 at this release (`CFBundleVersion` 1). It was set to 1.8.5 in v1.8.5.

### Docs

- `docs/spec/tuong-thich-trinh-duyet.md`: §3 messages and toast texts updated to the v1.8.3 wording, toast duration corrected from 6 s to 9 s (matches the code, `toast(…, 9000)`), CP-12 to CP-14 added.
- `docs/product-guide.md` FAQ: "Why don't I see the 3D office?" now gives the Safari / Chrome steps. The FAQ entries for "browser not supported", "could not start", and the in-app box match the new on-screen text.
- `docs/deploy.md`: recipient advice for chat-app links names Safari (iPhone, Mac) or updated Chrome (Android, Windows).
- `CLAUDE.md` (status), `docs/tasks.md`, `docs/changelog.md`.

## v1.8.2 — 2026-11-04

Nam and Chủ tịt (Thạnh) get a serious work conversation and a work quirk at 09:42. Visits between a pair now pick randomly among all scripts defined for that pair, so a pair can have both a playful and a serious conversation. The playful "bé Hạnh" teasing is unchanged. No change to layout, schedule, save format, or the save key.

### Added

- `index.html`, `DUOS` (variety pools block, between sections 2 and 3): a second `nam` / `thanh` script in a serious work tone (4 lines):
  - Nam: "Thạnh, màn hình đăng nhập bên mobile cần chốt thiết kế trước thứ Sáu."
  - Thạnh: "Dạ, anh Nam gửi em bản mới, chiều nay em duyệt."
  - Nam: "Cảm ơn Thạnh. Tuần sau mình thử trên máy thật nhé."
  - Thạnh: "Dạ, em sắp xếp thời gian giúp anh."
  - The existing playful script (Nam: "Bé Hạnh ơi, hôm nay trà sữa đâu? Khìn khìn!") is unchanged.
  - `DUOS` now holds 17 scripts for 16 pairs.
- `index.html`, `NPC_PROFILES` entry `nam`, `quirks`: a quirk at 09:42, "Thạnh ơi, 10 giờ họp nhé, bên mobile có số liệu bản mới rồi.", `anim: 'talk'`. No `ctx`, so it uses the default desk context. It runs in the usual 8-minute window (09:42 to 09:50), once per day. It joins Nam's 08:58 quirk.

### Changed

- `index.html`, `runVisit()` (section 9): the duo script for a visit was the first match in `DUOS` for the pair. It is now `pick(ms)`, a random choice among all matching scripts. The choice is made once per visit and stored in `v.duo`, so the script does not change mid-visit. Pairs with one script behave as before. The partner choice in the visit start (section 9, `duoC`, 70% preference for pairs with a script) is unchanged.

### Fixed

- Docs only: the "bé Hạnh" meaning recorded in v1.8.1 (Clarified) is not repeated here. Game text is unchanged by v1.8.2.

### Verification (as reported by the requester)

- Headless Chrome full-day run: no JS errors, no collision violations, all content ids (surprises, duos, quirks) valid.
- Not recorded: per-line playback of each Nam–Thạnh script, the 09:42 quirk timing, and the distribution of the random pick. Not checked on a real phone.
- Wording not reviewed by a native Vietnamese speaker.

### Build and artifacts

- `index-offline.html`, `dist/MinhLee.app` (bundled `index.html`), and `dist/netlify/index.html` rebuilt. Doc-pass check: all three are byte-identical (see the build script output) and each contains the new strings.
- `dist/MinhLee-mac.zip` rebuilt by the build script; contents not opened in the doc pass.

### Docs

- `docs/spec/dong-nghiep.md` (§1 Chủ tịt and Nam rows, §2 address table, AC-67, AC-68), `docs/spec/noi-dung-bat-ngo.md` (§2 duo table and selection rule, AC-69), `docs/product-guide.md` (coworker table, FAQ), `docs/glossary.md`, `docs/tasks.md`, `CLAUDE.md`.

## v1.8.1 — 2026-11-04

Text only. Nam's playful "bé Hạnh" teasing gets two new lines, Chủ tịt (Thạnh) answers with a new chat line, and the pair gets a playful four-line duo. The meaning of "bé Hạnh" is now recorded in the docs: it is Nam's teasing nickname for Chủ tịt, a joke between colleagues. No change to layout, schedule, mechanics, save format, or save key.

### Added

- `index.html`, `NPC_PROFILES` entry `nam`, `say.idle`: "Bé Hạnh mà vô là hết yên bình, khìn khìn!"
- `index.html`, `NPC_PROFILES` entry `nam`, `say.chat`: "Bé Hạnh mua trà sữa chưa ta? Khìn khìn."
- `index.html`, `NPC_PROFILES` entry `thanh`, `say.chat`: "Anh Nam cứ gọi em là “bé Hạnh”, nghe quen rồi. Nhân quả cả thôi."
- `index.html`, `DUOS`, playful pair `nam`–`thanh` (4 lines):
  - Nam: "Bé Hạnh ơi, hôm nay trà sữa đâu? Khìn khìn!"
  - Thạnh: "Anh Nam đừng gọi em vậy, nhân quả đó. Chiều em mua, được chưa?"
  - Nam: "Đồng ý! Bé Hạnh là số một! Khìn khìn!"
  - Thạnh: "Em nghe hết rồi nha… cả phòng cười kìa."
- `DUOS` holds 16 scripts for 16 pairs at the end of v1.8.1. The later v1.8.2 script makes 17 (see that entry).

### Clarified (docs only)

- "bé Hạnh" is Nam's playful teasing nickname for Chủ tịt (Thạnh), a joke between colleagues. It has no other meaning in the game.
- The five `say.absent` lines (added v1.7.1) say that Nam misses Thạnh while Thạnh is late. The open question from v1.7.1 is closed.
- Recorded in `docs/glossary.md` (`bé Hạnh`), `docs/product-guide.md` (coworker table, FAQ), `docs/spec/dong-nghiep.md` (§1, §2), `docs/spec/noi-dung-bat-ngo.md` (§2), `docs/tasks.md`.

### Verification

- Headless-Chrome full-day harness (as reported by the requester): no JS errors, no collision violations, content ids valid. Not re-run in the doc pass.
- Doc-pass static check on the current `index.html`: every `DUOS` id and every `say.absent` `who` refers to an existing `NPC_PROFILES` id. The game module script parses (`node --check`).
- Wording not reviewed by a native Vietnamese speaker.

### Build and artifacts

- `index-offline.html`, `dist/MinhLee.app/Contents/Resources/index.html`, and `dist/netlify/index.html` contain the v1.8.1 strings and are byte-identical. They are built from the current `index.html` (see the newest entry for the build time).

## v1.8.0 — 2026-11-04

Playtest feedback: the objective line at the top of the screen was hard to see, and the pause menu had no list of the day's tasks. The objective is now a larger card, and tapping it pauses the game and opens the day's mission board. The pause menu also shows that board under "▶ Tiếp tục". No change to the schedule, events, save format, or save key.

### Added

- `index.html`, section 10: `missionBoard()` builds the mission board shown in the pause menu. It has three parts:
  - "🎯 Việc cần làm bây giờ · <milestone>": a highlighted card with the current milestone's hint. When the milestone is done it shows "Xong mốc này rồi! Cứ thong thả khám phá thêm."
  - "Các mốc trong ngày": every entry of `MS` with its start time and a status icon: ✅ done, ▶️ current (its hint is shown underneath), ⏳ upcoming, ⏭ passed without being done (small note "Đã qua, không sao cả, ngày vẫn tiếp tục"). Status rules: `docs/spec/bang-nhiem-vu.md` §3.2.
  - "Việc nhỏ hôm nay": rows from `extraTasks()`: desk work (n/`CFG.MAX_TASKS`), the afternoon file quest (once started), the printer jam (from its start time), the birthday party (from its start to 30 minutes after it ends), and leaving a note (from 16:00). Done rows show ✅, open rows show 🔹.
- `index.html`, `pauseGame()`: the mission board is placed between the "▶ Tiếp tục" button and the other pause buttons.
- `docs/spec/bang-nhiem-vu.md` (new): spec for the goal card, the mission board, and the tap-to-open path.

### Changed

- `index.html`, `updateHud()`: the goal card reads "🎯 <milestone>: <hint>" with a small second line "Chạm để xem cả bảng nhiệm vụ" (tap to see the whole mission board). The done state ("✔ … Xong mốc này!") is unchanged.
- `index.html`, `init()`: the `#hud-obj` click handler calls `Sfx.click()` and then `pauseGame()` while `G.mode === 'play'`. The same path as P / Esc and the ⏸ button.
- CSS `.obj` (goal card): font-size 16px, weight 600, cream background `#fffaf2`, 2px accent border with a 7px left edge, shadow, `cursor: pointer`. Its sub-line (`small`) is 12px. The `.hud-obj` container still ignores pointer events, so only the card itself is tappable.
- CSS `.qb` (mission board, new): `.now` card at 18px bold with a 2px accent border; rows at 15px; `.row.cur` bold; `.row.skip` at 50% opacity; `.row .tm` tabular digits for times.

### Fixed

- The objective line at the top of the screen was hard to read (user feedback). The card is larger and has a stronger border.
- The pause menu had no list of the day's tasks and milestones (user feedback). The mission board now appears there.

### Verification (as reported by the requester)

- Headless Chrome unit check of `missionBoard()` at 08:30 and at 14:50 (game time).
- Headless Chrome check of tap-to-open on `#hud-obj` (opens the pause menu with the board).
- Screenshots of the pause board and the goal card at 500 px width. Reported as readable.
- macOS app self-test (`dist/MinhLee.app/Contents/MacOS/MinhLee --selftest`) passed on the rebuilt app.
- Not tested on a real phone (touch, safe area, notch).
- Wording not reviewed by a native Vietnamese speaker.

### Build and artifacts

- `index-offline.html`, `dist/MinhLee.app`, and `dist/netlify/index.html` rebuilt. A doc-pass check found all three byte-identical and each contains the v1.8.0 strings.
- `dist/MinhLee-mac.zip` rebuilt by `tools/build-mac-app.sh`; contents not opened in the doc pass.
- `tools/macapp/Info.plist`: `CFBundleShortVersionString` set to 1.8.0 (the v1.6.0 open item). `CFBundleVersion` is still 1. Later set to 1.8.5 in v1.8.5.

### Docs

- `CLAUDE.md` (status, layout), `docs/spec/bang-nhiem-vu.md` (new), `docs/spec/mot-ngay-o-cong-ty.md` (status, §4.2 milestones and pause), `docs/product-guide.md` (controls, "The mission board", FAQ), `docs/glossary.md`, `docs/tasks.md`, `docs/changelog.md`.

## v1.7.2 — 2026-11-04

The diary intro line now depends on context. Players who opened the diary from the pause menu on the first day saw "Bạn đã trải qua 0 ngày làm việc" (you have spent 0 workdays). That felt wrong, because a diary entry is only written at the end of a day. The intro now says the entry is written at day's end during a day, and counts days worked outside a day. Gameplay, save format, and the save key are unchanged.

### Changed

- `index.html`, `showDiary()` (section 13): the intro line is chosen from context.
  - During a day (previous mode `paused` or `play`, `D` set, `D.ended` false): "Hôm nay là ngày làm thứ N của bạn ở MinhLee. Nhật ký sẽ được ghi lại vào cuối ngày." N is `Store.days + 1`.
  - During day 1 with no diary entries, a second intro line is shown instead of the empty-list line: "Đây là ngày làm đầu tiên của bạn! Đến cuối ngày, nhật ký sẽ ghi lại hôm nay."
  - Outside a day (title screen, or after the day ended): "Bạn đã làm ở MinhLee N ngày." when `Store.days` is greater than 0, otherwise "Chưa có ngày làm nào được ghi lại."
  - Empty-list line when there are no entries outside a day is unchanged: "Chưa có ngày nào được ghi lại. Hãy bắt đầu ngày làm đầu tiên nhé!"
- `index-offline.html`, `dist/MinhLee.app`, and `dist/netlify/index.html` rebuilt from this `index.html`. The app copy and the netlify copy are byte-identical to `index-offline.html`.
- Docs: `CLAUDE.md`, `CHANGELOG.md`, `docs/spec/mot-ngay-o-cong-ty.md` (§4.2, AC-27), `docs/product-guide.md`, `docs/tasks.md`.

### Fixed

- Mid-day diary on day 1 no longer reports "0 ngày làm việc". The intro explains that the first entry is written at the end of the day.

### Verification

- Headless Chrome unit check of three situations, reported by the requester: mid-day on day 1, mid-day on day 2, and the title screen. This doc pass did not re-run it.
- Not tested on devices (phone, touch, or desktop browsers other than headless Chrome).
- Wording not reviewed by a native Vietnamese speaker.

## v1.7.1 — 2026-11-04

Two coworker speech moments and two generic speech hooks. Chị Ba gets a stand-up catchphrase that Chú 7 answers, and Nam talks about the boss before he arrives. The hooks (`say.stand`, `say.standReply`, `say.absent`) work for any coworker. No change to layout, schedule, save format, or the save key. Text and a small amount of new logic in section 9.

### Added

- `index.html`, section 2, `NPC_PROFILES` entry `an3` (Chị Ba): `say.stand`, three variants: "Bực bội quá… thằng bánh tét đâu rồi!", "Áp lực quá! Bực bội quá… thằng bánh tét đâu rồi!", "*vươn vai* Bực bội quá… thằng bánh tét đâu rồi!". Also `say.standReply` = `{ id: 'an7', line: 'Dạ có em đây chị Ba! (nép sau ly trà)' }`.
- `index.html`, section 2, entry `an7` (Chú 7): one `say.chat` line about the nickname: "Nghe Chị Ba gọi “bánh tét” là biết sắp có người bị réo tên." ("bánh tét" is Chị Ba's teasing nickname for Chú 7.)
- `index.html`, section 2, entry `nam` (Nam): `say.absent` = `{ who: 'thanh', lines: [...] }` with 5 lines. Three of them contain "bé Hạnh" ("Nhớ bé Hạnh…"). Who or what "bé Hạnh" is has not been defined in the game. See `docs/tasks.md` (open question).
- Generic speech hooks, optional on any `NPC_PROFILES` entry (`docs/spec/dong-nghiep.md` §7.5):
  - `say.stand` (array): one line is picked when a seated coworker is sent to a new goal. Called from `standUpLine(n)`, which `setGoal()` calls before the seat is left.
  - `say.standReply` (`{ id, line }`): coworker `id` says `line` 1.8 s after a stand-up line was shown, if that coworker is visible and on screen.
  - `say.absent` (`{ who, lines }`): a seated coworker at `desk:work` says a line from `lines` while coworker `who` is hidden and the game time is before `who.times.arrive`. Timer in `npcAmbient()`, one per coworker (`absentCool`).
- `index.html` section 9, new function `standUpLine(n)`. Chance 55% per stand-up, 90% on the `busy` day theme ("Ngày chạy nước rút"). Cooldown `standCool` of 60 s, set only when a line is shown. A line is shown only through `tryNpcSay()`, so the player must be within 9.5 m and the speaker on screen.

### Changed

- `index.html`, `setGoal()` (section 9): a seated coworker who is sent to a new goal calls `standUpLine(n)` before walking off. This is the only trigger for `say.stand`. "Áp lực quá!" is one of the three variants, not a separate trigger.
- `docs/spec/dong-nghiep.md`: status, roster rows 7 (Nam), 10 (Chú 7), 11 (Chị Ba), §2 address table, §5 AC-65 and AC-66, new §7.5.
- `docs/product-guide.md`: coworker table rows for Nam, Chú 7, and Chị Ba. New FAQ entry on "bánh tét".
- `docs/glossary.md`: new terms (see the glossary); Chú 7 and Chị Ba entries extended.
- `docs/tasks.md`, `docs/changelog.md`, `CLAUDE.md` (status).
- Rebuilt: `index-offline.html` (`tools/build-offline.py`), `dist/MinhLee.app` (`Contents/Resources/index.html` is byte-identical to `index-offline.html`), `dist/MinhLee-mac.zip` (1,585,707 bytes), and `dist/netlify/index.html` (`tools/prepare-netlify.sh`, byte-identical to `index-offline.html`). The three HTML copies are 1,125,891 bytes each.

### Verification

- Headless-Chrome unit check (2026-11-04): Nam produced 2 or more `say.absent` lines in the first 50 game minutes while Chủ tịt was hidden.
- Headless-Chrome unit check (2026-11-04): on a forced `busy` day, the Chị Ba stand-up line fired in 11 of 12 forced attempts.
- Headless-Chrome full-day harness (2026-11-04): no JavaScript errors, no collision violations.
- Not reviewed by a native Vietnamese speaker: the new lines (Chị Ba, Chú 7, Nam), the "bánh tét" nickname, and "bé Hạnh".
- Not tested on phones, tablets, Safari, or Firefox. The `standReply` path and the 60 s cooldown were not recorded separately.

## v1.7.0 — 2026-11-04

Hardening for players who see no graphics. Players reported "no graphics" after the game was shared. The cause is not identified. This release detects the common causes before the game starts, retries the renderer, tells the player why it fell back to list mode, and switches to list mode mid-game when rendering fails. Gameplay, content, layout, and the save key are unchanged. The only save change is an optional `settings.lite` boolean.

### Added

- `index.html`, classic `<script>` in `<head>` (before the module, after the boot timer): environment check.
  - `HTMLScriptElement.supports('importmap')` sets `window.__env.noMap`. If it is false, `#env-note` shows a "browser too old" message and `#btn-start` reads "Trình duyệt chưa hỗ trợ". The module never runs in that case, so the button stays disabled.
  - User-agent test sets `window.__env.inApp`. Tokens: Zalo, FBAN, FBAV, FB_IAB, Messenger, Instagram, MicroMessenger (WeChat), TikTok, Snapchat, Line/. In those apps `#env-note` shows a banner: tap ⋯ and choose "Mở bằng trình duyệt".
  - Snapchat is in the token list but was not in the original brief.
- `index.html`, `init()`: renderer creation tries `antialias: true`, then `antialias: false`. If both throw, the game starts in list mode with `LITE_WHY = 'webgl'`. `#env-note` says WebGL is off and suggests turning on hardware acceleration or using a newer Chrome, Edge, or Safari.
- `index.html`, title screen: `#btn-lite`. Its label is "🧩 Không thấy hình? Dùng chế độ đơn giản" in 3D mode and "🎮 Thử lại chế độ 3D" in list mode. It writes `settings.lite` and reloads with `?lite` removed. `?lite` in the URL forces list mode.
- `index.html`, `frame()`: render watchdog. After the game starts (not while paused), on the 150th counted frame, if `renderer.info.render.calls === 0`, call `fallbackToLite('render')`. It runs once.
- `index.html`, `init()`: `webglcontextlost` handler calls `preventDefault()`, shows the toast "Đồ họa tạm gián đoạn, đang khôi phục…" (4 s), and starts a 4 s timer. `webglcontextrestored` clears the timer. If the timer fires, `fallbackToLite('lost')` runs.
- `index.html`, `fallbackToLite(why)`: sets `LITE`, `LITE_WHY`, hides `#game`, `#stick`, `#keys`, `#act`, shows `#lite` if the day has started, and shows a 6 s toast. Mid-game switches are not written to `settings.lite`, so the next load tries 3D again.
- `index.html`, `#boot-error`: text lists three things to try (latest Chrome, Edge, or Safari; "Mở bằng trình duyệt" in Zalo or Messenger; check the network and reload).
- `docs/spec/tuong-thich-trinh-duyet.md`: new spec for browser support, detection, fallbacks, and acceptance criteria CP-1 to CP-11.

### Changed

- `index.html`, `init()`: `LITE_WHY` is `'user'` when `settings.lite` or `?lite` forces list mode. The title-screen behavior per trigger is in `docs/spec/tuong-thich-trinh-duyet.md` §3.
- `docs/spec/mot-ngay-o-cong-ty.md`: status, and §4.2 fallback description (now two attempts, plus the v1.7.0 watchdog and context-loss timer).
- `docs/spec/phan-phoi-offline.md`: status, §5 browser minimums (Safari 16.4+, Chrome 89+, Firefox 108+, Edge 89+), AC-O7 (partly verified), AM-5 (passed again), §8.2 zip size.
- `index-offline.html` regenerated from the v1.7.0 `index.html` (`tools/build-offline.py`). A read-only diff shows only the importmap line and the added comment line differ.
- `dist/MinhLee.app` rebuilt (`tools/build-mac-app.sh`). Its `Contents/Resources/index.html` is byte-identical to `index-offline.html`. `dist/MinhLee-mac.zip` rebuilt: 1,586,521 bytes at 14:46 (was 1,583,693 in v1.6.1). The build was rebuilt more than once during this docs pass; take the final size from the last build.
- Docs: `CLAUDE.md`, `docs/deploy.md`, `docs/product-guide.md`, `docs/glossary.md`, `docs/tasks.md`, `docs/changelog.md`.

### Fixed

- No confirmed fix. The "no graphics" reports had no identified root cause when this release was made. The release adds detection and fallbacks, so the player sees a reason or keeps playing in list mode, instead of a blank screen.

### Verification

- Headless Chrome, full simulated day in 3D mode: run.
- Headless Chrome, `?lite` mode: run.
- Headless Chrome, mid-game `fallbackToLite()`: the day continues in list mode.
- Real Safari 27.0.1 on macOS 27 (Apple GPU): the 3D scene rendered. webgl2 and webgl1 available, 226 draw calls, 6128 triangles, 7 programs, no errors, canvas 3608×2308. Measured with a temporary on-page diagnostic. No Safari setting was changed. The file loaded is not recorded.
- `--selftest` on the rebuilt macOS app: passed again.
- Simulated only, not with a real failing GPU: the renderer fallback, the watchdog, and the context-loss timer.

### Known issues

- Not checked: Safari below 16.4, iOS Safari, Firefox, Edge, Android Chrome, in-app browsers (Zalo, Messenger, and others), WebGL disabled by policy, a genuinely broken GPU.
- Modules and import maps are required. Browsers below the minimums show the too-old message and no game. A classic (non-module) bundle is an optional follow-up.
- `noMap` is true when `HTMLScriptElement.supports` is missing as well as when import maps are unsupported. Confirm the note stays hidden in Safari 27 and Chrome.
- The render watchdog checks one frame only. It does not catch a GPU failure that happens later.
- Players reported that they could open the game in Safari afterwards. The cause is not identified.
- `tools/macapp/Info.plist` reads `CFBundleShortVersionString` 1.6.0 and `CFBundleVersion` 1 at this release. It is not set to 1.7.0. Set to 1.8.5 in v1.8.5.

## v1.6.1 — 2026-11-04

Chị Ba (`id: 'an3'`) is reworked from an accounts-and-paperwork role into a product-research role. Her lines, quirks, desk request, afternoon document quest, one sort-game project, one sort-game item, and the Chị Ba–Nam duo change to match. Gameplay mechanics, layout, and save format are unchanged. Text and data only: no logic change.

### Changed

- `index.html`, section 2, `NPC_PROFILES` entry `an3` (Chị Ba, `role: 'Business Support'`, `real: 'An'`, `visitAnim: 'punch'`). Business Support here means supporting product research: she runs user surveys, builds reports, and analyses the numbers. The role string is unchanged.
  - `traits`: "hỗ trợ nghiên cứu sản phẩm, làm báo cáo" (product research support, writes reports). The "punch" trait is kept as a joke.
  - `say.greet`, `say.idle`, `say.chat`, `say.pantry`, `say.deep`: rewritten around surveys, reports, charts, and App Dating user feedback. `say.greet[1]` keeps its `@am ` tag (still shown before 11:00 only).
  - `say.reply` (great / ok / meh): rewritten, with the "meh" replies asking the player to check the work again. `say.meeting` (`pos` / `neg`): clear numbers and research data.
  - `request`: the desk request is a survey report with only 40 respondents, and the client wants strong conclusions. Options: state that the sample is small and propose more surveys (`work`); write it honestly and add to it later (`warm`); write "40 people strongly support" (`joke`).
  - `quirks`: 09:12 (`anim: 'punch'`) says she has finished the survey numbers. New 09:48 quirk (`anim: 'check'`): she re-checks the charts before the meeting.
  - `note.high` / `note.low`: rewritten around careful work and citing data sources.
- `index.html`, section 2, `DOC_QUESTS` (Chị Ba, `npc: 'an3'`) and `DOC_NAMES`: the afternoon document quest asks for "Báo cáo khảo sát người dùng" (user survey report) instead of the invoice folder. The name is the first entry of `DOC_NAMES`.
- `index.html`, section 2, `SORT_SETS` set 2: project "🧾 Sổ sách tháng" is now "🔎 Nghiên cứu người dùng". Its notes are "Tổng hợp kết quả khảo sát" and "Vẽ biểu đồ phản hồi người dùng", both filed under this project.
- `index.html`, section 2, `ORDER_SETS` set 2: the ordering item now reads "Gửi số liệu khảo sát cho Chị Ba" (send the survey data to Chị Ba, due this afternoon).
- `index.html`, section 2, `DUOS` entry `an3` – `nam`: Chị Ba asks Nam to send the survey data he forgot ("Tuần trước ông quên gửi số liệu khảo sát cho tui nha."). Same-age banter (tui / ông) and the punch beat are kept. Four lines.
- `index-offline.html` regenerated from the updated `index.html` (`tools/build-offline.py`).
- `dist/MinhLee.app` rebuilt (`tools/build-mac-app.sh`). Its `Contents/Resources/index.html` is byte-identical to `index-offline.html`. `dist/MinhLee-mac.zip` rebuilt: 1,583,693 bytes (was 1,583,593 in v1.6.0).
- Docs: `CLAUDE.md` (status), `docs/spec/dong-nghiep.md` (roster row 11), `docs/spec/noi-dung-bat-ngo.md` (status, duo table), `docs/spec/mot-ngay-o-cong-ty.md` (status, document names, sort-game projects), `docs/spec/phan-phoi-offline.md` (zip size), `docs/product-guide.md` (coworker table, afternoon row), `docs/glossary.md` (Chị Ba entry, new terms), `docs/tasks.md`, `docs/changelog.md`.

### Removed

- Accounts-and-paperwork content for Chị Ba: the invoice-folder document quest ("Hóa đơn tháng 10"), the "Sổ sách tháng" (bookkeeping) project, and the bookkeeping lines. Nothing in the current `index.html`, `docs/product-guide.md`, or the spec files describes her as an accountant or paperwork role. Older entries in this changelog are kept as written.

### Verification

- Headless-Chrome harness re-run on the updated `index.html`, 2026-11-04: all 19 surprises with each of their 3 options; the document quest flow completes; one full game day. No JavaScript errors, no collision violations.
- Not reviewed by a native Vietnamese speaker. The survey wording and the "40 respondents" sample are not checked for tone or for how a real survey report would read.
- Not tested on phones, tablets, Safari, or Firefox. The rebuilt macOS app was not self-tested (`--selftest`) for this release.

## v1.6.0 — 2026-11-04

A macOS app that wraps the offline build, and a text fix for Yến's time-of-day greetings. Gameplay, layout, and save format are unchanged. The only game-code change is the Yến greeting text below.

### Added

- `tools/macapp/main.swift`: native macOS app (Cocoa, AppKit) with one `NSWindow` that hosts a `WKWebView`. It loads `index.html` from the app bundle's `Contents/Resources/` with `loadFileURL(_:allowingReadAccessTo:)`. The app makes no network request of its own. Window: title "Một Ngày Ở MinhLee", 520 × 900 default, 360 × 560 minimum, frame autosaved as `MinhLeeMain`. Closing the window terminates the app (`applicationShouldTerminateAfterLastWindowClosed`).
- Menus: app menu (Ẩn, Thoát ⌘Q); Chỉnh sửa (Cắt, Sao chép, Dán, Chọn tất cả), so paste works in the name field; Hiển thị (Toàn màn hình ⌃⌘F, Tải lại game ⌘R).
- Load-failure handling: `didFail` and `didFailProvisionalNavigation` show a Vietnamese alert, "Có chút trục trặc", with a friendly message, then the app quits. A missing `index.html` in the bundle shows the same alert. Raw errors go to `NSLog` in `#if DEBUG` builds only. A web content process crash reloads the page.
- `--selftest` launch flag: after load, checks `__gameReady`, the start button, a localStorage write and read, a marker left by the previous launch, and WebGL availability. It clicks "Bắt đầu ngày mới", waits 3 seconds, prints `PHASE1` and `PHASE2` JSON lines to stdout, and exits.
- `tools/macapp/Info.plist`: bundle id `com.minhlee.mot-ngay-o-cong-ty`, executable `MinhLee`, `LSMinimumSystemVersion` 11.0, `LSApplicationCategoryType` games, `NSHighResolutionCapable`.
- `tools/macapp/AppIcon.icns` (about 1.2 MB), referenced by `CFBundleIconFile`.
- `tools/build-mac-app.sh`: runs `tools/build-offline.py`; compiles `main.swift` with `swiftc -O -swift-version 5` for `arm64` and `x86_64` (`-target <arch>-apple-macos11.0`); joins the binaries with `lipo -create`; copies `Info.plist`, the icon, and `index-offline.html` (as `Contents/Resources/index.html`); signs ad-hoc with `codesign --force --deep -s -`; zips with `ditto -c -k --keepParent`.
- Build outputs: `dist/MinhLee.app` (universal), `dist/MinhLee-mac.zip` (1,583,593 bytes, about 1.5 MB), and `dist/.build/` for intermediate binaries (not for sharing).
- `docs/deploy.md` option 4 (macOS app): what to send, first-open steps for Gatekeeper (right-click > Open), the `xattr -dr com.apple.quarantine` fallback for "damaged" apps, and the macOS-only limit.
- `docs/spec/phan-phoi-offline.md` §8 (macOS app: files, build, behavior, constraints, acceptance criteria AM-1 to AM-17) and §9 (open items).
- `docs/archive/tasks-done-2026-11.md`: the completed-items list from `docs/tasks.md` (v1.0.0 to v1.5.0), moved to keep `tasks.md` under 300 lines.

### Changed

- `index.html`, section 2, `NPC_PROFILES` entry `yen` (Yến), `say.greet`: `greet[1]` ("Trời ơi cái mặt này! Mới sáng ra đã… là sao?") now starts with `@am `. A new `@pm ` line was added as `greet[3]`: "Chiều rồi mà bạn còn tỉnh táo vậy? Là sao, bí quyết là gì?". This is the first `@pm` line in the game.
- `index-offline.html` regenerated from the updated `index.html`.
- `CLAUDE.md`: stack, key commands (`tools/build-mac-app.sh`, `--selftest`), layout (`dist/`, `tools/macapp/`, `docs/archive/`), status.
- `docs/spec/mot-ngay-o-cong-ty.md`: status and Delivery row mention the macOS app.
- `docs/spec/dong-nghiep.md`: status, AC-63, §6 (the v1.4.4 known issue is marked resolved), §7.3 (`@pm` line listed).
- `docs/product-guide.md`: Mac getting-started note, save note, and two FAQ entries for the Mac security warning.
- `docs/glossary.md`: terms for the macOS app and its build (placeholders).
- `docs/tasks.md`: Done section moved to the archive; v1.6.0 items recorded; the v1.4.4 Yến item closed; macOS open items added.

### Fixed

- Yến's greeting could show after 11:00 (known issue from v1.4.4). `greet[1]` is now tagged `@am`, so it only shows before 11:00. Source check only, not run in a browser.

### Verification

- Self-test on the build Mac (macOS 27, Apple Silicon), `--selftest`, 2026-11-04: game loaded inside WKWebView; `__gameReady` true; WebGL available; localStorage works and its data persisted across two separate launches; after "Bắt đầu ngày mới" the HUD appeared and the in-game clock advanced (08:32).
- `lipo -info dist/MinhLee.app/Contents/MacOS/MinhLee`: `x86_64 arm64`.
- `codesign --verify --deep --strict dist/MinhLee.app`: passes. Signature is ad-hoc (`flags=0x2(adhoc)`), no Team ID.
- `cmp` of `dist/MinhLee.app/Contents/Resources/index.html` and `index-offline.html`: identical.
- `unzip -l dist/MinhLee-mac.zip`: holds `MinhLee.app/Contents/` with `MacOS/MinhLee`, `Info.plist`, `Resources/AppIcon.icns`, `Resources/index.html`, and `_CodeSignature`.
- `plutil -lint tools/macapp/Info.plist`: OK.

### Known issues

- Not notarized; ad-hoc signed only. Other Macs show a Gatekeeper warning on first open. Steps are in `docs/deploy.md` option 4. Not tested on a second Mac.
- Tested only on Apple Silicon with macOS 27. Intel Macs (the x86_64 slice is checked with `lipo` only) and other macOS versions are not tested.
- Not verified by eye: window appearance and app icon (the icon is checked as a valid `.icns` file only).
- Not verified by hand: audio output, keyboard play, Edit > Paste into the name field, Toàn màn hình, Tải lại game, closing the window quits the app, and the load-failure alert.
- `tools/macapp/Info.plist` still says `CFBundleShortVersionString` 1.5.0 and `CFBundleVersion` 1. Not changed in this release's docs pass.
- `tools/macapp/main.swift`: the comment on `mediaTypesRequiringUserActionForPlayback = []` says audio starts after the first tap, but an empty list allows playback without a user gesture. Behavior not checked.
- The `--selftest` code and its `print` calls are compiled into the release binary.
- No Windows build. Windows coworkers use `index-offline.html`, or a separate Electron or WebView2 build (not started).
- `dist/MinhLee.app` and `dist/MinhLee-mac.zip` must be rebuilt after every edit to `index.html`. Nothing enforces this.

## v1.5.0 — 2026-11-04

A self-contained offline build. `index-offline.html` runs with no network at all, because Three.js 0.160.0 is inlined in its import map. `index.html` is unchanged and still loads Three.js from the jsDelivr CDN. No gameplay, content, layout, or save-format change.

### Added

- `index-offline.html` (~1.1 MB, generated, do not edit by hand). Same game as `index.html`. The importmap entry `three` points to a `data:text/javascript;base64,...` URL that holds the library. No network request is made.
- `tools/build-offline.py` (Python 3, standard library only). Reads `index.html`, finds the single importmap line for Three.js, downloads `three@<version>/build/three.module.min.js` from jsDelivr on first run if the cache is missing, base64-encodes it, and writes `index-offline.html`. Re-run after every edit to `index.html`: `python3 tools/build-offline.py`.
- `tools/three.module.min.js` (~670 KB). Cached Three.js 0.160.0 minified ES module, the input to the script. MIT, no imports.
- The Three.js license header (`@license`, Copyright 2010-2023 Three.js Authors, SPDX MIT) is kept at the top of the inlined library. The importmap is preceded by an HTML comment naming Three.js 0.160.0 and its MIT license.
- `docs/deploy.md` (new): which file to send, and the build step for maintainers.
- `docs/spec/phan-phoi-offline.md` (new): distribution and offline spec, file roles, build steps, acceptance criteria AC-O1 to AC-O8.

### Changed

- `CLAUDE.md`: stack, key commands (build command), how-to-run, layout, status.
- `docs/spec/mot-ngay-o-cong-ty.md`: Delivery, Rendering, and Network constraints now describe both files. Dependency table row for Three.js updated.
- `docs/product-guide.md`: getting-started steps and the internet FAQ mention `index-offline.html`.
- `docs/glossary.md`, `docs/tasks.md`, `docs/changelog.md`.

### Verification

- Headless Chrome with all network blocked (`--host-resolver-rules="MAP * ~NOTFOUND"`), throwaway harness (not in repo), 2026-11-04: `index-offline.html` completed a full simulated day. No JS errors. No collision violations, except a couple of transient NPC-overlap samples (same known minor issue as AC-4).
- Same network-blocked test: `index.html` (CDN) correctly fails to start. Expected.
- Read-only diff, 2026-11-04: `index-offline.html` and `index.html` differ only in the importmap line and one added comment line.

### Known issues

- Not tested in Safari, Firefox, or mobile browsers. Data-URL import maps are supported in current Chrome, Firefox, and Safari, but only headless Chrome has been run.
- `index-offline.html` must be regenerated after every change to `index.html`. Nothing enforces this yet (see `docs/tasks.md`).
- Whether save data is shared between `index.html` and `index-offline.html` in one browser is not tested.

## v1.4.4 — 2026-11-04

Speech bubbles and coworker lines now follow what the character is doing. After user feedback: bubbles always sat at the top of the screen, and lines did not match the activity (a pantry line at a desk, a morning greeting in the afternoon). Content and UI logic only: no layout, mechanics, or save-format change. Still a single-file browser game (`index.html`).

### Fixed

- Bubble placement (`Bubbles.update()`, section 7): a bubble is anchored above the speaker's head (`npcHead()`, 1.85 m standing, 1.8 m seated, 1.0 m lying; player 1.9 m). Previously bubbles sat at the top. If the anchor is off-screen, behind the camera, under the top HUD margin (112 px), or within 50 px of the bottom, the bubble is hidden. It is not pinned to the edge. The horizontal clamp (6 px inside the screen) stays so the bubble box is not cut off.
- Ambient bubbles: `tryNpcSay()` does not start a bubble for a coworker outside the viewport. New helper `Bubbles.onScreen(x, y, z)`.
- Context-aware lines: `lineFor(n, greeting)` (section 9) gives pantry lines when the goal is `pantry…` or `ovr:…`, "Đang họp, lát nói chuyện nhé." during the meeting (`meet`), and greeting or idle lines otherwise. Ambient greetings and the talk-card intro both use it.
- Quirk `ctx` (optional field on each `quirks` entry, read by `ctxOk()`): `desk` (default; seated, goal `desk:work`), `eat` (seated, `desk:eat`), `lounge` (seated, `lounge`), `any` (not moving). A quirk whose context does not match is skipped and retried until its 8-minute window ends.
- Treat bubble in `processTimeEvents()` (`treat`), which matches Chủ tịt's activity: at the pantry "Nước em pha sẵn rồi nè, mọi người ra lấy nhé!", at a desk "Em vừa đặt đồ uống cho cả nhà, lát giao tới nha!", otherwise "Em mời cả nhà nè, đừng ngại!".
- Time-of-day tags on lines: `@am ` (before 11:00), `@noon ` (11:00 to 13:29), `@pm ` (13:30 onward). `pickSay()` strips the tag and keeps only lines for the current window. Tagged lines in v1.4.4: Chủ tịt greet[0] ("em lại đi trễ"), Trung greet[0], Nam greet[0], Thảo greet[0] and greet[1], Yến greet[0], Chị Ba greet[1]. No `@noon` or `@pm` line exists yet.
- Surprise `dating100k`, option 1 now reads "Em mời trà sữa!" (source check, 2026-11-04). This closes the v1.4.3 known issue.

### Changed

- `NPC_PROFILES`, Chú 7 (`an7`): the pre-meeting quirk moved from 09:50 to 09:46. Text unchanged.
- `NPC_PROFILES` quirks with a non-default `ctx`: Chủ tịt 12:50 (`any`), Thảo 15:15 (`any`), Tùng 16:50 (`any`), Toàn and Hiện 12:40 (`eat`), Nguyên 11:20 (`lounge`). All other quirks use the `desk` default.
- Docs: `docs/spec/dong-nghiep.md` (status, §2 Chú 7 time, new §7 "Lines and speech bubbles", AC-61 to AC-64, known issues), `docs/spec/mot-ngay-o-cong-ty.md` (status, quirk rule), `docs/product-guide.md` (coworker talk paragraph), `docs/deploy.md` (new file, rewritten: options 1 and 2 added, option 3 kept), `docs/glossary.md`, `docs/tasks.md`, `docs/changelog.md`, `CLAUDE.md`.

### Verification

- Headless Chrome checks reported for this release (throwaway harness, not in repo, 2026-11-04): tag filtering (no tag text in rendered greetings), afternoon greetings without morning-only phrases, `ctx` true and false cases, `Bubbles.onScreen` true for visible coworkers and false for off-screen ones. Full simulated day: no JS errors, no collision violations.
- Not checked: bubble placement on a real phone or touch device; Vietnamese wording by a native speaker.
- Source check (2026-11-04, read-only): one untagged greeting in the afternoon can still be a morning phrase (see Known issues). It contradicts the afternoon check above for that one line.

### Known issues

- Yến's greeting `say.greet[1]` ("Trời ơi cái mặt này! Mới sáng ra đã… là sao?") has no `@am` tag, so it can show after 11:00. Not changed: `index.html` was read-only in this release.
- No `@noon` or `@pm` line exists. Afternoon greetings come from untagged lines only.
- Quirk lines are fixed text and are not tagged. They rely on their `at` time.
- The new treat texts and the `ctx` and tag choices have not been reviewed by a native speaker.

## v1.4.3 — 2026-11-04

Chủ tịt (Thạnh) now speaks in a humble style, and the Chú 7–Thông duo is rewritten to match Chú 7's tea-loving young persona. Content only: no layout, mechanics, or save-format change. Still a single-file browser game (`index.html`).

### Changed

- `NPC_PROFILES`, Chủ tịt (`id: 'thanh'`): humble speech. He refers to himself as "em" and calls most people "anh" / "chị", including the player (`{anh}` / `{Anh}`, filled by `fill()`) and in group talk ("em mua cho cả nhà"). Applied to `say.greet`, `say.idle`, `say.chat`, `say.pantry`, `request` (ask, options, reply), `reply`, `meeting`, `quirks`, and `note`.
- Exceptions: younger coworkers and Chị Ba keep the normal "anh" / "em". Younger for this rule: Hiện (stated as the youngest), and Chú 7, Trung, and Nguyên (assumed, see Known issues). Nam is the same age as Chủ tịt and is not in this group, so he gets the humble style. Duo `thanh`–`hien` keeps "anh" ("Mèo thiền giỏi hơn anh đó").
- Treat bubble in `processTimeEvents()` (the `treat` helper, section 14): "Em mua cho cả nhà nè, mọi người lấy đi đừng ngại!". Applies to the 11:05, 14:10, and milk-tea treats.
- `DOC_QUESTS`, Chủ tịt's document favor ask: "{Anh} lấy giúp em bản “Hợp đồng đối tác game” trong tủ nhé."
- `SURPRISES`: surprise texts and options that have Chủ tịt lines rewritten to the same style.
- Duo `thao`–`thanh` (Thảo and Chủ tịt): Chủ tịt's reply is now "Nhân quả mà chị… lần sau em sẽ cố. Em mời cả phòng trà sữa bù nha."
- Duo `an7`–`thong` (Chú 7 and Thông): rewritten to Chú 7's tea-loving young persona ("Thông ơi, uống trà không? Ô long mới…"). See Fixed.
- Docs: `CLAUDE.md` (status), `docs/spec/dong-nghiep.md` (roster, address table, known issues), `docs/spec/noi-dung-bat-ngo.md` (duo table, status), `docs/product-guide.md` (coworker row), `docs/glossary.md`, `docs/tasks.md`, `docs/changelog.md`.

### Fixed

- Duo `an7`–`thong` (v1.4.0 known issue): the backup and worry lines ("nhớ sao lưu hợp đồng đất nhé, chú lo lắm", "chú sao lưu bốn bản") are removed. Closes the open item from v1.4.0.
- Doc correction: `docs/spec/noi-dung-bat-ngo.md` §2 listed Chú 7–Thông as 3 lines. The source has 4. The table now says 4.

### Verification

- Headless Chrome re-run (2026-11-04, throwaway harness, not in repo): all 19 surprises x 3 options, 15 duos, and one full day. No JS errors, no collision violations.
- Source check (2026-11-04, read-only grep of `index.html`): one Chủ tịt line still uses the old self-reference (see Known issues).
- Not tested on devices, touch input, or audio.
- Vietnamese wording not reviewed by a native speaker.

### Known issues

- Surprise `dating100k`, option 1 (`index.html` line 532): Chủ tịt says "Anh mời trà sữa!" in group talk. Under the humble rule it should be "Em mời…". Not changed in this release: `index.html` was read-only.
- The younger-coworker list (Chú 7, Trung, Nguyên) is an assumption. Only Hiện is stated as youngest. To be confirmed (see `docs/tasks.md`).

## v1.4.2 — 2026-11-04

Chủ tịt (Thạnh) is now a cat lover. The cat content is new, and the stray-cat surprise now involves him. Content and one prop only: no layout, mechanics, or save-format change. Still a single-file browser game (`index.html`).

### Added

- `NPC_PROFILES`, Chủ tịt (`id: 'thanh'`, desk 1):
  - Trait `rất thích mèo` (maintainer note only, not shown in the UI).
  - His cat is named "Nhân Quả" (a play on karma). Mentioned in one greeting, one idle line, one chat line, and one pantry line (cat scratching post, grey or beige).
  - Quirk at 12:50 (`anim: null`): "(mở điện thoại xem ảnh mèo, cười tủm tỉm)", he looks at cat photos on his phone.
- Surprise `thanhmeo` (😺 "Ảnh mèo của Chủ tịt", related coworker Chủ tịt, `npc: 'thanh'`). Chủ tịt shows the player a photo of his cat Nhân Quả on his phone. Options: praise the cat (mood +8, energy −2, affinity with Thạnh +4), ask why the cat is named Nhân Quả (mood +8, affinity +3), or say the player is allergic to cat hair (mood +5, affinity +2, he sends photos instead).
- Duo `thanh` – `hien` (Chủ tịt – Hiện), 3 lines, about cats and games ("Game cũng như mèo, phải chăm mới ngoan."). `DUOS` now has 15 pairs (was 14).
- Desk prop: a cat plush (cream body, head, and two ears) on Chủ tịt's desk. Built in `buildOffice()` (section 5, `seatItems()`, the `i === 1` branch). Seat index 1 is Chủ tịt's desk.
- `GOSSIP_THING` (notice board) gains `'tấm ảnh mèo của Chủ tịt'`. The pool has 13 entries (was 12). Combinations are 14 × 8 × 13 × 7 = 10,192 (was 9,408).

### Changed

- Surprise `cat` (🐈 "Chú mèo lạc", a stray tabby in the office): related coworker is now Chủ tịt (`npc: 'thanh'`, was `none`). The texts and options now show Chủ tịt's reaction (he rushes off for cat food, or names the cat "MinhLee" and adopts it). Option 3 applies `aff: { thanh: 4 }`.
- `SURPRISES` now has 19 entries: 18 events plus the mystery gift box (`gift`). The new `thanhmeo` sits at row 9 in `docs/spec/noi-dung-bat-ngo.md` §1.1. Rows after it shift by one, and `gift` is row 19.
- `NPC_PROFILES`, Chủ tịt: greeting (3rd line), idle (3rd line), chat (3rd line), and pantry (3rd line) lines now mention the cat. The 09:36 late-arrival and 13:20 meditation quirks are unchanged.
- Docs: `CLAUDE.md` (status), `docs/spec/dong-nghiep.md` (roster notes), `docs/spec/noi-dung-bat-ngo.md` (19 entries, 15 duos, new rows), `docs/spec/mot-ngay-o-cong-ty.md` (variety counts), `docs/spec/the-gioi-lien-tuc.md` (gossip pool counts), `docs/product-guide.md` (coworker table), `docs/glossary.md`, `docs/tasks.md`, `docs/changelog.md`.

### Verification

- Headless Chrome, throwaway harness (not in the repo), 2026-11-04: all 19 surprises exercised with all 3 options each. No raw placeholders in rendered text. No JS errors. No collision violations (the cat plush sits on the desk and does not add an obstacle).
- Not tested on devices, touch input, or audio.
- Vietnamese wording not reviewed by a native speaker.

## v1.4.1 — 2026-11-04

Custom stylized looks for three more coworkers (Phú, Nam, Anh Bảo) and a new `plaid` shirt pattern. Still a single-file browser game (`index.html`).

### Added

- Custom looks for three coworkers, built only from Three.js primitives and canvas textures. No photos, no external or Blender-made models, no embedded images.
  - Phú (`id: 'phu'`, desk 0): short black hair (`style: 'short'`, `hair: 0x15130f`), thin rectangular glasses (`glasses: 'rect'`, `glassColor: 0x2a2a2e`), black shirt (`shirt: 0x1c1c1e`), smile (`smile: true`). Previously an orange shirt and no glasses.
  - Nam (`id: 'nam'`, desk 6): black fringe (`style: 'fringe'`, `hair: 0x15130f`), red-and-blue plaid shirt (`pattern: 'plaid'`), neutral expression (no `smile`). Previously a light-blue shirt.
  - Anh Bảo (`id: 'bao'`, desk 2): short neat black hair (`style: 'short'`, `hair: 0x1a1410`), thin dark rectangular glasses (`glasses: 'rect'`, `glassColor: 0x30343a`), mustard shirt (`shirt: 0xe9c46a`), smile (`smile: true`). Built from the user's written brief only (no reference photo), so the exact face is an approximation.
- `patternMat(kind)` in `index.html` gains the `plaid` kind. Kinds are now `gingham`, `stripe`, and `plaid` (`look.pattern`). A value that matches none of them falls back to the gingham texture.
- `docs/spec/mot-ngay-o-cong-ty.md` section 4.4 lists the three new looks and the `plaid` pattern.

### Changed

- Chú 7 (`id: 'an7'`): no change. The user re-sent the photo already used for the v1.1.2 look (dark swept hair, white shirt, no glasses).

### Verification

- Headless Chrome screenshots of isolated close-ups only (2026-11-04). Not checked on phones or other devices.

## v1.4.0 — 2026-11-04

Personality update for three coworkers (Thảo, Tùng, Chú 7), three new surprises, and three new duo pairs. Content only: no layout, mechanics, or save-format change. Still a single-file browser game (`index.html`).

### Added

- Surprises `SURPRISES` (`index.html`, section 1 data block), 3 new entries, 18 total (was 15). Each has 3 options with `mood`, `energy`, `aff`, and `moment` effects:
  - `thaoquan` (🍜 "Thảo khoe quán ngon", related coworker Thảo): Thảo shares a bún chả place about 200 m from the office. Options: join the group, ask what to order, or joke about Thảo knowing every restaurant.
  - `tungthach` (🎯 "Tùng thách đố", related coworker Tùng): Tùng challenges the player to say "MinhLee" ten times in a row without stumbling. Options: accept, challenge Tùng back, or decline politely.
  - `khiatra` (🍵 "Cuộc khịa bằng trà", related coworker Chú 7): Chú 7 sends a tea to Chị Ba as a tease. Options: cheer Chú 7 on, calm them down, or ask Chú 7 for a tea.
- Duo pairs `DUOS`, 3 new pairs, 14 total (was 11):
  - `an7` – `an3` (Chú 7 and Chị Ba), 4 lines. Tea and a playful punch.
  - `tung` – `phu` (Tùng and Phú), 4 lines. An after-work drink invitation and a dare.
  - `thao` – `tung` (Thảo and Tùng), 3 lines. Thảo suggests a grill place for an after-work drink.

### Changed

- `NPC_PROFILES`, Thảo (`id: 'thao'`): the office foodie. Traits note updated (`rành quán ăn, quán nước, đồ ngon`). Greetings, idle lines, chats, pantry lines, the request, and the note are about food and restaurants. Request is a lunch choice (cơm niêu or lẩu nấm). Quirks include 11:40 (recommends a lunch place) and 15:15 (bánh bông lan in the pantry).
- `NPC_PROFILES`, Tùng (`id: 'tung'`): often invites people out for a light after-work drink (nhậu, kept light). Greetings, idle lines, chats, pantry lines, and the high-affinity note reflect this. Request is the "MinhLee" tongue-twister dare (`request.ask`). Quirks include 09:25 (breath-hold challenge) and 16:50 ("Ai đi nhậu giơ tay!").
- `NPC_PROFILES`, Chú 7 (`id: 'an7'`): young. The "Chú" is a nickname, not an age term. Loves tea (trà ô long, trà sen). Traits note updated (`trẻ tuổi`, `mê uống trà`, `hay khịa Chị Ba`). Greetings, chats, and the request (ô long vs lotus tea) are about tea. The earlier "worries ahead and backs everything up" persona is removed from the profile lines.
- `docs/spec/noi-dung-bat-ngo.md`: event table now lists 18 entries (`gift` moved to row 18). Duo table now lists 14 pairs.
- Docs: `CLAUDE.md` (status line), `docs/spec/mot-ngay-o-cong-ty.md` (counts and status), `docs/spec/dong-nghiep.md` (roster notes, address table, known issue), `docs/product-guide.md` (coworker table), `docs/glossary.md`, `docs/tasks.md`, `docs/changelog.md`.

### Verification

- Headless Chrome, throwaway harness (not in the repo), 2026-11-04: all 18 surprises exercised with all 3 options each. Every surprise and duo id resolves. No raw placeholders in rendered text. No JS errors. No collision violations, with one transient overlap sample.
- Not tested on devices, touch input, or audio.
- Vietnamese wording not reviewed by a native speaker.

### Known issues

- Duo `an7`–`thong` (Chú 7 and Thông) still has backup and worry lines ("nhớ sao lưu hợp đồng đất nhé, chú lo lắm", "chú sao lưu bốn bản"). They come from the persona removed in this release. Not changed in v1.4.0. Open point (see `docs/tasks.md`).
- The "nhậu" content (Tùng's invitations, the 16:50 quirk, the `tung`–`phu` and `thao`–`tung` duos) is meant to be light and wholesome. Tone not yet reviewed by the user.

## v1.3.1 — 2026-11-04

Custom stylized looks for three more coworkers (Yến, Chị Ba, Thảo), and round glasses with a frame colour and thick-lens option. Still a single-file browser game (`index.html`).

### Added

- Custom looks for three coworkers, built only from Three.js primitives and canvas textures. No photos, no external or Blender-made models, no embedded images. Blender was not used.
  - Yến (`id: 'yen'`, desk 12): long auburn-brown hair (`style: 'long'`, `hair: 0x7a3a22`), thin round gold-rimmed glasses (`glasses: true`, `glassColor: 0xc9a24a`), black top (`shirt: 0x1d1d1f`), smile (`smile: true`). Previously a pink top and no glasses.
  - Chị Ba (`id: 'an3'`, desk 10): shoulder-length brown bob (`style: 'bob'`, `hair: 0x8a5a3c`), thick dark round glasses (`glasses: true`, `glassColor: 0x1c1c1c`, `glassThick: true`), round face (`round: true`), black top (`shirt: 0x202022`). Previously a purple top.
  - Thảo (`id: 'thao'`, desk 11): shoulder-length black bob (`style: 'bob'`, `hair: 0x15110f`), cream knit top (`shirt: 0xf1e8d4`), smile (`smile: true`), no glasses. Previously a bun and an orange top.
- `buildCharacter()` supports `look.glassColor` on round glasses (`glasses: true`). It sets the frame colour; the default is `0x2b2220`. Before, the field applied only to `'rect'` glasses.
- `buildCharacter()` supports `look.glassThick`. When `true` on round glasses, the lenses are scaled to 1.15 wide and 2.2 deep. Ignored for `'rect'` glasses.
- Docs: `docs/spec/mot-ngay-o-cong-ty.md` section 4.4 lists the three new looks and the `glassThick` option.

### Verification

- Headless Chrome screenshots only (2026-11-04). The faces are visible behind the monitors at the default camera. Not checked on phones or other devices.

### Known issues

- Yến's nickname "Én Pink" (`nick` in `NPC_PROFILES`) no longer matches her black top. Cosmetic. Open point for the user (see `docs/tasks.md`). Not changed in v1.3.1.

## v1.3.0 — 2026-11-04

Office rebuilt to follow the user's floor plan (`so-do-van-phong-2.svg`): two shared long tables, a lower row of own desks, two columns, and the front door moved to the east wall. The plan has no meeting room and no player desk, so both were placed by the maintainer. The daybed, sofa, printer, and notice board moved to the positions listed under Changed (see Assumptions below). Also: coworker walk speed and lunch and coffee timing tuned, and the birthday logic fixed. Still a single-file browser game (`index.html`).

### Added

- Layout constants block in `index.html`, section 5, under the comment "Bố cục theo sơ đồ" (about line 755). It converts plan pixels to metres with `planX(px) = (px − 600) × 0.02243` and `planZ(py) = (py − 450) × 0.02353`.
  - `DOOR` (east wall, z 2.29) and `DOOR_GAP` (z 1.29 to 3.29, the walkway band).
  - `LONG_TABLES` (2 tables, 6.9 × 1.5 m, at x ±6.62, z −2.09). Each table seats 4 (left) or 5 (right) people on the north and south sides.
  - `DESKS` (13 coworker seats, see the index table below). `PLAYER_DESK` (x −10.2, z 4.73).
  - `COLUMNS` (2 pillars: (−0.39, −2.18) and (−1.77, 4.49)).
  - `MEET_ROOM`, `MEET_TABLE` (3.0 × 1.5 m, at (0, −5.2)), `MEET_SEATS` (8 seats, 4 per side).
  - `PANTRY_SPOTS` (8 standing spots), `SOFA_SEATS` (2), `LOUNGE_SEAT` (daybed), `PRINTER_SPOT`.
- Meeting room (top centre, x −3 to 3, z −8 to −2.9). Glass walls on the east and west sides for z −8.0 to −5.1, a glass south wall with an opening at x −1.9 to 1.9, and side doors below the glass. Includes a whiteboard on the north wall and a 3.0 × 1.5 m table (`MEET_TABLE`).
- Player desk "Bàn của bạn" at the bottom left, next to Thông's desk (`PLAYER_DESK`). The yellow marker moved with it.
- Spec: `docs/spec/van-phong-layout.md` (coordinates, seat table, spots, assumptions, AC-52 to AC-60).

### Changed

- Office geometry (`buildOffice()`, section 5):
  - Front door on the east wall (x 12.1), between the two seating zones and aligned with the walkway. Previously on the south wall.
  - Daybed (`LOUNGE_SEAT`, obstacle 1.8 × 1.0 m) moved to the north wall east of the pantry, at (−4.6, −6.9). Previously (−7.0, −4.2).
  - Sofa moved to the north east corner. Obstacle at (8.0, −7.3), 3.0 × 1.0 m.
  - Printer moved to the west wall, `PRINTER_SPOT` at (−10.2, 0.3).
  - Notice board moved to the east wall beside the front door (spot at (10.9, 4.6)). Filing cabinet stays at the south east (spot at (10.9, 5.9)).
  - Pantry stays at the top left (north west).
- Interaction spots (`buildSpots()`, section 11): all spots now use the new positions. Front door spot "Ra về" at (10.8, `DOOR.z`).
- Desk indexes in `NPC_PROFILES` (`desk`), matched to the plan:

  | Index | Coworker | Place | Previous index |
  |---|---|---|---|
  | 0 | Phú | Left table, north | 1 |
  | 1 | Chủ tịt (Thạnh) | Left table, north | 0 |
  | 2 | Anh Bảo | Left table, south | 11 |
  | 3 | Toàn | Left table, south | 3 |
  | 4 | Trung | Right table, north | 2 |
  | 5 | Hiện | Right table, north | 4 |
  | 6 | Nam | Right table, north | 6 |
  | 7 | Chú 7 (An) | Right table, south | 9 |
  | 8 | Tùng | Right table, south | 5 |
  | 9 | Thông | Lower row, left | 12 |
  | 10 | Chị Ba (An) | Lower row | 10 |
  | 11 | Thảo | Lower row | 7 |
  | 12 | Yến | Lower row | 8 |
  | none | Nguyên | Remote, `desk: null` | none |

  Previous indexes are from v1.2.0 and are given for reference only. The desk field comment in section 2 already reads "0-3 bàn dài bên trái, 4-8 bàn dài bên phải, 9-12 bàn riêng hàng dưới".
- Milestone hints (`MS`, section 10) describe the new positions (09:00 bottom-left desk, 10:00 meeting room at the top centre, 17:00 right wall).
- Coworker pacing (section 9, `n.speed` and `n.times`):
  - `CFG.NPC_SPEED` 1.55 → 1.9 m/s. Each NPC still gets a ±10% factor. Paths are longer after the re-layout.
  - Lunch window `lunchEnd: ls + 55` (was 45 minutes).
  - Coffee windows `[s, s + 16]` (was 13 minutes), both morning and afternoon.
- Birthdays (section 14, `startDay()`):
  - Offset is now `(n.idx × 4 + 3) % 65` (was `× 5`). Offsets for the 14 coworkers are 3, 7, … 55, all unique.
  - Birthday lookup skips coworkers who are working remotely that day (`n.times.arrive < 99999`). If the birthday coworker is remote, no birthday is set for that day and the normal daily-event roll applies.
  - Birthdays and the cake party no longer pick remote coworkers. The random cake pick is `NPCS.filter(n.id !== 'thao' && n.times.arrive < 99999)`.
- Docs: `CLAUDE.md`, `docs/spec/mot-ngay-o-cong-ty.md` (sections 4.1, 4.2, 6, 8), `docs/spec/dong-nghiep.md` (roster desks, daybed coordinates), `docs/spec/the-gioi-lien-tuc.md` (birthday formula, notice board, cake pick), `docs/spec/van-phong-layout.md` (new), `docs/product-guide.md`, `docs/glossary.md`, `docs/tasks.md`, `docs/changelog.md`.

### Fixed

- Nguyên's birthday never fired in v1.2.0 because his offset equalled Chủ tịt's. With offset `(idx × 4 + 3) % 65` each coworker has a unique offset, so Nguyên's birthday now fires (offset 55, when in the office).
- The random cake party could pick Nguyên on a remote day, so the card named a coworker who was not in the office. The pick now excludes remote coworkers.

### Assumptions to confirm

- Player desk at (−10.2, 4.73), bottom left, left of Thông. Not in the plan. Change `PLAYER_DESK`.
- Meeting room at top centre, between the two long tables. Not in the plan. Change `MEET_ROOM` / `MEET_TABLE` / `MEET_SEATS`.
- Daybed, sofa, printer, and notice board positions follow the brief for this release, not positions taken from the SVG. Confirm they are the intended spots.

### Verification

- Headless Chrome, throwaway harness (not in the repo), 2026-11-04: no JS errors, no collision violations, one transient NPC overlap sample. Full day completes.
- NPCs reach the pantry (checked with a 75-second lunch simulation).
- Screenshots confirm the long tables, columns, door, and meeting room.
- Layout fidelity to the SVG was checked by eye on screenshots, not measured.
- Not tested on devices, touch input, or audio.

### Known issues

- The section 2 header comment in `index.html` does not describe `desk: null`, `habits.lounge`, or `habits.attendance` (open since v1.2.0).
- Decorative objects (plants, windows, posters, wall clock, calendar, logo) keep their v1.2.0 positions. They are not in the plan and were checked by eye only.

## v1.2.0 — 2026-11-04

Fourteenth coworker (Nguyên, who works remotely and rests on a new pantry daybed), office address conventions, and the in-game names "Chủ tịt" and "Anh Bảo" in surprises, duos, gossip, and meeting text. Still a single-file browser game (`index.html`).

### Added

- Nguyên (`id: 'nguyen'`), 14th entry in `NPC_PROFILES`. Role "Developer (làm từ xa)" (tentative), `desk: null`, gender assumed male. Habits: `arrive: '10:15'`, `leave: '17:00'`, `coffee: 'morning'`, `lunch: 'pantry'`, `joinsMeeting: false`, `lounge: true`, `attendance: 0.3`.
- Remote attendance: `resetNpcDay()` rolls `Math.random() > habits.attendance` each day. On a remote day `times.arrive` is 99999 and Nguyên stays hidden all day. He is in the office on about 30% of days.
- Pantry daybed:
  - Scene: obstacle `addObst(-7.0, -4.2, 1.0, 1.8)` in `buildOffice()` (section 5), with a teal frame, cream mattress, and orange pillow.
  - Seat: `LOUNGE_SEAT` (cx −7.0, cz −3.6, `lie: true`), used by `goalLounge()`. Pose `lie` in `poseCharacter()`.
  - `decideGoal()` returns `goalLounge()` as the default idle goal when `habits.lounge` is true. Meeting, events, lunch, coffee, and visits still take priority.
- Arrival toast in `processTimeEvents()`: "😴 Nguyên hiếm hoi lên công ty hôm nay, đang nằm ở pantry!" at arrival + 8 minutes. Not shown on remote days.
- Nguyên quirk at 11:20 (`anim: null`, "(nằm dài ở pantry, mắt lim dim)").
- Two duos in `DUOS`: Thảo–Yến (4 lines; Thảo calls Yến "chị Yến") and Hiện–Anh Bảo (3 lines). Total 11 pairs.
- Title subtitle says 14 coworkers (`index.html` line 156).
- Docs: `docs/spec/dong-nghiep.md` (new): roster, address conventions, remote worker, profile fields, AC-46 to AC-51.

### Changed

- In-game names: Chủ tịt (`name: 'Chủ tịt'`, `real: 'Thạnh'`) and Anh Bảo (`name: 'Anh Bảo'`, `real: 'Bảo'`). Surprises (`SURPRISES`), duo scripts (`DUOS`), office gossip (`GOSSIP_A`), and the meeting host text (`HOSTN`) use these names. The real name Thạnh remains in one surprise line (Chị Ba, `dammhaam`: "Chị xin lỗi anh Thạnh!").
- Surprise texts and options that named Thạnh or Bảo now use Chủ tịt or Anh Bảo (for example `dating100k`, `vip`, `review5`, `nhanqua`).
- Hiện's lines rewritten: he refers to himself as "em" and to others as anh / chị (`{anh}` / `{Anh}` placeholders).
- Address conventions across the roster (see `docs/spec/dong-nghiep.md` §2): Anh Bảo is the oldest. Chị Ba calls Chủ tịt "anh" (same age). Chú 7 is called "Chú 7". Yến, Thông, Thảo, Tùng, and Phú use first names.
- Office gossip (`GOSSIP_A`): 14 names, adds Nguyên. Combinations 9,408 (was 8,736).
- Pantry: `PANTRY_SPOTS` still has 8 standing spots. Two were relocated to fit the daybed. Their previous coordinates are not recorded here.
- Docs: `CLAUDE.md`, `docs/spec/mot-ngay-o-cong-ty.md` (roster table moved to `dong-nghiep.md`, 14 coworkers, `LOUNGE_SEAT` in the layout list), `docs/spec/noi-dung-bat-ngo.md` (names, 11 duos), `docs/spec/the-gioi-lien-tuc.md` (birthday roster, gossip pool), `docs/product-guide.md`, `docs/glossary.md`, `docs/tasks.md`.

### Corrected and confirmed (same day, 2026-11-04)

The entries above are kept as written. These later confirmations supersede them:

- Nguyên's role is `'Designer'` (not "Developer (làm từ xa)", tentative). Confirmed by the user.
- No gender is recorded for Nguyên. The earlier "gender assumed male" note is withdrawn. The profile has no gender field.
- Attendance is `habits.attendance: 0.5` (was 0.3). Nguyên is in the office on about half of the days, not 3 in 10.
- Nam is the same age as Chủ tịt and Chị Ba. His lines are rewritten as peer-level (mình / bạn, no deferential "em" or "ạ") and keep "khìn khìn". The Chị Ba–Nam duo (`an3` / `nam`) is rewritten as same-age banter (tui / ông).
- Nam's job title is `role: 'Mobile Dev'`. The "(junior)" label in the earlier docs is not in the code and has been removed from the docs.
- Traits are no longer shown anywhere in the UI. `traits` in `NPC_PROFILES` is a maintainer note. The conversation card shows the name, real name and nickname (when present), job title, affinity hearts, a status sentence, and the coworker's line. The invite list ("📨 Rủ … ra pantry") shows the job title (`n.p.role`) as its hint.
- "Chủ tịt" is kept as the spelling (not "Chủ tịch"). No change to `name`, `HOSTN`, surprise, duo, or gossip text.
- Address conventions confirmed: Anh Bảo is the oldest in the office. Chị Ba calls Chủ tịt "anh".

### Known issues

- Nguyên's birthday never fires. His birthday offset `(13 × 5 + 3) % 65` is 3, the same as Chủ tịt's (`(0 × 5 + 3) % 65`), and `NPCS.find()` returns Chủ tịt first. See `docs/spec/the-gioi-lien-tuc.md` §7.
- The random cake party in `startDay()` can pick Nguyên on a remote day, so the party card names a coworker who is not in the office.
- The section 2 header comment in `index.html` does not describe `desk: null`, `habits.lounge`, or `habits.attendance`.

### Verification

- Headless Chrome, 2 runs with 14 NPCs (throwaway harness, not in the repo): no JS errors, no collision violations. Screenshot confirms Nguyên lying on the daybed.
- Headless Chrome re-run after the same-day changes above (2026-11-04, throwaway harness): no JS errors, no collision violations.
- Not tested on real devices, with touch input, or with audible audio. Address conventions need native-speaker review.

## v1.1.2 — 2026-11-04

### Changed

- Three more coworkers have custom stylized looks in `index.html`, built only from Three.js primitives and canvas textures. No photos, no external or Blender-made models, and no embedded images. Blender was not used.
  - Trung (`id: 'trung'`, desk 2): short black hair, thin dark rectangular glasses (`look.glasses = 'rect'`, `look.glassColor = 0x3a4048`), small mustache (`look.mustache = true`), grey-teal horizontal-striped polo (`look.pattern = 'stripe'`).
  - Tùng (`id: 'tung'`, desk 5): black hair with a side fringe (`look.style = 'fringe'`), white-lavender shirt, wide smile (`look.smile = true`).
  - Chú 7 (`id: 'an7'`, desk 9): short dark hair, no glasses (changed from grey hair with glasses), white shirt, neutral expression.
- `patternMat(kind)` in `index.html` generalizes the v1.1.1 gingham code. It draws and caches one canvas texture per kind. Kinds: `gingham` (caro) and `stripe` (horizontal stripes). The v1.1.1 entry names this function `ginghamMat()`. The current name is `patternMat('gingham')`.
- `buildCharacter()` supports `look.style = 'fringe'`, `look.mustache`, and `look.glassColor`.
- Docs: `docs/spec/mot-ngay-o-cong-ty.md` section 4.4 lists all four custom looks, and the field options.

### Verification

- Headless Chrome screenshots only (2026-11-04). Not checked on phones or other devices.
- The Trung mustache is hard to see at the default camera distance (Vừa). Not changed in this release (see `docs/tasks.md`).

## v1.1.1 — 2026-11-04

### Changed

- Thạnh ("Chủ tịt", `id: 'thanh'`) has a custom stylized look in `index.html` (`buildCharacter`, `NPC_PROFILES` `look` fields):
  - Short black hair, thin rectangular glasses (`look.glasses = 'rect'`), round face (`look.round`), wide smile (`look.smile`).
  - Black-and-white gingham shirt (`look.pattern = 'gingham'`), drawn with a canvas texture by `ginghamMat()`.
  - Built as a stylized chibi from Three.js primitives only. No photo is used or embedded, and no external model is loaded. Blender was not used, which keeps the single-file, offline requirement.
- Verification: checked only in a headless-Chrome screenshot. Not checked on devices.

## v1.1.0 — 2026-11-04

Endless play. The day cycle runs Monday to Friday, with a weekend vignette between weeks. A persistent App Dating world state (user count and app version) carries over between days, and new variety content (surprises, coworker duos, day themes, end-of-day badges, office gossip) makes each day differ. Still a single-file browser game (`index.html`).

### Added

- Calendar (section 14, `calInfo()`, `WEEKDAYS`): day N is weekday `(N-1) % 5` of week `floor((N-1)/5) + 1`. Day 1 is Thứ Hai, tuần 1. Shown in the day-start toast, in the diary entry `label`, and on the title button "▶ Tiếp tục: <weekday>, tuần N" (`refreshTitle()`).
- Weekend vignette (`weekendFlow()`, `WEEKENDS`, 8 entries). Shown after the Friday summary. The bonus is stored in `G.bonus` and applied to Monday in `newDayState()`: mood +6 to +10, energy +6 to +16.
- Persistent world state:
  - `Store.world.users` (default 12, in thousands). Grows at each summary by `round(rand(0.6, 2.4) × (1 + tasks × 0.15))`.
  - `appVersion(dn)`: the minor number rises each week (days 1–5 v1.0, 6–10 v1.1, 11–15 v1.2, 16–20 v1.3). Every 4 weeks the major number rises (day 21 → v2.0).
  - Shown in the summary (`showSummary()`), on the notice board (`noticeFlow()`), and in the Monday meeting (`mondayTopic()`).
- `Store.recentEv` (ids of the last 8 fired surprises) and `Store.lastTheme` (previous day's theme id). Used by `scheduleSurprises()` and `pickTheme()` to avoid back-to-back repeats.
- NPC birthdays: each coworker has a fixed offset `(index × 5 + 3) % 65`. On a matching day `startDay()` forces a cake party for that coworker, and the printer event is not rolled.
- Friend greetings: affinity 75 or more switches to `FRIEND_GREET` (automatic greeting always, card intro 60% of the time).
- Surprises (`SURPRISES`, `scheduleSurprises()`, `tickClock()`, `fireSurprise()`, `applyFx()`):
  - 14 events plus the mystery gift box (`gift`, handled by `giftFlow()`). Each event has 3 options with effects on mood, energy, affinity, and a diary moment.
  - 3 surprises a day, 4 on busy days. Each one fires in its own time window (09:05, 11:15, 13:40, 16:05 blocks).
  - A surprise waits while its coworker is hidden, and is dropped after 90 game-minutes.
- Coworker duos (`DUOS`, 9 pairs, used by `npcAmbient()` and `runVisit()`): scripted 3–5 line chats when a paired coworker visits. Otherwise the generic chat lines are used.
- Day themes (`DAY_THEMES`, `pickTheme()`): normal, rain, busy, chill, and milk-tea. Weighted random, excluding `lastTheme`. On Friday there is a 50% chance of milk-tea.
  - The emoji is shown after the clock (`#hud-clock`).
  - Rain: a grey, soft scene light (`applyTimeOfDay()`) and a looping rain sound (`Sfx.rain()`).
- End-of-day badges (`makeBadges()`, up to 4): shown on the summary and stored as `badges` in the diary entry.
- Office gossip on the notice board (`noticeFlow()`, `GOSSIP_A`, `GOSSIP_ACT`, `GOSSIP_THING`, `GOSSIP_END`): 55% chance of a generated gossip line, otherwise one of 5 fixed notes.
- Thạnh's milk-tea extra treats at 09:55 and 16:00 (`DAY_THEMES.milk.treats`, run by `processTimeEvents()`). The base treats at 11:05 and 14:10 still run on every day.

### Changed

- Ending removed. There is no end screen and no day cap. The 17:30 prompt ends the current day only (`processTimeEvents()`).
- Summary buttons: "☀ Sang ngày tiếp theo" (next day), or "🌙 Qua cuối tuần" on Friday. The old "Chơi ngày mới" button is gone. The same wording is used in `showSummaryAgain()`.
- Title info text: "Game không có hồi kết, cứ chơi tiếp bao lâu tùy ý." Shown after the first day.
- Energy loss per game-minute is multiplied by the theme's `decay` (`tickClock()`). The chance of a coworker visit is multiplied by the theme's `visit` (`npcAmbient()`).
- Monday's 10:00 meeting asks about the upcoming app version (`mondayTopic()`). Other days still draw from `MEETING_TOPICS`.
- Diary cap raised from 40 to 150 entries (`showSummary()` slice). New diary entry fields: `label`, `theme`, `badges`, `world`.
- Surprise texts can reference the live user count (`dating100k` replaces the phrase with `Store.world.users`).

### Save compatibility

- Save key `mot-ngay-o-cong-ty.v1` is unchanged, so existing saves still load.
- `Store` defaults add `world: { users: 12 }`, `recentEv: []`, and `lastTheme: ''`. Missing or malformed values reset to these defaults on load.
- Older diary entries have no `label`, `theme`, `badges`, or `world`. They are kept as written. Loading an older save was not separately recorded (see `docs/tasks.md`).

### Known issues

- The Friday milk-tea roll ignores `lastTheme`, so a Thursday milk-tea day can repeat on Friday.
- The weekend bonus is held in memory only. Reloading on the weekend screen drops it.
- The "Tin vui: App Dating" diary moment and two option results still say "vượt 100 nghìn lượt tải", while the card text uses the live user count.
- A surprise dropped after waiting for a hidden coworker is still recorded in `recentEv`.
- Affinity from surprise choices is saved immediately, even if the day is abandoned. The day record itself is not saved.
- Transient NPC overlap samples in the long 12-day run. All were transient (see `docs/tasks.md`).
- The Thạnh gingham look is listed under v1.1.1 above. Which release shipped it is open (see `docs/tasks.md`).

### Verification

- Headless Chrome 12-day simulated run (2026-11-04, throwaway harness, not in the repo): weekday and weekend progression correct, user count grows, themes vary, no JS errors, no collision violations except transient NPC overlap samples in the long run. All 15 surprises and every option and gift box exercised, with no raw placeholders.
- Not tested on a real phone, with real touch input, with audible audio output, on Safari or Firefox, or with a day interrupted mid-way.
- Acceptance criteria AC-27 to AC-45 are in `docs/spec/the-gioi-lien-tuc.md` and `docs/spec/noi-dung-bat-ngo.md`.

## v1.0.3 — 2026-11-04

Rename to "Một Ngày Ở MinhLee" with a MinhLee company framing, plus a content pass on four coworkers. Still a single-file browser game (`index.html`).

### Changed

- Game title and company framing:
  - `<title>` and the title-panel `h1` in `#title` read "Một Ngày Ở MinhLee". The subtitle (`p.sub`) describes MinhLee as a fictional company that builds apps and games, best known for the App Dating.
  - The old title "Một Ngày Ở Công Ty" is no longer used in the UI. Older entries in this file keep it as written.
- Office branding (section 5, `buildOffice`):
  - North-wall logo sign (`logo` canvas, `planeTex` at z −7.93) reads "💘 MinhLee" with the tagline "Apps & Games".
  - Front-door mat (`matMesh`, z 7.0, at the south door) reads "MinhLee".
- Morning desk-task mini-games (section 2, `SORT_SETS`, section 11):
  - Set 1 projects: 💘 App Dating, 🎮 Game mới, 📱 App tiện ích.
  - Set 2 projects: 📣 Quảng bá app Dating, 🧾 Sổ sách tháng, 🧑‍🎓 Đào tạo người mới.
  - The previous project names were not recorded in the docs, so this entry cannot list what they were replaced from.
- Meeting topics (`MEETING_TOPICS`, section 2): the second topic is now a partner asking to delay the App Dating feature delivery by 2 days.
- Document favor (`DOC_QUESTS`, `DOC_NAMES`, section 2): Thạnh asks for "Hợp đồng đối tác game", which is also listed in `DOC_NAMES`.
- Coworker personality (`NPC_PROFILES`, section 2):
  - Trung (`id: 'trung'`): trait "hay nói 'Em nói thiệt'"; greet, idle, chat, pantry, reply, request, and meeting lines use the catchphrase.
  - Thạnh (`id: 'thanh'`): trait "mê nhân quả, thiền, tu hành". Greet, idle, chat, pantry, and deep lines are about karma and meditation. New quirk at 13:20 (`anim: null`): eyes closed, meditating for five minutes. The existing 09:36 late-arrival quirk, `habits.arrive` 09:20, and the treat events are unchanged.
  - Thông (`id: 'thong'`, nick "Bamboo"): trait "mê bất động sản, nhà đất, đầu tư". Lines cover land plots, real estate, and investing. He still worries ahead ("lo xa"), and his lines keep returning to a backup plan ("phương án B").
  - Bảo (`id: 'bao'`): the `request.ask` now asks whether to prioritize a Dating-app matching suggestion feature or fixing the login bug.
- Save compatibility: the `Store` key stays `mot-ngay-o-cong-ty.v1`. The rename does not touch save data, and existing saves, diary entries, and affinity still load.
- Docs: `CLAUDE.md`, `docs/spec/mot-ngay-o-cong-ty.md` (file name kept on purpose), `docs/product-guide.md`, `docs/glossary.md`, `docs/tasks.md`, and this file updated to match. Glossary entries for the new terms are placeholders, and the old title entry is flagged as outdated instead of rewritten.

### Fixed

- Section 2 header comment in `index.html` now says `desk` is `0..12` (desk 12 is the lower-row center), and lists the `visitAnim` field. This closes the v1.0.2 known limitation.

### Verification

- Headless Chrome harness re-run after these changes (throwaway, not in repo): no JS errors, no collision violations, full simulated day completes. One transient NPC overlap sample was recorded in thousands of checks. It did not persist and is tracked in `docs/tasks.md`.
- The title, north-wall logo, door mat, and new meeting topic and sort sets were checked in source only. Not hand-checked in a browser.

### Known limitations

- Not tested on a real phone, with real touch input, with audible audio output, or on Safari or Firefox.
- The transient NPC overlap sample is not yet investigated (see `docs/tasks.md`).

## v1.0.2 — 2026-11-04

Thirteenth coworker, personality pass, camera presets, and a placeholder fix. Still a single-file browser game (`index.html`).

### Added

- Coworker Thông (`id: 'thong'`, nick "Bamboo", role "R&D (Research & Development)") in `NPC_PROFILES`, desk 12. The desk is the extra desk in the lower row, center (`DESKS.push({ x: 0, z: 3.5, row: 1 })` in section 5). `NPC_PROFILES` now has 13 entries and desks 0–12 are all used. Title subtitle says 13 coworkers.
- Camera presets (section 8): `CAM_PRESETS` with Gần (pitch 0.98, distance 7.5), Vừa (pitch 1.12, distance 10.5, default), and Xa (nhìn từ trên) (pitch 1.3, distance 14).
  - 🎥 HUD button (`#b-cam`) cycles the presets. `setCamPreset()` (section 14) stores the index in `Store` `settings.cam` and shows a toast. `startDay()` applies the saved preset.
- Thạnh's treat events in `processTimeEvents()` (section 14): at 11:05 (drinks) and 14:10 (snacks). Each fires once when the clock crosses its time, including on a time skip, and only if Thạnh is not hidden. Effects: +8 energy, +3 mood, +2 affinity with Thạnh, one diary moment, a toast, a chime, and a line from Thạnh.
- Profile field `visitAnim` on `NPC_PROFILES` entries (not yet listed in the section 2 header comment). `runVisit()` plays it on the visitor for 2.4 s at visit stage 0. Chị Ba sets `visitAnim: 'punch'`.
- `punch` pose in `poseCharacter()` (section 6), used by Chị Ba's quirk at 09:12 (`anim: 'punch'`) and by her visit opener.

### Changed

- Personality rewrites across the roster (`traits`, `say.*`, `reply.*`, `request`, `quirks`, `note`). Tone is friendly and playful, never hostile toward the player:
  - Yến: a little grumpy in a playful way, loves teasing (khịa), asks "Là sao?" often.
  - Chị Ba: strict in a fun way, playfully "punches" colleagues (joke). Quirk at 09:12 uses the punch animation.
  - Thạnh: kind, always helping, often late (`habits.arrive` 09:20), buys drinks and snacks for the team (treat events above).
  - Phú: unlucky, investing always loses, loves massages.
  - Trung: loves explaining, playful "lươn" tone, into business and investing, focused at work (`stats.focus` 0.95).
  - Nam: cheerful, says "khìn khìn" often.
  - Toàn: quiet, says little.
- Camera (section 8 and section 14):
  - `updateCamera()` aims 1.3 m ahead of the player along the camera's yaw, so the player can see what is coming.
  - Field of view narrowed: 58 when the aspect ratio is below 0.8 (portrait), 50 below 1.2, 44 otherwise (`camera.fov` in the resize handler).
  - Drag-to-pitch range clamped to 0.6–1.4 (`pointermove` handler).
  - Reason: the earlier low camera angle let desks hide people, and the portrait FOV was too wide.
- Documentation updated to match: `CLAUDE.md`, `docs/spec/mot-ngay-o-cong-ty.md`, `docs/product-guide.md`, `docs/glossary.md`, `docs/tasks.md`.

### Fixed

- Nam's first greeting used `{{anh}}`, which `fill()` turned into `{anh/chị}` with literal braces in the bubble. Changed to `{anh}` (`NPC_PROFILES`, Nam `say.greet[0]`). The v1.0.1 harness check looked only for `{ten}` / `{anh}` and missed this form.

### Verification

- Headless Chrome harness re-run with 13 NPCs (throwaway, not in repo): no JS errors, no collision violations, full day completes, no raw placeholders in rendered text.
- The 🎥 button, the punch animation, and the treat events were checked through the harness and screenshots only, not by hand.

### Known limitations

- Not tested on a real phone, with real touch input, with audible audio output, or on Safari or Firefox.
- Camera framing on portrait phones (FOV 58, look-ahead, pitch range) was checked only in headless Chrome.
- Section 2 header comment in `index.html` still says `desk` is `0..11`. Not edited in this docs pass (docs-only).

## v1.0.1 — 2026-11-04

Roster rename and review fixes. Still a single-file browser game (`index.html`).

### Changed

- ~~Player character is named "Bảo" by default (`#in-name` placeholder and `Store` default). Empty name input saves as "Bảo". Name is still editable on the title screen.~~ *Superseded by the player name and gender bullet below. The player is not named Bảo.*
- ~~Coworker roster reduced from 12 to 11 entries in `NPC_PROFILES`. Desks 0–10 are used, desk 11 is left empty.~~ *Superseded. `NPC_PROFILES` has 12 NPC entries, desks 0–11, all used.*
- Player name and gender selection on the title screen (`#in-name`, gender chips in `#gens`, `Store` fields `name` and `gender`):
  - The player is a brand-new employee. Name is optional, max 16 characters, with no default. An empty name is saved as empty.
  - Gender choice: Nam (`nam`), Nữ (`nu`), or Không nêu (`khac`, default). It sets the pronoun in NPC lines.
  - Empty name: NPC lines address the player as "bạn".
  - NPC lines use placeholders `{ten}`, `{anh}`, and `{Anh}`, filled by `fill()` in section 1 when bubbles and cards are rendered. `{anh}` is anh / chị / anh/chị by gender; `{Anh}` is the capitalized form.
- Bảo is a coworker NPC (Product, desk 11), not the player.
- Roster (name — nickname — department): Thạnh "Chủ tịt" (Chủ tịt, hosts the meeting); Phú "Siêu nhân may mắn" (Backend Dev); Trung, Toàn (Backend Dev); Hiện, Tùng, Nam (Mobile Dev; Nam is junior and is the one at the printer on printer days); Thảo "Bella" (HR, brings the birthday cake); Yến "Én Pink" (QC); "Chú 7" (QC, real name An); "Chị Ba" (Business Support, real name An, asks for the invoice folder); Bảo (Product, desk 11).
- Title subtitle, desk task options, and the section 11 comment now match the 12-NPC roster. Desk task options name Nam and Chị Ba.
- Old roster names removed: Chị Lan, Anh Hùng, Mai, Chị Hạnh, Tuấn, Thảo (QA), Anh Quân, Linh, Anh Đức, Chị Phương, Sơn, Vy.
- New optional profile fields `nick` and `real` in `NPC_PROFILES` (documented in the section 2 header comment). Conversation cards show real name, nickname, and department when present.
- Documentation updated to match: `CLAUDE.md`, `docs/spec/mot-ngay-o-cong-ty.md`, `docs/product-guide.md`, `docs/glossary.md`, `docs/tasks.md`.

### Fixed

- Opening the diary from the title screen no longer stops the game loop.
- Pause is now a real state: `G.mode = 'paused'` via `pauseGame()` / `resumeGame()`. Simulation and clock stop while paused.
- Visits between coworkers no longer stop after two per day.
- Pantry (and other occupied spots) are released when the player skips to a later milestone (`skipTo` → `snapNpcsToSchedule` → `releaseSpots`).
- Corrupted save data is validated on load: diary entries without `talked`/`moments` arrays are dropped, and `affinity` is reset to `{}` if it is not an object. Unreadable data falls back to defaults and is logged via `dlog`.

### Known issues

- ~~`index.html` still contains stale text: title subtitle says "12 đồng nghiệp", desk task options name "Linh" and "Chị Hạnh", and a comment says "12 bàn đồng nghiệp".~~ *Resolved in the 2026-11-04 code pass: subtitle says 12, desk task options name Nam and Chị Ba, and the section 11 comment says 12 coworker desks.*
- ~~v1.0.1 changes have not been re-run in headless Chrome yet.~~ *Re-run after the changes above: no JS errors, no collision violations, full day completes with 12 NPCs, no raw `{ten}`/`{anh}` in rendered bubbles or cards.*
- Nam's greeting in `NPC_PROFILES` (`say.greet[0]`, line 363) contains `{{anh}}`. It renders as `{anh/chị}` with literal braces. Not fixed in this doc pass. Tracked in `docs/tasks.md`.
- Still not verified: real phone, real touch input, audible audio output, Safari and Firefox.

## v1.0.0 — 2026-11-04

First release. Single-file browser game.

### Added

- Solo office-day simulation: one work day from 08:30 to 17:30, then a summary and diary entry.
- 12 fictional coworkers with individual desks, habits, personalities, and dialogue.
- Player avatar selection (4 looks) and optional name (max 16 characters).
- Daily milestones: arrive (08:30), morning task (09:00), short meeting (10:00), break (11:00), lunch (12:00), afternoon help and events (13:30), wrap-up (17:00).
- Morning task mini-games (note sorting and priority ordering), up to 3 per day.
- Short meeting at the meeting table, 10:00–10:55, with coworker reactions to the player's input.
- Pantry break and lunch with drink and meal choices; optional joining of coworkers.
- Document favor quest from 13:45, fetched from the filing cabinet.
- Daily random event: printer jam (14:30) or a small cake party (15:20–15:55).
- Wrap-up sticky note to one coworker (max 50 characters, preset or custom), then daily summary.
- Diary (last 40 days), per-coworker affinity bars, data reset from the title and diary screens.
- Keyboard controls (WASD/arrows, E/Space/Enter, P/Esc, M), mouse drag to rotate and wheel to zoom.
- Touch controls: on-screen joystick, large action button.
- In-game tutorial (3 steps, can be skipped or replayed from the pause menu).
- Pause menu with skip-to-next-milestone, fast-forward toggle (4x), mute toggle.
- Web Audio sound effects synthesized in code (no audio files).
- Save data in `localStorage` under key `mot-ngay-o-cong-ty.v1`.
- List-mode fallback (`#lite`) when WebGL is unavailable: buttons for coworkers and spots.
- Boot error message if Three.js cannot load within 10 seconds.
- Debug logging gated behind localhost or `?debug`.

### Known limitations

- Requires network on first load to fetch Three.js 0.160.0 from jsDelivr.
- Verified only in headless Chrome. Not tested on real phones, with real touch input, or with audible audio output.
