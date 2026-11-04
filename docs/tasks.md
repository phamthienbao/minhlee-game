# Tasks

Last updated: 2026-11-04 (v1.12.0, pantry table pass)

Legend: `[x]` done, `[ ]` todo, `[~]` in progress, `[!]` blocked.

## Done

Items for v1.0.0 to v1.8.8 are archived in `docs/archive/tasks-done-2026-11.md`. Done entries v1.8.2 to v1.8.6 were moved there in the v1.9.3 pass. Done entries v1.9.1 to v1.9.4 were moved there in the v1.10.0 pass. Done entries v1.9.0 and v1.9.5 were moved there in the v1.11.0 pass.

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

## In progress

- [~] Text pass: more natural Vietnamese wording in the content pools (`p1_data.js`), no logic change. Another agent is working on it. Noted in `docs/changelog.md` v1.9.0

## Known defects

- [x] (v1.10.0, closed 2026-11-04) Anh Bảo's shirt colour is not a defect. The red-and-white striped shirt (`pattern: 'redwhite'`, `index.html` line 481) is intentional, per the user's explicit request for this release. The solid polo of the first brief is not used. The look is recorded in `docs/spec/dong-nghiep.md` §8
- [x] (v1.10.0, closed 2026-11-04) Nguyên–Chị Thảo duo scripts (`nguyen`→`thao`, `index.html` `DUOS`) never played. Fixed in `npcAmbient()`: a sofa-seated Nguyên may start a visit, to Chị Thảo only, who must be seated at `desk:work`. Headless: 6 of 6 runs. Not tested on a real device
- [x] (v1.10.0, closed 2026-11-04) The arrival toast was reworded; later removed entirely in v1.11.0 at the user's request (`index.html`, `processTimeEvents()`)
- [ ] (v1.8.4) Not tested on a real phone. Check the lying coworker's name tag and speech bubble (Nguyên on the daybed) in portrait and landscape, under the top bar and in the notch or safe-area zone
- [x] (v1.8.4, closed 2026-11-04) The ambient on-screen gate in `tryNpcSay()` (`index.html`, `Bubbles.onScreen(n.pos.x, root.y + 1.8, n.pos.z)`) still tests the standing point at the coworker's position, not `npcAnchor()`. For a lying coworker the gate can pass while the bubble anchor is off screen (the bubble is then hidden), or block a bubble that would be visible. Found by reading the code, not reproduced. Decide whether the gate should use `npcHead(n)`. Not changed in v1.8.4 (scope: anchors only) **Fixed:** `Bubbles.onScreen()` now gets `npcAnchor(n, …, false)`, the same point as the bubble. Not reproduced in a browser; checked by reading the code.
- [ ] (v1.7.0) Root cause of the "no graphics" reports after sharing is not identified. v1.7.0 adds detection and fallbacks but does not fix a known cause. Ask the reporters for browser, version, device, and whether the page was opened inside an app. Check whether `index.html` or `index-offline.html` was used
- [ ] (v1.7.0) Players said they could open the game in Safari afterwards. The cause is not identified. Record which browser, file, and app they used
- [ ] Investigate transient NPC overlap samples: one in thousands of checks in the v1.0.3 harness run, and several in the long run of the v1.1.0 12-day harness run. All were transient, not sustained. Confirm they resolve on their own and are not a regression, for example by logging the two NPCs involved on a repeat harness run. Known minor issue for v1.1.0.
- [ ] Friday milk-tea roll in `pickTheme()` ignores `lastTheme`, so a Thursday milk-tea day can repeat on Friday. Fix by applying the `lastTheme` filter to the Friday roll too. Found by reading the code, not reproduced in the harness.
- [ ] Weekend bonus (`G.bonus`) is held in memory only. Reloading the page on the weekend screen drops the bonus. Decide whether to persist it in `Store` or accept the loss.
- [ ] "Tin vui: App Dating" (`dating100k`): the card text uses the live user count, but the diary moment and two option results still say "vượt 100 nghìn lượt tải" (fixed text). Make the wording agree.
- [ ] A surprise skipped (150 game-minutes after its time, or at 17:10, while the player was not near the coworker) is still written to `recentEv` when the day ends, though the player never saw it. Decide whether `recentEv` should record only surprises that were shown. (Wording updated for v1.8.7; the old rule was 90 game-minutes for a hidden coworker.)
- [ ] Affinity changes from surprise choices are written at once (`saveProgress()`), so they survive an abandoned day while the day record does not. Decide whether that is intended, then document it or change it.
- [x] (v1.1.2, resolved 2026-11-04 in source) `index.html` section 2 field comment (around line 239) lists `style` values without `'fringe'` and does not mention `mustache`, `glassColor`, or `pattern: 'stripe'`. Update the comment when `index.html` is next edited. Not changed in v1.1.2 (`index.html` was read-only). Checked 2026-11-04: the header now lists `fringe`, `glassColor`, `mustache`, and `pattern` `'stripe'`
- [ ] Docs: `docs/spec/mot-ngay-o-cong-ty.md` section 4.4 labels the Thạnh gingham look "v1.1.1", but this release is v1.1.0. Confirm which release shipped the look and fix the label. The changelog entry for v1.1.0 mentions it with this open question.
- [x] (v1.2.0, fixed v1.3.0) Nguyên's birthday never fired. His offset `(13 × 5 + 3) % 65` = 3 equalled Chủ tịt's offset, and `NPCS.find()` returned Chủ tịt first. Fixed: offset is `(index × 4 + 3) % 65`, unique per coworker (Nguyên = 55). `docs/spec/the-gioi-lien-tuc.md` §7 and AC-35 updated. Not yet confirmed over a 65-day run (see Follow-ups).
- [x] (v1.2.0, fixed v1.3.0) The random cake party in `startDay()` could pick Nguyên on a remote day. The pick is now `NPCS.filter(n.id !== 'thao' && n.times.arrive < 99999)`, so remote coworkers are excluded. Found by reading the code, not reproduced.
- [ ] (v1.2.0) `index.html` section 2 header comment (around line 240) does not describe `desk: null`, `habits.lounge`, or `habits.attendance`. Update when `index.html` is next edited. Not changed in v1.2.0 (docs-only pass).
- [ ] (v1.2.0) Chị Ba's line in surprise `dammhaam` uses the real name: "Chị xin lỗi anh Thạnh!". Confirm it is intended, or change it to the in-game name convention (`docs/spec/dong-nghiep.md` §2).
- [x] `{{anh}}` defect in Nam's greeting, fixed in v1.0.2 (see Done).
- [x] (v1.4.3, resolved in source 2026-11-04, v1.4.4) Surprise `dating100k`, option 1 now reads "Em mời trà sữa!"
- [x] (v1.4.4, closed v1.6.0) Yến's greeting `say.greet[1]` ("Mới sáng ra đã… là sao?") is now tagged `@am`, and a `@pm` greeting was added. Source check only (`index.html` line 402)

## Open questions

- [x] (resolved 2026-11-04, v1.8.1, per the user) Who is "bé Hạnh"? Nam's teasing nickname for Chủ tịt (Thạnh). Serious work talk uses "Thạnh". Was: who or what is "bé Hạnh"? It appears in 3 of Nam's `say.absent` lines ("Nhớ bé Hạnh ghê…", "Nhớ bé Hạnh… với cả ly trà sữa của Chủ tịt nữa"). The game does not explain it, so the answer is recorded only in `docs/spec/dong-nghiep.md` §1–2 and the glossary (annotated v1.8.1). Whether to explain it in the game itself is still open
- [ ] (v1.7.1) Should Chị Ba's stand-up line also fire on a "pressure" event? The brief said "when she stands up from her seat or feels pressure". The code triggers `say.stand` only when a seated coworker stands up (`setGoal()`). "Áp lực quá!" is one of its three variants. No pressure event exists. Confirm the current trigger, or name the event to add
- [x] (closed 2026-11-04) Nguyên's role is `Designer` (confirmed). No gender is recorded: none was stated, so the "assumed male" note is removed. `role` in `NPC_PROFILES`, the product guide, and the glossary are updated.
- [x] (closed 2026-11-04) Nam is the same age as Chủ tịt and Chị Ba. His lines are peer-level (mình / bạn). Recorded in `docs/spec/dong-nghiep.md` §2.
- [ ] (v1.2.0) Toàn's age tier is still unspecified. Specify it before Toàn's address terms are changed.
- [x] (closed 2026-11-04) Spelling confirmed: "Chủ tịt", not "Chủ tịch". No code or text change needed.
- [x] (closed 2026-11-04) Reading confirmed: Anh Bảo is the oldest and is called "Anh Bảo". Chị Ba calls Chủ tịt "anh".
- [ ] (v1.3.1) Yến's nickname "Én Pink" (`nick` in `NPC_PROFILES`, `docs/spec/dong-nghiep.md`, `docs/product-guide.md`) no longer matches her black top (v1.3.1; was pink). Cosmetic. Decide whether to keep the nickname, change it, or change the top back. Not changed in v1.3.1 (`index.html` was read-only)
- [ ] (v1.3.0) Confirm the two assumptions that are not in the floor plan: the player desk at the bottom left (left of Thông, `PLAYER_DESK`), and the meeting room at the top centre (`MEET_ROOM`). The daybed, sofa, printer, and notice board positions also follow the brief, not the SVG. See `docs/spec/van-phong-layout.md` §6
- [ ] (2026-11-04) Confirm the conversation card contents. The code shows the name, the job-title line (real name and nickname when present), affinity hearts, a status sentence, and the coworker's line. The brief said "status and the character's line" only. Docs follow the code. Decide whether the name header and hearts stay.
- [x] (v1.4.0, closed 2026-11-04 in v1.4.3) Duo `an7`–`thong` (Chú 7 and Thông): the backup and worry lines are removed. Rewritten to the tea persona ("Thông ơi, uống trà không? Ô long mới…")
- [ ] (v1.4.0) Tone review of the "nhậu" content (after-work drinks, kept light). Covers Tùng's greetings, chats, note, the 16:50 quirk, duos `tung`–`phu` and `thao`–`tung`, and Tùng's dare surprise `tungthach`. The intent is light and wholesome. The user is asked to confirm the tone
- [ ] (v1.4.3) Confirm the younger-coworker list used for Chủ tịt's address style. Hiện is stated as the youngest. Chú 7, Trung, and Nguyên are assumed younger. Nam (same age as Chủ tịt) gets the humble style. Confirm or correct (`docs/spec/dong-nghiep.md` §2)

## Follow-ups

v1.12.0 (takeaway cups, pantry gathering):

- [ ] (v1.12.0) Cup visibility at the default camera distance (Vừa). Cups are small and hidden behind bodies from the default angle. Check at Vừa and the other presets. Decide whether to enlarge the cups or change the desk cup position
- [ ] (v1.12.0) More than 8 people gathering. `startTreat()` caps the group at 8, the number of `PANTRY_SPOTS`. Decide what the rest do (wait at their desk, a second spot, or stand near the pantry). Today the 9th and later people get a desk cup instead
- [ ] (v1.12.0) Cup for the player. The player holds no cup during a treat. Decide whether they get one, and whether a cup on the player's own desk is wanted
- [ ] (v1.12.0) Ice cubes on the iced coffee and `cafeden` cups are barely visible. Check by eye, and enlarge or add contrast if needed
- [ ] (v1.12.0) Real device check (phone, Safari, Firefox): the cup in hand, the sip animation, and the desk cups
- [ ] (v1.12.0) Full-day playtest: how often the pantry gathering fills all 8 spots at 11:05, and whether the walks to the pantry jam the walkway (z 1.3 to 3.3)
- [ ] (v1.12.0) Crowding around the pantry table at peak. The 8-spot ring (rx 1.05, rz 0.85) sits between the table and the counter and fridge. Check for NPC jams at 11:05 and 14:10
- [ ] (v1.12.0) Table vs the player's pantry spot. The table is a collision obstacle. Check that the player can reach all 8 spots and walk around the table
- [ ] (v1.12.0) Dish look on a real device. Dish sizes are exaggerated for readability. Check the four dishes and the table cups at the default camera distance, on a desktop and a phone

v1.11.0 (office layout: desk 13, Tùng, Nguyên at desk 8):

- [ ] (v1.11.0) Tune the spacing and pathing of desk 13 (x −4.4, lower row next to Thông's desk 9). Check walks to its visit point (−2.9, 5.83) and past `COLUMNS[1]` (x −1.77), and that the chairs do not clip the desks
- [ ] (v1.11.0) Full-day playtest: how often Trung visits Nguyên at his desk (40% per attempt, the v1.10.0 figure), whether Nguyên's single nap (30–50 min after lunch) feels right, and whether the two of them sit at the right-hand table without overlap
- [ ] (v1.11.0) `CLAUDE.md` is stale. Its Editing section still says desks 0–12 and "Nguyên desk null". The doc-keeper does not edit `CLAUDE.md`. Update it by hand

v1.10.0 (mid-day save, Nguyên, Anh Bảo):

- [ ] (v1.10.0) Export and import of the save (download and upload of the `Store` JSON). Storage is per origin and device: the file path, Netlify, GitHub Pages, the Mac app, and each browser keep separate saves. Open follow-up from the user's request
- [ ] (v1.10.0) Tune the nap: length (30–50 min) and start (55–80 min after lunch starts). Set by simulation only. Check that the sofa share feels right in play (obsolete as of v1.11.0: Nguyên works at his desk, not on a sofa. Nap tuning is still open)
- [ ] (v1.10.0) Native-speaker review of Nguyên's new lines ("Chị Thảo ơi, nay có ai mời nước không?", the 10:35 quirk, the two `nguyen`→`thao` scripts, the two `trung`→`nguyen` scripts)
- [ ] (v1.10.0) Anh Bảo's look: check it by eye against the reference photo and on a real device at the default camera distance (Vừa)
- [ ] (v1.10.0) Tune the stripe thickness of Anh Bảo's shirt. `patternMat('redwhite')` draws 8 px red bands with 8 px off-white gaps on a 64 px texture. Check by eye at the default camera distance and adjust the band height if it reads too busy
- [ ] (v1.10.0) Welcome-back popup: test a real browser restart (close the tab or app, reopen, and check the popup), and a real phone. Headless Chrome only so far
- [ ] (v1.10.0) Confirm the four copies are identical apart from the importmap and comment lines (`diff index.html index-offline.html`; `dist/netlify/index.html` and `dist/MinhLee.app/Contents/Resources/index.html` by diff). Only the grep check was run in the doc pass
- [ ] (v1.10.0) `tools/macapp/Info.plist` `CFBundleShortVersionString` is still 1.8.5. Set it to 1.10.0 and rebuild `dist/MinhLee-mac.zip` with `tools/build-mac-app.sh`
- [ ] (v1.10.0) Tune the 40% chance that Trung visits Nguyên (`npcAmbient()`, `index.html` line ~1734). Headless only: 1 of 6 short runs. Playtest a full day and check how often the visit happens
- [x] (v1.10.0, resolved v1.11.0) `npcAmbient()` pushed Nguyên into `duoC` twice (once by the `filter`, once explicitly), so he has double weight among the duo partners. Resolved in v1.11.0: `cands` excludes Nguyên for Trung, and the 40% gate adds him once

Diary intro (v1.7.2):

- [ ] (v1.7.2) Native-speaker review of the diary intro lines in `showDiary()` (section 13). The wording was written without review
- [ ] (v1.7.2) Check the diary intro on a real phone and desktop browser (touch, Safari, Firefox). Headless Chrome only

Verification gaps:

- [ ] (v1.7.1) Hand-check Chị Ba's stand-up in a real browser: the chance on a normal day (about 55%), the 90% rate on a `busy` day, the 60 s cooldown, the 1.8 s reply from Chú 7, and that the line is hidden when she is off screen or more than 9.5 m away. Checked only in headless Chrome, and the reply path was not recorded separately
- [ ] (v1.7.1) Hand-check Nam's `say.absent` lines: they stop when Chủ tịt arrives at about 09:20, stop when Nam leaves his desk, and the bubble does not overlap others. Checked only in headless Chrome (2+ lines in the first 50 game minutes)
- [ ] (v1.7.1) Check `dist/netlify/index.html` on Netlify after the next drop. The file was built from `index-offline.html` (byte-identical), but the upload itself was not checked
- [ ] (v1.6.1) Hand-check the afternoon quest with the new document name, and the sort-game set 2 and ordering item, in a real browser. Checked only through the headless harness (quest flow completes)
- [ ] (v1.6.1) Hand-check Chị Ba's 09:48 quirk (`anim: 'check'`) and the Chị Ba–Nam duo visit (lines, bubbles). Checked only in the headless harness
- [ ] (v1.6.1) Run `dist/MinhLee.app --selftest` on the rebuilt app. Not recorded for this release
- [ ] (v1.2.0) Hand-check Nguyên in a real browser: 10:15 arrival on office days, the lie pose on the daybed, the arrival toast, and walking around the daybed. Checked only in headless Chrome and one screenshot
- [ ] (v1.2.0) Measure the about-50% attendance over a long run (for example, 20 or more game days). The v1.2.0 harness runs did not record the rate
- [ ] (v1.4.3) Hand-check the humble lines in a real browser: Chủ tịt's greeting, idle, and chat bubbles, the treat bubble at 11:05 and 14:10, the Thảo–Chủ tịt duo, and the Chú 7–Thông visit. Checked only in the headless harness (surprises, duos, placeholders, JS errors)
- [ ] (v1.4.4) Hand-check speech bubbles on a real phone at the default camera distance (Vừa): anchored above the head, hidden when the head is under the top bar or off-screen, no edge pinning. Checked only in headless Chrome
- [ ] (v1.4.2) Hand-check the cat content in a real browser: the plush on Chủ tịt's desk (desk 1, at the default camera distance), the 12:50 quirk, the `cat` and `thanhmeo` cards, and the Chủ tịt–Hiện duo visit (lines, bubbles). The v1.4.2 harness checked surprises and placeholders only, not the duo visit or the plush
- [ ] (v1.4.0) Hand-check the three new duos (Chú 7–Chị Ba, Tùng–Phú, Thảo–Tùng) and the three new surprises (`thaoquan`, `tungthach`, `khiatra`): cards, options, visits, bubbles. Checked only in the headless harness
- [ ] (v1.2.0) Hand-check the new duos Thảo–Yến and Hiện–Anh Bảo (visit, lines, bubbles)
- [ ] (v1.2.0) Native-speaker review of the address conventions, Hiện's rewritten lines, and the rewritten Nam and Chị Ba–Nam lines
- [ ] (v1.2.0) Record the previous coordinates of the two relocated pantry spots, if they are needed for reference. Not recorded in v1.2.0
- [ ] Test on a real phone: touch joystick, tap action button, drag-to-rotate, safe-area layout, orientation change
- [ ] Test real touch input (not emulated) on a touch device
- [ ] Test audio output on real devices, including mute toggle and audio unlock on first tap
- [ ] Test on Safari, Firefox, and Android Chrome (only headless Chrome was run)
- [ ] Hand-test the 🎥 camera button (cycle Gần / Vừa / Xa, and that the choice persists after reload). Checked only through the harness and screenshots
- [ ] Hand-test the camera framing on a portrait phone (FOV 58, look-ahead 1.3 m, pitch 0.6–1.4). Checked only in headless Chrome
- [ ] Hand-test Chị Ba's punch animation (quirk at 09:12 and visit opener). Checked only through the harness and screenshots
- [ ] Hand-test Thạnh's treat events at 11:05 and 14:10 (energy and mood change, toast, diary moment). Checked only through the harness and screenshots
- [ ] Hand-test Thạnh's 13:20 meditation quirk (eyes closed, line appears, no animation)
- [ ] Visually check the title, north-wall "MinhLee" sign, and front-door "MinhLee" mat in a browser (text readable, not clipped). Checked in source only
- [ ] (v1.4.1) Visually check the Phú, Nam, and Anh Bảo looks on a real device at the default camera distance (Vừa). Checked only in isolated headless-Chrome close-ups. Check the thin rect glasses and the plaid shirt
- [x] (v1.4.1, closed in v1.9.5 by eye) Anh Bảo's look was an approximation from a written brief. Re-matched to the user's photo in v1.9.5. Side-by-side likeness check still open (v1.9.5 item)
- [ ] (v1.8.5, partly closed in v1.8.6) Looks not yet built from a photo: Hiện. Toàn and Thông were updated from photos in v1.8.6. Bảo's look is still an approximation from a verbal description. Ask the user for photos before replacing these looks
- [ ] (v1.8.5) Visually check Nguyên's new look (black side fringe, black top, no glasses) on a real device at the default camera distance (Vừa). Checked only in a headless-Chrome screenshot on the daybed
- [x] (v1.8.5, closed 2026-11-04) Macintosh app version: `tools/macapp/Info.plist` and `dist/MinhLee.app/Contents/Info.plist` read `CFBundleShortVersionString` 1.8.5
- [x] (v1.8.5, closed 2026-11-04) Changelog entries for v1.8.1 and v1.8.4 exist (they were out of order and were reordered; no numbers skipped)
- [ ] (v1.3.1) Visually check the Yến, Chị Ba, and Thảo looks on a real device. Checked only in headless-Chrome screenshots. Check the Yến and Chị Ba glasses at the default camera distance (Vừa)
- [ ] Visually check Thạnh's custom look (v1.1.1: short hair, rect glasses, round face, wide smile, gingham shirt) on a real device. Checked only in a headless-Chrome screenshot
- [ ] (v1.1.2) Visually check Trung, Tùng, and Chú 7 looks on a real device. Checked only in headless-Chrome screenshots
- [ ] (v1.1.2) Trung's mustache is hard to see at the default camera distance (Vừa). Options: a larger mustache mesh, or a closer default preset. Decide after a device check. Not changed in v1.1.2
- [ ] Optional, for higher fidelity: a Blender-made GLB of Thạnh embedded as base64. Trade-offs: larger `index.html`, and it breaks the "no external models" rule in `docs/spec/mot-ngay-o-cong-ty.md` section 4.4. Decide before starting
- [ ] Check Thông at desk 9 visually (v1.3.0: moved from desk 12): seat, chair, and walking paths around the lower row, left end
- [ ] (v1.3.0) Hand-check the office against the floor plan in a real browser: long-table seating and facing, lower row, door on the east wall, meeting room, columns. Checked in headless-Chrome screenshots and by eye. Not measured against the SVG
- [ ] (v1.3.0) Check the walkway (z 1.3 to 3.3) and both columns for path blocking on a longer run. The 75-second lunch simulation reached the pantry. The full-day run had one transient overlap sample
- [ ] (v1.3.0) Check that the decorative items (plants, windows, posters, wall clock, calendar, logo) do not clash with the new layout. Positions are from v1.2.0
- [ ] (v1.3.0) Confirm the new pacing by hand: 55-minute lunch, 16-minute coffee windows, and 1.9 walk speed. Not measured in a long run
- [ ] (v1.3.0) Confirm the birthday fix over a 65-day cycle (for example, a save with a set day count): Nguyên's birthday fires on `dn % 65 = 55` when he is in the office, and the cake pick never names a remote coworker. Not run
- [ ] Check diary and data reset flows (AC-14 in `docs/spec/mot-ngay-o-cong-ty.md`), not recorded in the headless run
- [ ] Check title-screen name and gender paths: empty name (NPCs say "bạn"), each gender option (anh / chị / anh/chị) in rendered lines. Not separately recorded
- [ ] (v1.1.0) Interrupted day: quit or reload in the middle of a day and confirm the unfinished day is not saved to the diary. Not tested
- [ ] (v1.1.0) Load a v1.0.3 save under v1.1.0 (no `world`, `recentEv`, `lastTheme`; diary entries without `label`, `theme`, `badges`, `world`). Open the diary and start a day. Not recorded
- [ ] (v1.1.0) Source-only items that need a hand check in a browser: title button label, rain light and rain sound, notice-board world line, version in the summary, Monday meeting card, duo lines and the visit animation, badge chips. Not recorded
- [ ] (v1.1.0) Long-run items not covered by the 12-day harness run: the 65-day birthday cycle, the 150-entry diary cap, and the 90-minute drop for a hidden coworker. Needs a longer harness run or a save with a set day count

Product and content:

- [ ] (v1.7.1) Native-speaker review of the new Vietnamese: Chị Ba's three `say.stand` lines and her "thằng bánh tét" wording, Chú 7's reply "Dạ có em đây chị Ba! (nép sau ly trà)", Chú 7's "bánh tét" chat line, and Nam's five `say.absent` lines. Vietnamese wording not reviewed by a native speaker
- [ ] (v1.6.1) Native-speaker review of Chị Ba's rewritten Vietnamese: greetings, idle, chat, pantry, deep, reply, meeting, both quirks, note lines, the desk request (survey report with 40 respondents and its three options), the document quest ask, the sort-game set 2 text, the ordering item, and duo `an3`–`nam`. Vietnamese wording not reviewed by a native speaker
- [ ] (v1.6.1) Confirm the survey request reads as intended: a 40-person sample, honestly flagged as small. The options and the "40 người cực kỳ ủng hộ" joke line are the points to check
- [ ] (v1.4.4) Native-speaker review of the time-tagged greetings, the "Đang họp" line, the three treat-bubble texts, and the quirk `ctx` choices. Vietnamese wording not reviewed by a native speaker
- [ ] (v1.4.3) Native-speaker review of the humble-style Vietnamese: Chủ tịt's lines (all categories), the treat bubble, the `DOC_QUESTS` ask, surprise texts with Chủ tịt lines, and duos `thanh`–`hien`, `thao`–`thanh`, `an7`–`thong`. Vietnamese wording not reviewed by a native speaker
- [ ] (v1.4.2) Native-speaker review of the new cat text: Chủ tịt's greeting, idle, chat, and pantry lines, the 12:50 quirk, surprises `cat` and `thanhmeo` (titles, texts, options), the Chủ tịt–Hiện duo, and the gossip item "tấm ảnh mèo của Chủ tịt". Vietnamese wording not reviewed by a native speaker
- [ ] (v1.4.0) Native-speaker review of the new text: 3 surprises (`thaoquan`, `tungthach`, `khiatra`), 3 duo scripts, and the Thảo, Tùng, and Chú 7 lines (greetings, chats, pantry, requests, quirks). Includes the colloquial "ngon hết sảy" in `thaoquan`
- [ ] (v1.2.0) Glossary curation: new terms appended at the end (Anh Bảo, Thạnh (real name), Xưng hô, Nguyên, Làm từ xa, Giường nằm, LOUNGE_SEAT, habits.lounge, habits.attendance, lie). Placeholders `Bảo`, `Chủ tịt`, `Biệt danh (nick)`, and `Tên thật (real)` now have factual definitions (2026-11-04) for a human to review. New placeholders: `Chức danh (job title)`, `traits`, `Mình / bạn (peer address)`, `tui / ông (same-age banter)`
- [ ] (v1.3.0) Glossary: layout terms (`DOOR`, `LONG_TABLES`, `DESKS`, `PLAYER_DESK`, `COLUMNS`, `MEET_ROOM`, `MEET_TABLE`, `MEET_SEATS`, `SOFA_SEATS`, `PRINTER_SPOT`, `buildOffice()`, `buildSpots()`, `planX`/`planZ`, and the floor-plan terms) were appended as placeholders. Curate them
- [ ] Native-speaker review of Vietnamese UI text and dialogue, including the v1.0.2 personality rewrites (Yến "là sao", Chị Ba "đấm", Nam "khìn khìn") and the v1.0.3 lines (Trung "Em nói thiệt", Thạnh's karma and meditation lines, Thông's real estate lines, the App Dating meeting topic, sort-game project names)
- [ ] Decide how to handle first-load dependency on the Three.js CDN (options: vendor the library, or add a service worker for offline first load). Current behavior: network needed once. (v1.5.0) Partly addressed: `index-offline.html` vendors Three.js. `index.html` still loads from the CDN; decide whether it should switch
- [ ] Curate glossary definitions in `docs/glossary.md`. Still placeholders: the v1.0.3 terms (`Một Ngày Ở MinhLee`, `MinhLee`, `App Dating`, `Em nói thiệt`, `Nhân quả`, `Hợp đồng đối tác game`, `Chủ đề họp`, `Bộ sắp xếp dự án`). Also the v1.1.0 terms (endless world, week, weekday, weekend vignette, user count, app version, Monday meeting, birthday cycle, friend, surprise, gift box, duo, day theme, rain and milk-tea days, badge, office gossip, notice board, `recentEv`, `lastTheme`)
- [ ] (v1.1.0) Native-speaker review of the new text: 15 surprise texts and options, gift-box outcomes, 9 duo scripts, 8 weekend vignettes, gossip pools (`GOSSIP_*`), Monday meeting topic, day-theme names and descriptions, `FRIEND_GREET` lines
- [ ] (v1.1.0) Endless-play balance not yet reviewed by real players: surprise frequency (3–4 a day), energy decay per theme, user-count growth (+1 to +3 thousand a day), weekend bonus size, and visit and duo frequency. Needs real players over several days in a row

Naming decision (open):

- [ ] Decide whether to rename `docs/spec/mot-ngay-o-cong-ty.md` and the save key `mot-ngay-o-cong-ty.v1`. Both still use the old slug. The save key is kept on purpose: changing it would hide existing saves unless a migration is written. Leave as-is unless a migration is planned

Repository:

- [ ] Project is not a git repository; decide whether to initialize one (affects future changelog and pre-commit doc checks)
- [ ] No root `CHANGELOG.md` exists. Release notes live in `docs/changelog.md`. Decide whether a root file is wanted

Distribution (v1.5.0):

- [ ] (v1.5.0) Not tested in Safari, Firefox, or mobile browsers. Data-URL import maps are supported in current Chrome, Firefox, and Safari, but this was only verified in headless Chrome
- [ ] (v1.5.0) `index-offline.html` must be regenerated after every edit to `index.html`: `python3 tools/build-offline.py`. Nothing enforces this; a pre-commit check could compare the two files
- [ ] (v1.5.0) Check whether save data (`localStorage`) is shared between `index.html` and `index-offline.html` in the same browser. Not tested
- [ ] (v1.5.0) Open `index-offline.html` from a USB stick or intranet share on a real machine. Not tested

Nam and Chủ tịt (v1.8.1 and v1.8.2), `docs/spec/dong-nghiep.md` §1–2 and `docs/spec/noi-dung-bat-ngo.md` §2:

- [ ] (v1.8.2) Native-speaker review of the serious Nam–Thạnh script (4 lines) and the 09:42 quirk. Vietnamese wording not reviewed by a native speaker
- [ ] (v1.8.1) Native-speaker review of the "bé Hạnh" teasing lines (`say.idle`, `say.chat`, the playful duo). Vietnamese wording not reviewed by a native speaker
- [ ] (v1.8.2) Hand-check in a real browser: Nam–Thạnh visits (both scripts appear over several days, bubbles, visit end). Checked only in the headless harness
- [ ] (v1.8.2) Measure the random script pick over a longer run (the split between the two Nam–Thạnh scripts is not recorded)
- [x] (v1.8.1, closed 2026-11-04) The changelog v1.8.1 entry exists (it was out of order and is now between v1.8.2 and v1.8.0)

Goal card and mission board (v1.8.0), `docs/spec/bang-nhiem-vu.md` §7:

- [ ] (v1.8.0) Not tested on a real phone. Check the goal card's tap target, the 16px text, and its position under the top bar and notch (safe area), in portrait and landscape (MB-6)
- [ ] (v1.8.0) Wording of the goal card, the mission board, and "Đã qua, không sao cả, ngày vẫn tiếp tục" not reviewed by a native Vietnamese speaker (MB-7)
- [ ] (v1.8.0) The goal card is a `div` with a click handler, not a button. It cannot be reached with Tab or opened with Enter or Space. Decide whether to add `role="button"`, `tabindex="0"`, and a key handler. P, Esc, and ⏸ already pause
- [ ] (v1.8.0) The 17:00 "Kết thúc ngày" milestone never shows ⏭ (its `done()` is always false). Decide whether it should show ✅ when the player leaves

macOS app (v1.6.0), `docs/spec/phan-phoi-offline.md` §8:

- [ ] (v1.6.0) Not notarized, ad-hoc signed only. Other Macs show a Gatekeeper warning on first open (right-click > Open, or `xattr` if "damaged"; see `docs/deploy.md` option 4). Decide whether an Apple Developer ID and notarization are worth it
- [ ] (v1.6.0) Tested only on arm64, macOS 27. Not tested on Intel Macs (the x86_64 slice is checked with `lipo -info` only) or on other macOS versions. `Info.plist` says minimum macOS 11.0, untested
- [ ] (v1.6.0) `dist/MinhLee.app` and `dist/MinhLee-mac.zip` must be rebuilt after every edit to `index.html`: run `python3 tools/build-offline.py` and `tools/build-mac-app.sh`. The script rebuilds `index-offline.html` too. Nothing enforces this
- [ ] (v1.6.0) Windows build not done. Windows coworkers use `index-offline.html` (option 3). A separate Electron or WebView2 build is not started
- [ ] (v1.6.0) App icon checked as a file only (`AppIcon.icns`, valid icns). Check it in Finder, the Dock, and the window title bar
- [ ] (v1.6.0) Window appearance not checked by eye
- [ ] (v1.6.0) Audio output inside the app not tested
- [ ] (v1.6.0) Keyboard play inside the app not tested by hand (the self-test clicked the start button only)
- [ ] (v1.6.0) Not recorded: Edit > Paste into the name field, Toàn màn hình (Ctrl+Cmd+F), Tải lại game (Cmd+R), closing the window quits the app, and the load-failure alert. Check each by hand
- [ ] (v1.6.0) Gatekeeper steps not tested on a second Mac (`docs/deploy.md` option 4)
- [x] (v1.6.0, closed in v1.8.5) `tools/macapp/Info.plist` `CFBundleShortVersionString` now reads 1.8.5 (it read 1.6.0 at v1.7.0 and 1.8.0 through v1.8.4). `CFBundleVersion` is still 1 by design
- [ ] (v1.6.0) `tools/macapp/main.swift`: the comment on `mediaTypesRequiringUserActionForPlayback = []` says audio starts after the first tap. An empty list lets media play without a user gesture. Check the real behavior, then fix the comment or the setting
- [ ] (v1.6.0) `--selftest` (and its `print` calls) is compiled into the release binary. Decide whether to gate it behind `#if DEBUG`
- [ ] (v1.6.0) The app keeps its own save in its WebKit storage, separate from browser saves. Not tested whether it shares a save with `index-offline.html` in a browser (cf. AC-O8)
- [ ] (v1.6.0) `dist/.build` holds intermediate binaries. Do not send it. This project is not a git repository, so there is no `.gitignore` for `dist/` yet
- [ ] (v1.6.0) Yến's greeting time windows: `greet[1]` should show only before 11:00 and `greet[3]` only from 13:30. Source check only, not run in a browser

Compatibility (v1.7.0), `docs/spec/tuong-thich-trinh-duyet.md`:

- [ ] (v1.7.0) Test in older Safari (below 16.4) and iOS Safari. Expect the too-old message (CP-1) and no game
- [ ] (v1.7.0) Test in Firefox 108+, Edge 89+, and Android Chrome. Only Safari 27 and headless Chrome were run
- [ ] (v1.7.0) Test the in-app banner (CP-2) in Zalo, Messenger, Instagram, TikTok, Line, WeChat, and Snapchat on a real phone. Source check only
- [ ] (v1.7.0) Confirm `#env-note` stays hidden in Safari 27 and Chrome. `noMap` is also true when `HTMLScriptElement.supports` is missing
- [ ] (v1.7.0) Test a real failing GPU or WebGL disabled by policy (Chrome flag, Firefox setting). Current fallbacks were simulated only (CP-3, CP-5, CP-6)
- [ ] (v1.7.0) Check the title-screen toggle `#btn-lite` in both directions, and that the choice survives reload (CP-4, button part)
- [ ] (v1.7.0) Hand-check the toasts and list mode in a real browser: context lost after 4 s, render watchdog, and the switch message (9 s since v1.8.3; 6 s before)
- [ ] (v1.7.0) Record which file (`index.html` or `index-offline.html`) was loaded for the Safari 27 render check (CP-8)
- [ ] (v1.7.0) Decide whether to build a classic (non-module) bundle for browsers below the module and import-map minimums. Optional follow-up
- [ ] (v1.7.0) The render watchdog checks one frame only (the 150th counted frame). Decide whether it should check continuously
- [ ] (v1.7.0) On a slow connection, `#boot-error` appears 10 s after load if Three.js has not loaded yet, and hides once the game starts. Check this on a slow network, so players are not told to fix a connection that is only slow
- [x] (v1.7.0, closed v1.8.3) `tools/prepare-netlify.sh` writes `dist/netlify/index.html` (a copy of the offline file). Now described in `docs/deploy.md` option 2 (checked in the doc pass)

Help text (v1.8.3), `docs/spec/tuong-thich-trinh-duyet.md` §3 and §5 (CP-12 to CP-14):

- [ ] (v1.8.3) Hand-check every help message on the real affected machines: Safari on iPhone and Mac, updated Chrome on Android and Windows, an in-app browser (Zalo, Messenger) on a real phone, and Chrome with hardware acceleration off (CP-14)
- [ ] (v1.8.3) Native-speaker review of the new suggestion wording: too-old message, in-app banner, boot-error text, WebGL title note, switch toast, and list-mode note. Vietnamese wording not reviewed by a native speaker
- [x] (v1.8.3, accepted as-is 2026-11-04) Boot-error text: tip ① is "mở bằng Safari, hoặc cập nhật Chrome lên bản mới nhất", placed first after the lead-in "Game chưa khởi động được. Bạn thử:". Accepted as-is
- [ ] (v1.8.3) Check whether the Safari / Chrome suggestion helps the "no graphics" reports. The cause is still unidentified (see Known defects, v1.7.0)
- [ ] (v1.8.3) Re-run the headless Chrome check (WebGL creation forced to fail: title note, toast, list-mode note, boot-error text) on the next release. The v1.8.3 run is recorded only as reported by the requester

Desk work and looks (v1.8.6), `docs/spec/mot-ngay-o-cong-ty.md` AC-71 to AC-73, §4.4, and `docs/spec/bang-nhiem-vu.md` §2:

- [ ] (v1.8.6) Not tested on a real phone. Check the work card, "Cách làm" box, progress bar, and option chips at 500 px and in portrait
- [ ] (v1.8.6) Hand-check in a real browser: pause mid-task (both buttons), resume (same set, done items, order), and that the task is cleared at a new day. Headless Chrome only
- [ ] (v1.8.6) Decide whether `D.work` should survive a reload or quit. It lives in memory (`D`), so an unfinished task is lost, the same as the rest of the day
- [ ] (v1.8.6) Check the desk label on a real phone: pinned to a side edge when the desk is off-screen sideways, hidden under the top bar and near the bottom, hidden after 3 tasks
- [ ] (v1.8.6) Native-speaker review of the new Vietnamese: work card briefings (`workBrief()`), "Cách làm" steps, `SORT_SETS.descs`, hint texts, the morning hint, the reply lines, and "Đang nhờ bạn"
- [x] (v1.8.6, Toàn's polo collar closed 2026-11-04 in v1.9.4) Photo gaps: Toàn's collar is now modelled as a navy `collar` (Thảo's wavy hair closed in v1.9.2). No desk-3 plant pot was found in the code. Confirm with the user whether that is acceptable or needs a new style
- [ ] (v1.8.6, still open at v1.8.7) `tools/macapp/Info.plist` and `dist/MinhLee.app/Contents/Info.plist` still read `CFBundleShortVersionString` 1.8.5. Set both to 1.8.7 (the current release) on the next macOS rebuild. Not changed in the v1.8.7 docs pass
- [ ] (v1.8.6) Look-check Thông, Thảo, and Toàn at the default camera distance (Vừa) on a real device. Headless Chrome only

Surprise trigger (v1.8.7), `docs/spec/noi-dung-bat-ngo.md` §1 and AC-40:

- [ ] (v1.8.7) Check the proximity trigger on a real phone (touch movement) and in Safari, Firefox, and Android Chrome. Headless Chrome only (far: not fired; near: fired)
- [ ] (v1.8.7) Playtest the 4.2 m radius and the 150-game-minute window (and the 17:10 cut-off). Not tuned. Check that players do not miss most surprises, and that the no-npc surprises (`wifi`, `gift`) feel right
- [ ] (v1.8.7) Native-speaker review of the three narration strings changed from "ông" to "anh" for Chủ tịt in `SURPRISES`

Detailed looks (v1.9.2), `docs/spec/dong-nghiep.md` §8:

- [ ] (v1.9.2) Look-check Thạnh, Phú, Thảo, Yến, and Thông at the default camera distance (Vừa) on a real device. Headless Chrome lineup only
- [ ] (v1.9.2) Likeness check of the five detailed looks against the reference photos, side by side. Yến, Thạnh, and Phú were re-matched by eye in v1.9.3; Thảo and Thông not re-checked
- [x] (v1.9.2, closed 2026-11-04 in v1.9.4) Next batch: all remaining coworkers are on `look.detail`. Anh Bảo's look is still an approximation (see the v1.4.1 item)
- [ ] (v1.9.4) Likeness check against the reference photos, side by side, for Trung, Toàn, Hiện, Tùng, Nam, Chú 7, Chị Ba, Anh Bảo, and Nguyên. Their looks were upgraded without a photo re-check. Some may need colour or shape changes
- [ ] (v1.9.4) Look-check all nine on a real device at the default camera distance (Vừa). Headless Chrome lineup only. Check Chị Ba's glasses and Hiện's round glasses, which are the most visible changes
- [ ] (v1.9.4) Confirm Chị Ba's gruff, flat mouth (no smile) against her reference photo. It was set from the description, not re-checked

## Blocked

- [!] None
