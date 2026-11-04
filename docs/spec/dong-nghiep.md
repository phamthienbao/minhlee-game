# Spec: Đồng nghiệp (coworkers, address terms, remote worker)

Status: v1.16.0 (2026-11-04). Leave times: 18:00 for most coworkers, Chủ tịt 18:12 (leaves last), Toàn 19:00 (stays after the farewell scene), see `docs/spec/tan-ca-18-gio.md` §3. Tùng's quirk moved to 17:35. Earlier: v1.15.0 (2026-11-04). All 14 coworkers assign desk work, each with a work voice and a reaction line. Earlier: v1.14.0 (2026-11-04). Yến and Thảo assign desk tasks, so the work voice and the end-of-day reactions per assigner are in `docs/spec/ngoi-lam-viec.md` §3 (file-size split). Earlier: v1.13.0 (2026-11-04). Wrong-document reactions per coworker (§7.7, `docs/spec/nhiem-vu-tai-lieu.md`). Detailed looks moved to `docs/spec/ngoai-hinh-dong-nghiep.md` (file-size split). Earlier: v1.12.0 (2026-11-04). Chủ tịt's treats name a random drink and come with cups (§7.4). Anh Bảo's desk has an iced black coffee cup (§1). Earlier: v1.11.0 (2026-11-04). Nguyên sits at desk 8 (Tùng's old seat) and works there, with one daybed nap after lunch (§3, AC-49). Tùng moved to desk 13. Trung may visit Nguyên at his desk (§3, AC-86). Looks: `docs/spec/ngoai-hinh-dong-nghiep.md`. Earlier history: `docs/changelog.md`.

## 1. Roster

14 computer-controlled coworkers. The in-game name is `name`. `real` and `nick` are shown on the conversation card when present.

`traits` is a maintainer note in `NPC_PROFILES` and is not shown anywhere in the game. The conversation card shows the name, the real name and nickname (when present), the job title (`role`), affinity hearts, a status sentence, and the coworker's own line. The invite list ("Rủ … ra pantry") shows the job title as its hint.

| # | In-game name | Real name / nickname | Team | Desk | Notes |
|---|---|---|---|---|---|
| 1 | Chủ tịt | real: Thạnh | Leadership (chủ tịt) | 1 | Hosts the 10:00 meeting. Arrives 09:20. Humble speech since v1.4.3 (§2). Nam calls him "bé Hạnh" when teasing (v1.8.1) and "Thạnh" in serious work talk (v1.8.2). Treat events (see `noi-dung-bat-ngo.md` §3.1). 11:05 treat picks trà sữa, rau má, or nước mía (v1.12.0). Cat lover: his cat is called Nhân Quả (v1.4.2; cat canon with Chị Ba in §2). Quirk 12:50 (looks at cat photos). Cat plush on his desk. Surprises `cat` and `thanhmeo` (see `noi-dung-bat-ngo.md` §1.1) |
| 2 | Phú | nick: Siêu nhân may mắn | Backend Dev | 0 | Unlucky; loves investing and massages. Left table, north |
| 3 | Trung | — | Backend Dev | 4 | Catchphrase "Em nói thiệt". Custom look (v1.1.2). Right table, north. Visits Nguyên (v1.10.0, §3) |
| 4 | Toàn | — | Backend Dev | 3 | Quiet, says little. Left table, south |
| 5 | Hiện | — | Mobile Dev | 5 | Youngest. Refers to self as "em". Right table, north |
| 6 | Tùng | — | Mobile Dev | 13 | Often invites people out for a light after-work drink (nhậu, kept light). Likes dares and challenge games: the request is to say "MinhLee" ten times in a row. Quirk 17:35 calls for nhậu (v1.16.0; was 16:50). Custom look (v1.1.2). Lower row, next to Thông (v1.11.0; was desk 8, right table, south) |
| 7 | Nam | — | Mobile Dev | 6 | At the printer on printer days. "khìn khìn". Same age as Chủ tịt and Chị Ba (confirmed 2026-11-04). Calls Chủ tịt "bé Hạnh" when teasing (playful duo, `say.absent`, v1.8.1) and "Thạnh" in serious work talk (serious duo; quirk 09:42, "Thạnh ơi, 10 giờ họp nhé…", v1.8.2). Before Chủ tịt arrives (09:20), he sometimes says lines about missing him and jokes about him being late (`say.absent`, §7.5). Right table, north |
| 8 | Thảo | nick: Bella | HR | 11 | The office foodie: knows many restaurants, drink shops, and good dishes. Greetings, chats, and requests are about food. Assigns desk tasks from v1.14.0 (`ngoi-lam-viec.md` §3.4) Quirk 11:40 recommends a lunch place. Brings the birthday cake. Lower row |
| 9 | Yến | nick: Én Pink | QC | 12 | "Là sao?". Lower row, right end. Assigns desk tasks (bug sorting) from v1.14.0 (`ngoi-lam-viec.md` §3.4) |
| 10 | Chú 7 | real: An (male) | QC | 7 | Young ("Chú" is a nickname). Loves tea (trà ô long, trà sen). Often teases Chị Ba, who answers with playful punches. Tea duo with Thông (v1.4.3). Custom look (v1.1.2). Right table, south. Chị Ba's teasing nickname for him is "bánh tét" (chat line, v1.7.1). When Chị Ba stands up and calls for "thằng bánh tét", he answers from behind his tea (`say.standReply`, §7.5) |
| 11 | Chị Ba | real: An (female) | Business Support | 10 | Supports product research: runs user surveys, builds reports, analyses the numbers. Strict in a fun way, and playfully "punches" colleagues (`visitAnim: 'punch'`, quirk 09:12). Quirk 09:48 re-checks charts before the meeting. Desk request: a survey report with only 40 respondents, and the options are to state the small sample, write it honestly, or overstate it as a joke. Afternoon quest: fetch "Báo cáo khảo sát người dùng" (`DOC_QUESTS`). Duo with Nam about survey data he forgot to send (`noi-dung-bat-ngo.md` §2). Golden cat Nghệ, not allergic (§2, v1.9.5). Same age as Chủ tịt and Nam. Stand-up catchphrase (v1.7.1): "Bực bội quá… thằng bánh tét đâu rồi!" (§7.5). Lower row |
| 12 | Anh Bảo | real: Bảo | Product | 2 | Oldest in the office. Asks "vì sao". Red-and-white striped shirt with black polo collar and white cuffs, swept hair (`ngoai-hinh-dong-nghiep.md`, v1.10.0). Desk has an iced black coffee cup (`cafeden`, v1.12.0). Left table, south |
| 13 | Thông | nick: Bamboo | R&D | 9 | Lower row, left end (bottom-left of the office) |
| 14 | Nguyên | — | Designer | 8 (v1.11.0) | Works remotely. In the office on about half of the days. Naps once for 30–50 min after lunch on the daybed, otherwise works at desk 8 (right table, south, next to Chú 7). Visits Chị Thảo (§3) |

All 14 coworkers have a desk, numbered 0–13 (`DESKS` index). Desks 0–3 are the left long table, 4–8 the right long table, and 9–13 the lower row (since v1.3.0; desk 13 added in v1.11.0). The player's own desk is a separate spot (`Bàn của bạn`) at the bottom left. Seat positions: `docs/spec/van-phong-layout.md` §3.

## 2. Address conventions

Coworkers mostly address each other by first name. These are the special cases:

| Who | Rule | Where it appears |
|---|---|---|
| Anh Bảo (Bảo) | The oldest. Others call him "Anh Bảo" | Surprises, duos, gossip, meeting lines |
| Chủ tịt (Thạnh) | Others call him "Chủ tịt" in game text. Nam calls him "Thạnh" in serious work talk (serious duo, quirk 09:42, v1.8.2) and "bé Hạnh" when teasing (playful duo, `say.absent`, v1.8.1). Cat lines and the cat surprises `cat` and `thanhmeo` (cat named Nhân Quả). Duo with Hiện about cats and games. Shown as "Chủ tịt" on cards, with real name Thạnh. Spelling is "Chủ tịt", not "Chủ tịch" (confirmed 2026-11-04) | Meeting host text (`HOSTN`), surprises, duos, gossip |
| Chủ tịt (Thạnh), speech (v1.4.3) | Humble style. Himself: "em". Most people, including the player (`{anh}`) and in group talk: "anh" / "chị". Normal "anh" / "em" with the younger coworkers below and with Chị Ba. Nam (same age) gets the humble style. Duo `thanh`–`hien` keeps "anh" | Greetings, idle, chat, pantry, request, reply, meeting, quirks, notes, treat bubble, duo lines, surprises, the document ask (`DOC_QUESTS`) |
| Younger coworkers (for Chủ tịt's speech) | Hiện (stated youngest). Chú 7, Trung, and Nguyên are assumed younger (not stated, to confirm, see `docs/tasks.md`) | Chủ tịt's speech above |
| Chị Ba (An, female) | Calls Chủ tịt "anh" (same age). Her line in surprise `dammhaam` uses the real name: "Chị xin lỗi anh Thạnh!". **Cats (v1.9.5 canon):** Chị Ba is NOT allergic to cats. Her golden cat is named Nghệ. Chủ tịt's cat is Nhân Quả. The two tease each other about whose cat is better (mock-gruff, friendly) | Surprise `dammhaam`; `th-cat` intro (`noi-dung-bat-ngo.md` §3.2); `say.chat` (Nghệ line); duos `an3`–`thanh` and `thanh`–`an3` (§7.6) |
| Chú 7 (An, male) | Called "Chú 7". "Chú" is a nickname, not an age term. Chú 7 is young (confirmed 2026-11-04). Teases Chị Ba in surprise `khiatra` and in the 09:46 quirk | Profile name, surprise `khiatra` |
| Chị Ba → Chú 7 (v1.7.1) | Chị Ba's teasing nickname for Chú 7 is "bánh tét" (in her stand-up line and his chat line). Chú 7 answers her call with "Dạ có em đây chị Ba!" ("em", respectful to her) | `say.stand` and `say.standReply` on `an3`, chat line on `an7` |
| Ages | Anh Bảo is the oldest. Chủ tịt, Nam, and Chị Ba are the same age (confirmed 2026-11-04). Chú 7 is young (confirmed 2026-11-04). Toàn's age tier is not specified. Other ages are not recorded | — |
| Yến, Thông, Thảo, Tùng, Phú | Peers. Use first names. Thảo calls Yến "chị Yến" (duo `thao-yen`) | Duos |
| Hiện | Youngest. Refers to self as "em" and to others as anh / chị. Lines rewritten in v1.2.0 | Greet, pantry, chat, request, note lines |
| Nam | Peer-level lines (mình / bạn). No deferential "em" or "ạ". Keeps "khìn khìn". Same-age banter with Chị Ba (tui / ông) in duo `an3`–`nam`. Toward Chủ tịt (Thạnh): "Thạnh" in serious work lines (v1.8.2), "bé Hạnh" when teasing (v1.8.1) | Greet, pantry, chat, request, duo lines |

The player is addressed with `{anh}` / `{Anh}` by gender (`fill()`, see `mot-ngay-o-cong-ty.md` §4.2). That rule is unchanged.

## 3. Remote worker: Nguyên

- Profile: `id: 'nguyen'`, `role: 'Designer'`, `desk: 8` (v1.11.0; `null` before, with no desk). No gender is recorded: no gender field, none stated, and no `{anh}` / `{Anh}` in his lines.
- Habits: `arrive: '10:15'`, `leave: '18:00'` (v1.16.0; was 17:00), `coffee: 'morning'`, `lunch: 'pantry'`, `joinsMeeting: false`, `lounge: true`, `attendance: 0.5`.
- Attendance: `resetNpcDay()` rolls `Math.random() > attendance` each day. On a remote day `times.arrive` is 99999, so Nguyên stays hidden all day. On about 50% of days he comes in (raised from 0.3 on 2026-11-04).
- In office (v1.11.0): `decideGoal()` runs meeting, events, lunch, coffee, visits, then the nap window (`times.nap`: one window of 30–50 min, starting 55–80 min after lunch starts, set in `resetNpcDay()`). In that window he lies on `LOUNGE_SEAT` (pose `lie`). Otherwise he sits at desk 8 (`desk:work`, pose `type`). Lunch and coffee still use pantry spots. Before v1.11.0 he had no desk and worked on a pantry sofa (simulated over 30 days: sofa work ≈71%, lying ≈10%, other ≈19%). The sofa branch in `decideGoal()` now runs only for a `habits.lounge` coworker with no desk, which nobody is. `goalLounge()` does not check occupancy, so only one coworker may use the daybed (only Nguyên does).
- Visits (`npcAmbient()`): Nguyên may start a visit from his desk, or from a sofa seat, but only to Chị Thảo, who must be at `desk:work`. He never visits from the daybed. Trung may visit him (v1.10.0; desk since v1.11.0): when Trung is at `desk:work` in a visit window, each attempt has a 40% chance to add Nguyên as a partner, if Nguyên is at `desk:work`, on a sofa seat, or on the daybed. Nguyên at his desk is kept out of Trung's normal candidate list, so he enters only through this gate. Trung walks to desk 8's visit point (`DESKS[8].visit`, east of the seat). Lines and duo scripts: `docs/spec/noi-dung-bat-ngo.md` §2.
- Daybed (moved in v1.3.0 to the north wall, east of the pantry): obstacle at (−4.6, −6.9), 1.8 × 1.0 m (`addObst`). Scene parts: teal frame, cream mattress, orange pillow. Built in section 5, `buildOffice()`. `PANTRY_SPOTS` has 8 standing spots (two moved in v1.2.0; old coordinates not recorded). No arrival toast (removed in v1.11.0 at the user's request). Quirk: 11:20, "(nằm dài ở pantry, mắt lim dim)", no animation.

## 4. Profile fields added in v1.2.0

| Field | Type | Meaning |
|---|---|---|
| `desk` | number or `null` | Desk index 0–13. `null`: no desk, and `goalDesk()` returns `goalLounge()`. No coworker is `null` since v1.11.0 |
| `habits.lounge` | boolean | Nap window on the daybed, otherwise desk work (since v1.11.0). Limits visits to Chị Thảo only |
| `habits.attendance` | number 0–1 | Chance of coming in on a given day. Missing means always in |

The section 2 header comment in `index.html` does not describe these three fields yet (see `docs/tasks.md`).

## 5. Acceptance criteria

Status legend as in `docs/spec/mot-ngay-o-cong-ty.md` section 3.

| # | Criterion | Status |
|---|---|---|
| AC-46 | `NPC_PROFILES` has 14 entries, each with a unique desk 0–13 (v1.11.0; before, 13 had desks 0–12 and Nguyên had `desk: null`). The title subtitle says 14 coworkers. | Verified (v1.11.0, headless Chrome: `DESKS.length` 14). Subtitle checked in source only |
| AC-47 | Address conventions (§2) appear in rendered lines. No old names (Thạnh, Bảo) appear in rendered text, except Chị Ba's "anh Thạnh" line. | Not recorded (source only). Native-speaker review pending. v1.4.3 source check: one Chủ tịt line in surprise `dating100k` still uses "Anh" (see §6) |
| AC-48 | Nguyên is in the office on about 50% of days. On other days he never appears. | Not recorded (source only). Rate not measured |
| AC-49 | On an office day Nguyên arrives about 10:15 (no arrival toast since v1.11.0). He naps on the daybed once for 30–50 min after lunch and otherwise works at desk 8 (v1.11.0). | Partly verified (v1.11.0, headless Chrome: at 10:00 `desk:work` at (8.1, −0.8), nap goal `lounge`, screenshot at desk 8). Arrival time not recorded. Full-day split not measured since v1.11.0; the v1.10.0 sofa split (§3) no longer applies |
| AC-50 | The daybed is an obstacle. No collision violations with 14 NPCs. | Verified (two headless runs, plus a re-run after the 2026-11-04 changes: no JS errors, no collision violations). Transient NPC overlaps: see `mot-ngay-o-cong-ty.md` AC-4 |
| AC-51 | Duos `thao-yen` and `hien-bao` play their scripted lines when those pairs visit. | Not recorded (source only) |
| AC-61 | Bubbles sit above the speaker's head. If that point is off-screen, under the top bar, or in the bottom margin, the bubble is hidden, not pinned to the edge. Ambient bubbles are not started for coworkers outside the viewport (§7.1). | Reported verified (headless Chrome: `Bubbles.onScreen` true for visible coworkers, false for off-screen). Not checked on a real phone |
| AC-62 | Quirks with a `ctx` speak only in that context. Pantry lines at the pantry, "Đang họp" during the meeting, greeting or idle lines otherwise (§7.2). | Reported verified (headless Chrome: `ctx` true and false cases). Native-speaker review pending |
| AC-63 | Time-tagged lines appear only in their window (§7.3). No tag text appears in rendered lines. | Reported verified (no tag leaks, no morning-only phrase in afternoon greetings). The source contradiction found in v1.4.4 (Yến's untagged greeting "Mới sáng ra đã…") is closed in v1.6.0 (§6). Source check only for v1.6.0 |
| AC-64 | Chủ tịt's treat bubble matches his activity: pantry, desk, or other (§7.4). | Source check only (2026-11-04). Not run in a browser |
| AC-65 | Chị Ba's stand-up line (`say.stand`) fires on about 55% of stand-ups, about 90% on a `busy` day, at most once per 60 s, and only when she is on screen within 9.5 m of the player (§7.5). | Partly verified (headless Chrome, 2026-11-04): fired 11 of 12 forced attempts on a `busy` day. Chance on normal days and the 60 s cooldown not recorded |
| AC-66 | Nam says a `say.absent` line (from 5 lines) while Chủ tịt has not arrived and Nam is seated at his desk, and stops once Chủ tịt arrives (§7.5). | Partly verified (headless Chrome, 2026-11-04): 2 or more lines in the first 50 game minutes while Chủ tịt was hidden. Stop at arrival not recorded. Wording not reviewed by a native speaker |
| AC-67 | Nam's 09:42 quirk ("Thạnh ơi, 10 giờ họp nhé…") shows once per day in its 09:42–09:50 window, while Nam is seated at his desk, within 9.5 m of the player, and on screen (§7.2). | Not recorded (source only, v1.8.2). Native-speaker review pending |
| AC-68 | Duo `nam`–`thanh` plays both scripts across visits: the serious one ("Thạnh, màn hình đăng nhập…") and the playful one ("Bé Hạnh ơi…"), chosen at random per visit (`noi-dung-bat-ngo.md` AC-69). | Not recorded (source only, v1.8.2). The full-day headless run reported no JS errors and valid ids. Per-line playback not recorded |
| AC-70 | A lying coworker (Nguyên on the pantry daybed) has his name tag on the body (0.6 m toward the head, 0.75 m high) and his speech bubble at the head end (1.05 m toward the head, 0.85 m high), not at standing height (§7.1). Standing and seated anchors are unchanged. | Reported (requester, v1.8.4): headless-Chrome screenshot shows both placed correctly. Not re-run in the doc pass. Not checked on a real phone. The ambient gate uses the same anchor (code check, 2026-11-04) |
| AC-86 | (v1.11.0) Trung visits Nguyên at desk 8: 40% per visit attempt while Nguyên is at `desk:work`, on a sofa seat, or on the daybed. Nguyên at his desk is not in Trung's normal candidate list. Nguyên visits only Chị Thảo | Source check only (2026-11-04). Not run after v1.11.0. Earlier: 1 of 6 headless runs (v1.10.0, from the sofa) |

## 6. Known issues

- All earlier items are resolved (v1.3.0 to v1.6.0): Nguyên's birthday offset and the cake-pick exclusion, Chú 7–Thông backup lines (v1.4.3), `dating100k` option 1 wording (v1.4.4), Yến's untagged `@am` greeting (v1.6.0). Details: `docs/changelog.md`, `docs/tasks.md`.

## 7. Lines and speech bubbles (v1.4.4)

Source of truth in `index.html`: `pickSay()` and `fill()` (section 1), `Bubbles` and `Bubbles.onScreen` (section 7), `ctxOk()`, `lineFor()`, `tryNpcSay()`, `updateNpc()` (section 9), `NPC_PROFILES` quirks (section 2), `processTimeEvents()` (section 14).

### 7.1 Bubble placement

| Item | Rule |
|---|---|
| Anchor | Head point from `npcHead()` (`npcAnchor(n, out, false)`): 1.85 m above the root standing, 1.8 m seated. Player bubbles: 1.9 m (`meSay`) |
| Name tag | `npcAnchor(n, out, true)`: 1.95 m above the root standing or seated, at the body position |
| Lying anchor (v1.8.4) | When `isLying(n)` is true (`goal.anim` is `'lie'` and `state` is `'seated'` or `'seatIn'`, i.e. Nguyên on the daybed), both anchors move from the feet to the body. Name tag: 0.6 m from the body position toward the head, 0.75 m high. Speech bubble: 1.05 m toward the head, 0.85 m high. Head direction: `-(sin yaw, cos yaw)`. Standing and seated values are unchanged. The 1.0 m lying value in earlier versions of this table was never used by the code |
| Visible area | The anchor must be in front of the camera and 10 px or more from the left and right edges. The bubble's top edge must be 112 px or more from the top (under the HUD), and the anchor must be at least 50 px above the bottom. `Bubbles.onScreen()` assumes a 40 px bubble height |
| Off-screen | Bubble is hidden (opacity 0). It is not pinned to the top or bottom edge |
| Horizontal | The bubble box stays 6 px inside the left and right edges, so it is not cut off. This is the only clamp |
| Ambient gate | `tryNpcSay()` (quirks, greetings, idle, treats) also requires `Bubbles.onScreen()` at the bubble anchor `npcAnchor(n, out, false)`, so a lying coworker is tested at the lying anchor (v1.8.4, same point as the bubble). With prio 0 it also needs distance 9.5 m or less to the player, at least 3.2 s since the last ambient bubble (`CFG.BUBBLE_GAP`), and fewer than 2 bubbles on screen. Treat bubbles (prio 1) skip these checks except `onScreen` |
| Player replies | `sayNpc()` (reply and invite results) and the cake-party toasts call `Bubbles.say()` directly. They skip the gates, but a hidden anchor still hides the bubble |

### 7.2 Line selection

- `lineFor(n, greeting)`: a pantry goal (`pantry…`) or invite override (`ovr:…`) gives `say.pantry`. The meeting goal (`meet`) gives "Đang họp, lát nói chuyện nhé." Otherwise `say.greet` when `greeting` is true, else `say.idle`.
- Used by ambient greetings and by the talk card. On the first talk of the day the card uses greet lines. Later talks use idle lines. Friends (affinity 75 or more) may get `FRIEND_GREET` instead.
- Quirk `ctx` (optional):

| `ctx` | Matches when |
|---|---|
| `desk` (default when absent) | Seated, goal `desk:work` |
| `eat` | Seated, goal `desk:eat` |
| `lounge` | Seated, goal `lounge` |
| `any` | Not moving (any other state) |

- Quirk timing: a quirk is tried each tick for 8 game minutes from its `at`, once per day. If `ctx` does not match, it is skipped for that tick and retried. A line is shown only if the coworker is within 9.5 m of the player and on screen (§7.1). If the coworker is more than 11 m away, the quirk is used up silently. The optional `anim` (3.5 s) plays only when the line is accepted.

### 7.3 Time-of-day tags

- Prefix on a line: `@am ` (before 11:00), `@noon ` (11:00 to 13:29), `@pm ` (13:30 onward). `pickSay()` strips the tag and keeps only lines in the current window. Untagged lines are always allowed. If no line is allowed, the untagged lines are used.
- Tags apply only to `say` arrays read through `pickSay()`. Quirk text is fixed and is not tagged.
- Current tagged lines. `@am`: Chủ tịt greet[0] ("em lại đi trễ"), Trung greet[0], Nam greet[0], Thảo greet[0] and greet[1], Yến greet[0] and greet[1], Chị Ba greet[1]. `@pm`: Yến greet[3] ("Chiều rồi mà bạn còn tỉnh táo vậy?", added v1.6.0). No `@noon` line exists yet. Afternoon greetings come from untagged lines and the `@pm` line.

### 7.4 Chủ tịt's treat bubble

`processTimeEvents()` (`treat`) shows one line with the treat toast, chosen by his goal:

| Goal | Line |
|---|---|
| `pantry…` | "{drink} tới rồi nè, mọi người ra lấy nhé!" |
| `desk…` | "Em mời cả nhà {drink} nè, ra pantry lấy nha!" |
| Other (walking, meeting, and so on) | "Em mời cả nhà nè, ra pantry lấy {drink} nha!" |

`{drink}` is the drink name (trà sữa, rau má, nước mía) or đồ ăn vặt (14:10). Applies to the 11:05 and 14:10 treats and the milk-tea day treats (`docs/spec/the-gioi-lien-tuc.md`, `docs/spec/noi-dung-bat-ngo.md`). The effects are unchanged (`mot-ngay-o-cong-ty.md` §4.2).

### 7.5 Stand-up lines and absent-coworker lines (v1.7.1)

Source: `setGoal()`, `standUpLine()`, `tryNpcSay()` (section 9), `npcAmbient()` (section 9), optional profile fields in `NPC_PROFILES` (section 2). The three fields are generic: any coworker may use them. Current users are noted below.

| Field | Type | Meaning | Used by |
|---|---|---|---|
| `say.stand` | array of strings | Lines for a stand-up. One is picked with `pickSay()` | Chị Ba (`an3`) |
| `say.standReply` | `{ id, line }` | Coworker `id` answers `line` after a stand-up line | Chị Ba → Chú 7 (`id: 'an7'`) |
| `say.absent` | `{ who, lines }` | A seated coworker says one of `lines` while coworker `who` has not arrived | Nam (`who: 'thanh'`) |

Stand-up (`say.stand`):

- Trigger: `setGoal()` sends a seated coworker to a new goal. This is the only trigger. "Áp lực quá!" is one of the three variants. The code has no separate pressure trigger.
- Chance: 55% per stand-up. 90% on the `busy` day theme ("Ngày chạy nước rút", `DAY_THEMES`).
- Cooldown: 60 s real time (`standCool`), set only when a line is shown.
- Display: `tryNpcSay()` at prio 0 (within 9.5 m of the player, on screen, 3.2 s since the last ambient bubble, fewer than 2 bubbles).
- Reply: 1.8 s after the stand-up line, `say.standReply.id` says `line` if that coworker is visible, the game is in play mode, and the bubble is on screen. The reply uses prio 1, so the distance and gap gates are skipped.

Absent (`say.absent`):

- Runs in `npcAmbient()` (play mode, not frozen) while the speaker is seated at `desk:work`.
- Condition: `who` is hidden and the game time is before `who.times.arrive` (Chủ tịt: 09:20). The timer (`absentCool`) counts down only while the condition holds. Its first value (5–12 s) is set at spawn, so the first line comes after 5–12 s of accumulated condition time. Later lines come every 7–15 s.
- Display: `tryNpcSay()` at prio 0, so the same gates as above apply.
- Ends: when `who` arrives, or the speaker stops sitting at the desk.
- Nam's lines keep his "khìn khìn" habit and are peer-level (mình / bạn).

### 7.6 Chị Ba's voice (v1.9.1)

Chị Ba (`an3`) is grumpier than before, and visibly annoyed, but still funny. Tone guidance for any new or edited line:

- Short sentences. Gruff and mock-annoyed ("cọc", "bực bội").
- Never mean. She teases, she does not insult. Teasing is aimed at Chú 7 (the "bánh tét" nickname), in the duo with Nam, and in the cat banter with Chủ tịt (v1.9.5, §2). The joke is always light.
- The playful "đấm nhẹ" (light punch) stays as a running joke. The punch animation is `visitAnim: 'punch'` (roster row 11, quirk 09:12).
- Keep her address terms (§2): "anh" for Chủ tịt, peer "tui / ông" banter with Nam.
- Lines updated in v1.9.1: `say.greet`, `say.idle`, `say.chat`, `say.pantry`, `reply`, `request` (ask), `meeting` (pos/neg), `quirks`, `note`, the `DOC_QUESTS` ask line, duo lines with Chú 7 and Nam, and the `dammhaam` result. Unchanged: `say.stand`, `say.standReply`.
- Wording is not native-reviewed (see `docs/tasks.md`).

### 7.7 Document-quest reactions (v1.13.0)

Used when the player brings the wrong document to an asker (`WRONG_DOC[npc]`, variety block between sections 2 and 3). One line is picked at random per wrong pick. `{doc}` is the needed document, `{name}` the one brought. Rules: `docs/spec/nhiem-vu-tai-lieu.md` §5. Wording not native-reviewed. Desk-task assigners and their end-of-day reactions (v1.14.0, `WORK_NAG`): `docs/spec/ngoi-lam-viec.md` §3.3.

| Coworker | Tone | Example line (`WRONG_DOC`) |
|---|---|---|
| Chị Ba (`an3`) | Scolds, gruff, playful light punch | "Bực bội quá… chị đấm bây giờ đó! (đấm nhẹ vào vai) Chị cần “{doc}”, nghe rõ chưa!" |
| Yến (`yen`) | Puzzled, "Là sao?" | "Ủa, là sao? Chị nhờ “{doc}” mà sao lại đưa “{name}”?" |
| Thảo (`thao`) | Gentle, encourages, offers a treat | "Giúp chị đi, chị mua đồ ăn cho nè!" |
| Chủ tịt (Thạnh, `thanh`) | Humble ("em", "{anh}"), karma | "Dạ… cái này chưa phải rồi {anh} ơi. Em cần “{doc}” nhé. Nhân quả mà, tìm lại là thấy." |
| Nam (`nam`) | Peer-level, keeps "khìn khìn" | "Khìn khìn… không phải cái này rồi. Mình cần “{doc}” nha." |

## 8. Detailed looks

Moved to `docs/spec/ngoai-hinh-dong-nghiep.md` in v1.13.0 (file-size split).
