# Tasks

Last updated: 2026-11-04 (v2.2.0-alpha, multiplayer stage 2 first version, members see each other, and company mailbox phase A, not committed; before it v2.1.0-alpha, password sign-in for admin-created accounts behind the `loginEnabled` flag, multiplayer stage 1, cloud-save hardening). **Read first:** `docs/handoff.md` (next-conversation handoff: state, how to work, decisions made, next steps), then this file.

Legend: `[x]` done, `[ ]` todo, `[~]` in progress, `[!]` blocked.

## Done

Items for v1.0.0 to v1.8.8 are archived in `docs/archive/tasks-done-2026-11.md`. Done entries v1.8.2 to v1.8.6 were moved there in the v1.9.3 pass. Done entries v1.9.1 to v1.9.4 were moved there in the v1.10.0 pass. Done entries v1.9.0 and v1.9.5 were moved there in the v1.11.0 pass. Done entries v1.11.0 and v1.12.0 were moved there in the v1.14.0 pass. Done entries v1.10.0 and v1.10.1 were moved there in the v1.13.0 pass. Done entries v1.13.0 and v1.14.0 were moved there in the v1.15.0 pass. The v1.15.0 Done entry and the closed `[x]` items of the other sections were moved there in the v1.16.0 pass. The v1.16.0 Done entry was moved there in the v2.0.0-alpha pass. The v2.0.0-alpha Done entry and the closed member-reset defect were moved there in the v2.0.1-alpha pass. The v2.0.1-alpha Done entry, a closed follow-up, and a closed known defect were moved there in the v2.1.0-alpha pass. The v2.1.0-alpha Done entry, two closed known defects, a closed stage 2 follow-up, and a stale repository item were moved there in the v2.2.0-alpha pass.

- [x] v2.2.0-alpha (2026-11-04): multiplayer stage 2, first version: members see each other (one channel `office`, Presence, `pos` broadcast about 3 Hz while moving, 10 s heartbeat, nothing sent when alone, remote character drawn, its NPC hidden, peer hidden after 25 s silence). Not committed. Send rate amended before commit after the Supabase Free-plan quota check. Details: `docs/changelog.md` v2.2.0-alpha, spec `docs/spec/thay-nhau.md` (checks: AC-M40 to AC-M44, AC-M54, AC-M55, AC-M57 verified with a mocked channel; AC-M45, AC-M46, AC-M56 and AC-M47 to AC-M49 code read; open rows in Follow-ups, v2.2.0-alpha). Same release: company mailbox phase A (`docs/spec/hop-thu-cong-ty.md`, rows AC-M59 to AC-M69), built, needs `docs/sql/hop-thu.sql` run once; verified only with a mocked Supabase client

## In progress

- [~] Text pass: more natural Vietnamese wording in the content pools (`p1_data.js`), no logic change. Another agent is working on it. Noted in `docs/changelog.md` v1.9.0

## Known defects

- [ ] (v1.8.4) Not tested on a real phone. Check the lying coworker's name tag and speech bubble (Nguyên on the daybed) in portrait and landscape, under the top bar and in the notch or safe-area zone
- [ ] (v1.7.0) Root cause of the "no graphics" reports after sharing is not identified. v1.7.0 adds detection and fallbacks but does not fix a known cause. Ask the reporters for browser, version, device, and whether the page was opened inside an app. Check whether `index.html` or `index-offline.html` was used
- [ ] (v1.7.0) Players said they could open the game in Safari afterwards. The cause is not identified. Record which browser, file, and app they used
- [ ] Investigate transient NPC overlap samples: one in thousands of checks in the v1.0.3 harness run, and several in the long run of the v1.1.0 12-day harness run. All were transient, not sustained. Confirm they resolve on their own and are not a regression, for example by logging the two NPCs involved on a repeat harness run. Known minor issue for v1.1.0.
- [ ] Friday milk-tea roll in `pickTheme()` ignores `lastTheme`, so a Thursday milk-tea day can repeat on Friday. Fix by applying the `lastTheme` filter to the Friday roll too. Found by reading the code, not reproduced in the harness.
- [ ] Weekend bonus (`G.bonus`) is held in memory only. Reloading the page on the weekend screen drops the bonus. Decide whether to persist it in `Store` or accept the loss.
- [ ] "Tin vui: App Dating" (`dating100k`): the card text uses the live user count, but the diary moment and two option results still say "vượt 100 nghìn lượt tải" (fixed text). Make the wording agree.
- [ ] A surprise skipped (150 game-minutes after its time, or at 17:40 (17:10 before v1.16.0), while the player was not near the coworker) is still written to `recentEv` when the day ends, though the player never saw it. Decide whether `recentEv` should record only surprises that were shown. (Wording updated for v1.8.7; the old rule was 90 game-minutes for a hidden coworker.)
- [ ] Affinity changes from surprise choices are written at once (`saveProgress()`), so they survive an abandoned day while the day record does not. Decide whether that is intended, then document it or change it.
- [ ] Docs: `docs/spec/mot-ngay-o-cong-ty.md` section 4.4 labels the Thạnh gingham look "v1.1.1", but this release is v1.1.0. Confirm which release shipped the look and fix the label. The changelog entry for v1.1.0 mentions it with this open question.
- [ ] (v1.2.0) `index.html` section 2 header comment (around line 240) does not describe `desk: null`, `habits.lounge`, or `habits.attendance`. Update when `index.html` is next edited. Not changed in v1.2.0 (docs-only pass).
- [ ] (v1.2.0) Chị Ba's line in surprise `dammhaam` uses the real name: "Chị xin lỗi anh Thạnh!". Confirm it is intended, or change it to the in-game name convention (`docs/spec/dong-nghiep.md` §2).

## Open questions

- [ ] (v2.0.0-alpha) Choosing Guest is remembered (`localStorage['mot-ngay.guest']`), so the next start skips the sign-in screen and only "🔑 Đăng nhập công ty" on the title screen leads to sign-in. Confirm this is wanted, or show the sign-in screen again on start
- [ ] (v1.7.1) Should Chị Ba's stand-up line also fire on a "pressure" event? The brief said "when she stands up from her seat or feels pressure". The code triggers `say.stand` only when a seated coworker stands up (`setGoal()`). "Áp lực quá!" is one of its three variants. No pressure event exists. Confirm the current trigger, or name the event to add
- [ ] (v1.2.0) Toàn's age tier is still unspecified. Specify it before Toàn's address terms are changed.
- [ ] (v1.3.1) Yến's nickname "Én Pink" (`nick` in `NPC_PROFILES`, `docs/spec/dong-nghiep.md`, `docs/product-guide.md`) no longer matches her black top (v1.3.1; was pink). Cosmetic. Decide whether to keep the nickname, change it, or change the top back. Not changed in v1.3.1 (`index.html` was read-only)
- [ ] (v1.3.0) Confirm the two assumptions that are not in the floor plan: the player desk at the bottom left (left of Thông, `PLAYER_DESK`), and the meeting room at the top centre (`MEET_ROOM`). The daybed, sofa, printer, and notice board positions also follow the brief, not the SVG. See `docs/spec/van-phong-layout.md` §6
- [ ] (2026-11-04) Confirm the conversation card contents. The code shows the name, the job-title line (real name and nickname when present), affinity hearts, a status sentence, and the coworker's line. The brief said "status and the character's line" only. Docs follow the code. Decide whether the name header and hearts stay.
- [ ] (v1.4.0) Tone review of the "nhậu" content (after-work drinks, kept light). Covers Tùng's greetings, chats, note, the 17:35 quirk (16:50 before v1.16.0), duos `tung`–`phu` and `thao`–`tung`, and Tùng's dare surprise `tungthach`. The intent is light and wholesome. The user is asked to confirm the tone
- [ ] (v1.4.3) Confirm the younger-coworker list used for Chủ tịt's address style. Hiện is stated as the youngest. Chú 7, Trung, and Nguyên are assumed younger. Nam (same age as Chủ tịt) gets the humble style. Confirm or correct (`docs/spec/dong-nghiep.md` §2)

## Follow-ups

v2.2.0-alpha (multiplayer stage 2, see each other). Acceptance rows are in `docs/spec/thay-nhau.md` §7:

- [ ] (v2.2.0-alpha) Two real browsers, two accounts (AC-M50): each sees the other, both NPCs hidden. Sign one out and check the other (the NPC stays hidden until the next day). Phones and Safari (AC-M53)
- [ ] (v2.2.0-alpha) Real Supabase Realtime (AC-M51, AC-M52, AC-M58): presence and broadcast work, `RT.others` is right after a join, and the real message count with 3 or more members matches the dashboard formula (1 sent + 1 per receiver). Estimates, not measured: 5 members moving non-stop about 76 msg/s; 14 moving about 594 msg/s. The owner's "about 20 h" for 5 members needs its assumption confirmed (`docs/spec/thay-nhau.md` §6)
- [ ] (v2.2.0-alpha) Decide: the channel is public, not private (`docs/spec/thay-nhau.md` §6), whether a remote person's NPC should come back when they go offline, and how to stop the Free project pausing after 1 week without activity (sign-in and cloud save stop while paused; `docs/spec/nhieu-nguoi-choi.md` §7). Check two tabs of one account (shared Presence key)
- [ ] (v2.2.0-alpha) Company mailbox phase A (not committed; AC-M59 to AC-M69, `docs/spec/hop-thu-cong-ty.md` §9): the owner runs `docs/sql/hop-thu.sql` once in the Supabase SQL Editor, then checks two real accounts (dot, badge, inbox, RLS). Open before phase B (§7): heartbeat about 75 s, not 55 s; RLS does not restrict `done` by party; `my_char()` callable by anon; no dot on remote-person labels; tell members the owner can read all messages. Phases B to F: §8

v2.1.0-alpha (password sign-in, login flag). Acceptance rows are in `docs/spec/dang-nhap-cong-ty.md` §5:

- [ ] (v2.1.0-alpha) Real-server test (AC-M28, AC-M32): sign in with a password on an admin-created test account (use one the owner can access). The next sign-in goes straight to the welcome popup. Then `?login=off` hides the button in the same browser
- [ ] (v2.1.0-alpha) Create the 14 accounts in the dashboard (Auto Confirm, password chosen by the administrator, given in private), each with its `roster` row. Keep passwords out of the repo, the docs, and shared chats
- [ ] (v2.1.0-alpha) Optional: password change from inside the game. Not planned for the alpha. Decide whether it is needed before launch
- [ ] (v2.1.0-alpha) When the realtime tests are done: remove the flag (set `loginEnabled` to true, so the sign-in button shows for everyone) and announce it to the players. Then update the admin/tester note in `docs/product-guide.md`
- [ ] (v2.1.0-alpha) Real two-tab test (AC-M33, AC-M34): two real windows on one account. The later sign-in must take ownership, and the earlier tab must show the conflict modal and stop saving. Then press "🔄 Tải lại trang" and check the latest data. Also check save on close with keepalive (AC-M36)
- [ ] (v2.1.0-alpha) Confirm by query that `claim_character()` returns `updated_at`. Without it `CLOUD.version` is null and the conflict check is skipped. Also confirm the stored `updated_at` equals the millisecond ISO value sent (AC-M35)
- [ ] (v2.1.0-alpha) After the owner confirms the save is right, remove the diagnostic lines ("☁ Đã tải từ máy chủ", "(chẩn đoán …)") from `showWelcomeBack()` and `CLOUD.loaded` from `cloudApply()`. Then close this item
- [ ] (v2.1.0-alpha) Decide on a guest→account migration button. A guest with local progress who signs in gets only the server row, and the local guest save is not moved. Decide whether to offer a one-time copy

v2.0.1-alpha (multiplayer stage 1 fixes). Acceptance rows are in spec §9.3:

- [ ] (v2.0.1-alpha) Desk checks (AC-M18, AC-M19): screenshot the item rotation on a north-side long-table desk, and check the other 10 characters' desks (only Bảo, Toàn, Phú, Thảo were checked)
- [ ] (v2.0.1-alpha) Address check in play (AC-M20): `{ten}` as "anh Bảo", "chị Ba", "chú 7", "Chủ tịt". Native review of the lowercase start ("anh Bảo ơi…") and of `{anh}`/`{Anh}` for female members (`thao`, `yen`, `an3`). Also (v2.1.0-alpha, 2026-11-04): per-speaker pronouns. `fill()` turns "bạn" into "anh" only for the member Bảo, and NPCs still say "mình" to him where "em" is expected (`docs/spec/dong-nghiep.md` §2). Native review and play-test of the address change and the Chủ tịt order item and duo `bao`–`tung` text (code read only, not played)
- [ ] (v2.0.1-alpha) Add a `?debug` hint for testers: save errors are logged with `dlog` (localhost or `?debug` only). Decide where the hint goes (`docs/deploy.md` or the tester message) and write it
- [ ] (v2.0.1-alpha) Create and test the other 13 accounts: each invited email needs its `roster` row and a `progress` row from `claim_character()`. Only the owner's account has signed in. Any new public table needs the grants in spec §6.1. The account step for each login is in `docs/spec/dang-nhap-cong-ty.md` §3
- [ ] (v2.0.0-alpha) Confirm the server by query (AC-M10). The owner's login gave the right character, but the `progress` columns, the `roster` columns, the body of `claim_character()`, and RLS (own row only) are not re-checked
- [~] (v2.0.0-alpha) Save and restore (AC-M11): saving works (owner, 2026-11-04). Open: reload after closing the browser, a dropped connection mid-day for the retry toast and the 15 s retry, and the new 42501 toast text. Save on close and the two-tab conflict: see the v2.1.0-alpha follow-ups
- [ ] (v2.0.0-alpha) Popup visuals on desktop and phone (AC-M12). Dynamic import over the CDN in a real browser (AC-M13), and the Guest fallback when the Supabase script cannot load (AC-M8)
- [ ] (v2.0.0-alpha) Offline builds are out of date (AC-M14). Decide when to rebuild `index-offline.html` and `dist/`. Check whether `tools/build-offline.py` fails on the two-entry importmap. `CLAUDE.md` asks for a rebuild after every edit, which this release does not follow

v1.16.0 (workday ends at 18:00, farewell scene):

- [ ] (v1.16.0) View the farewell scene in a browser (screenshot or short video): the orbit, the goodbye bubbles, Toàn's line at 18:03, and the end card. Check the framing at the default preset (Vừa), and that the restored distance equals the preset (the headless run restored 10.5). `docs/spec/tan-ca-18-gio.md` §8
- [ ] (v1.16.0) Toàn's 19:00 leave is never visible in play, because the scene ends at 18:40. Decide whether it should show, or stay hidden on purpose
- [ ] (v1.16.0) Save during the scene: `Store.session` is written every 5 s, so a reload resumes at about 18:xx and runs the end of the scene again. `D.fwDone` is not saved. Decide whether to skip saves in `farewell` mode. `docs/spec/tan-ca-18-gio.md` §9
- [ ] (v1.16.0) Remaining "17:30" wording: the docs were swept in this pass. In `index.html`, the 17:30 uses (`TOD` light, `wrap`, the "half an hour left" toast, `periodGreet()`, desk-chat window) are intended. Check the sign and the on-screen text by eye
- [ ] (v1.16.0) Early-leave confirm and surprise skip moved from 17:10 to 17:40 (`CFG.END - 20`), so the door leaves without a confirm card from 17:40. Check that this is wanted, and playtest it. Also decide whether the window should be its own constant
- [ ] (v1.16.0) The `wrap` milestone is never ⏭ in play (`docs/spec/bang-nhiem-vu.md` §3.2). Decide whether it should show ✅ when the day ends
- [ ] (v1.16.0) Native-speaker review of the 14 goodbye lines (`FAREWELL_LINES`), including Chủ tịt's and Toàn's
- [ ] (v1.16.0) Touch test: the scene on a phone or tablet, the end-card button, and that no control stays locked after the scene
- [ ] (v1.16.0) Full real-time day: about 456 seconds from 08:30 to 18:00 at normal speed, then the nag, note card, and summary order. Not recorded

v1.15.0 (every coworker assigns desk work):

- [ ] (v1.15.0) Native-speaker review of about 40 new strings: the sort and order sets, the 10 work voices, and the 10 reaction lines. `docs/spec/ngoi-lam-viec.md` §5
- [ ] (v1.15.0) Balance of Chủ tịt's two order sets. He is picked for an order task 2 times in 15 sets, more than anyone else. Check that it does not feel too common. `docs/spec/ngoi-lam-viec.md` §3.4
- [ ] (v1.15.0) Hint wording. The order hint `q` reads "hạn chót gần nhất" in the four older sets and "gấp nhất" in the new ones. Pick one wording and update the sets. `docs/spec/ngoi-lam-viec.md` §5
- [ ] (v1.15.0) Play every new set to completion in a browser, and run one full day to see the end-of-day reactions of the new assigners (not recorded)

v1.14.0 (sit-and-work time-lapse, end-of-day reaction):

- [ ] (v1.14.0) "No penalty" wording. The text "không tính điểm, không bị phạt gì" is not in `index.html` (checked 2026-11-04). The docs that still said "no penalty" (`docs/spec/mot-ngay-o-cong-ty.md` AC-71, `docs/product-guide.md` 9:00 row) are updated. Confirm the in-game briefing needs no penalty line
- [ ] (v1.14.0) Tune `WORK_QUOTA` (2) and the losses (affinity −1 to −3, mood −1 to −5). Playtest how often the reaction fires over a week
- [ ] (v1.14.0) View the camera orbit in a screenshot (target (0, 0.5), distance 13, pitch 0.85). Check the framing at the default preset and after the restore
- [ ] (v1.14.0) Touch test: the overlay tap on a phone or tablet, and the time-lapse over the HUD. Check the Space and Enter keys on a keyboard-only setup
- [ ] (v1.14.0) Full real-time day (about 114 seconds of time-lapse at 08:30 to 18:00) and the end-of-day chain: time-lapse stops, then (v1.16.0) the farewell scene, the reaction, the note card, and the summary
- [ ] (v1.14.0) "▶ Bắt đầu làm" after a time-lapse calls `playerSit()` while the player is still seated. Check the sit-down animation and that the mini-game starts cleanly (code reading only)
- [ ] (v1.14.0) Early leave ("Có, mình về thôi" before 17:40; 17:10 before v1.16.0) also runs the reaction. Decide whether that is wanted
- [ ] (v1.14.0) Anh Bảo has no `WORK_VOICE` entry (generic lines). Decide whether he needs his own voice
- [ ] (v1.14.0) Native-speaker review: the nag lines, the Yến and Thảo sets and voice lines
- [ ] (v1.14.0) `CLAUDE.md` is stale. Its Status says v1.8.5, the Docs list has no `docs/spec/ngoi-lam-viec.md`, and the Editing section has no time-lapse pointer. Update by hand (doc-keeper does not edit `CLAUDE.md`)

v1.13.0 (document quest without hints):

- [ ] (v1.13.0) Native-speaker review of the new lines: the Yến and Thảo ask lines, all `WRONG_DOC` lines (5 askers, 2–3 each), and the "Hỏi lại" card. See `docs/spec/nhiem-vu-tai-lieu.md` §7
- [ ] (v1.13.0) Per-coworker "where the cabinet is" line. The reply after accepting ("Cảm ơn nhé, tủ ở góc phải phía dưới đó!", `questAsk()`) is the same for every asker. Make it per asker
- [ ] (v1.13.0) Mission-board row wording: the shipped text is "Giúp <name> tìm hồ sơ đã nhờ ở tủ tài liệu". The requested text was "Tìm hồ sơ <name> đã nhờ ở tủ tài liệu". Confirm which one is wanted
- [ ] (v1.13.0) Check "🔁 Hỏi lại" and the 5-button cabinet in a real browser, and run a full afternoon to see whether players miss the quest without hints

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
- [ ] Test on a real phone and real touch input (not emulated): touch joystick, tap action button, drag-to-rotate, safe-area layout, orientation change. Test audio output on real devices, including the mute toggle and audio unlock on first tap. Test on Safari, Firefox, and Android Chrome (only headless Chrome was run)
- [ ] Hand-test the 🎥 camera button (cycle Gần / Vừa / Xa, and that the choice persists after reload) and the camera framing on a portrait phone (FOV 58, look-ahead 1.3 m, pitch 0.6–1.4). Checked only through the harness, screenshots, and headless Chrome
- [ ] Hand-test in a real browser: Chị Ba's punch animation (quirk at 09:12 and visit opener), Thạnh's treat events at 11:05 and 14:10 (energy and mood change, toast, diary moment), and Thạnh's 13:20 meditation quirk (eyes closed, line appears, no animation). Checked only through the harness and screenshots
- [ ] Visually check the title, north-wall "MinhLee" sign, and front-door "MinhLee" mat in a browser (text readable, not clipped). Checked in source only
- [ ] (v1.4.1) Visually check the Phú, Nam, and Anh Bảo looks on a real device at the default camera distance (Vừa). Checked only in isolated headless-Chrome close-ups. Check the thin rect glasses and the plaid shirt
- [ ] (v1.8.5, partly closed in v1.8.6) Looks not yet built from a photo: Hiện. Toàn and Thông were updated from photos in v1.8.6. Bảo's look is still an approximation from a verbal description. Ask the user for photos before replacing these looks
- [ ] (v1.8.5) Visually check Nguyên's new look (black side fringe, black top, no glasses) on a real device at the default camera distance (Vừa). Checked only in a headless-Chrome screenshot on the daybed
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
- [ ] Check diary and data reset flows (AC-14 in `docs/spec/mot-ngay-o-cong-ty.md`), not recorded in the headless run. Check title-screen name and gender paths: empty name (NPCs say "bạn"), each gender option (anh / chị / anh/chị) in rendered lines. Not separately recorded
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

Goal card and mission board (v1.8.0), `docs/spec/bang-nhiem-vu.md` §7:

- [ ] (v1.8.0) Not tested on a real phone. Check the goal card's tap target, the 16px text, and its position under the top bar and notch (safe area), in portrait and landscape (MB-6)
- [ ] (v1.8.0) Wording of the goal card, the mission board, and "Đã qua, không sao cả, ngày vẫn tiếp tục" not reviewed by a native Vietnamese speaker (MB-7)
- [ ] (v1.8.0) The goal card is a `div` with a click handler, not a button. It cannot be reached with Tab or opened with Enter or Space. Decide whether to add `role="button"`, `tabindex="0"`, and a key handler. P, Esc, and ⏸ already pause
- [ ] (v1.8.0) The "Kết thúc ngày" (`wrap`) milestone, 17:30 since v1.16.0 (17:00 before), never shows ⏭ (its `done()` is always false). Decide whether it should show ✅ when the player leaves

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

Help text (v1.8.3), `docs/spec/tuong-thich-trinh-duyet.md` §3 and §5 (CP-12 to CP-14):

- [ ] (v1.8.3) Hand-check every help message on the real affected machines: Safari on iPhone and Mac, updated Chrome on Android and Windows, an in-app browser (Zalo, Messenger) on a real phone, and Chrome with hardware acceleration off (CP-14)
- [ ] (v1.8.3) Native-speaker review of the new suggestion wording: too-old message, in-app banner, boot-error text, WebGL title note, switch toast, and list-mode note. Vietnamese wording not reviewed by a native speaker
- [ ] (v1.8.3) Check whether the Safari / Chrome suggestion helps the "no graphics" reports. The cause is still unidentified (see Known defects, v1.7.0)
- [ ] (v1.8.3) Re-run the headless Chrome check (WebGL creation forced to fail: title note, toast, list-mode note, boot-error text) on the next release. The v1.8.3 run is recorded only as reported by the requester

Desk work and looks (v1.8.6), `docs/spec/mot-ngay-o-cong-ty.md` AC-71 to AC-73, §4.4, and `docs/spec/bang-nhiem-vu.md` §2:

- [ ] (v1.8.6) Not tested on a real phone. Check the work card, "Cách làm" box, progress bar, and option chips at 500 px and in portrait
- [ ] (v1.8.6) Hand-check in a real browser: pause mid-task (both buttons), resume (same set, done items, order), and that the task is cleared at a new day. Headless Chrome only
- [ ] (v1.8.6) Decide whether `D.work` should survive a reload or quit. It lives in memory (`D`), so an unfinished task is lost, the same as the rest of the day
- [ ] (v1.8.6) Check the desk label on a real phone: pinned to a side edge when the desk is off-screen sideways, hidden under the top bar and near the bottom, hidden after 3 tasks
- [ ] (v1.8.6) Native-speaker review of the new Vietnamese: work card briefings (`workBrief()`), "Cách làm" steps, `SORT_SETS.descs`, hint texts, the morning hint, the reply lines, and "Đang nhờ bạn"
- [ ] (v1.8.6, still open at v1.8.7) `tools/macapp/Info.plist` and `dist/MinhLee.app/Contents/Info.plist` still read `CFBundleShortVersionString` 1.8.5. Set both to 1.8.7 (the current release) on the next macOS rebuild. Not changed in the v1.8.7 docs pass
- [ ] (v1.8.6) Look-check Thông, Thảo, and Toàn at the default camera distance (Vừa) on a real device. Headless Chrome only

Surprise trigger (v1.8.7), `docs/spec/noi-dung-bat-ngo.md` §1 and AC-40:

- [ ] (v1.8.7) Check the proximity trigger on a real phone (touch movement) and in Safari, Firefox, and Android Chrome. Headless Chrome only (far: not fired; near: fired)
- [ ] (v1.8.7) Playtest the 4.2 m radius and the 150-game-minute window (and the 17:40 cut-off, 17:10 before v1.16.0). Not tuned. Check that players do not miss most surprises, and that the no-npc surprises (`wifi`, `gift`) feel right
- [ ] (v1.8.7) Native-speaker review of the three narration strings changed from "ông" to "anh" for Chủ tịt in `SURPRISES`

Detailed looks (v1.9.2), `docs/spec/dong-nghiep.md` §8:

- [ ] (v1.9.2) Look-check Thạnh, Phú, Thảo, Yến, and Thông at the default camera distance (Vừa) on a real device. Headless Chrome lineup only
- [ ] (v1.9.2) Likeness check of the five detailed looks against the reference photos, side by side. Yến, Thạnh, and Phú were re-matched by eye in v1.9.3; Thảo and Thông not re-checked
- [ ] (v1.9.4) Likeness check against the reference photos, side by side, for Trung, Toàn, Hiện, Tùng, Nam, Chú 7, Chị Ba, Anh Bảo, and Nguyên. Their looks were upgraded without a photo re-check. Some may need colour or shape changes
- [ ] (v1.9.4) Look-check all nine on a real device at the default camera distance (Vừa). Headless Chrome lineup only. Check Chị Ba's glasses and Hiện's round glasses, which are the most visible changes
- [ ] (v1.9.4) Confirm Chị Ba's gruff, flat mouth (no smile) against her reference photo. It was set from the description, not re-checked

## Blocked (none)
