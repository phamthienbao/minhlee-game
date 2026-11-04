# Spec: Đồng nghiệp (coworkers, address terms, remote worker)

Status: v1.9.4 (2026-11-04). All 14 coworkers have detailed looks (`look.detail`, §8). Yến, Thạnh, and Phú re-matched to reference photos in v1.9.3 (by eye). The nine added in v1.9.4 are not re-matched to photos. Earlier history: `docs/changelog.md`.

## 1. Roster

14 computer-controlled coworkers. The in-game name is `name`. `real` and `nick` are shown on the conversation card when present.

`traits` is a maintainer note in `NPC_PROFILES` and is not shown anywhere in the game. The conversation card shows the name, the real name and nickname (when present), the job title (`role`), affinity hearts, a status sentence, and the coworker's own line. The invite list ("Rủ … ra pantry") shows the job title as its hint.

| # | In-game name | Real name / nickname | Team | Desk | Notes |
|---|---|---|---|---|---|
| 1 | Chủ tịt | real: Thạnh | Leadership (chủ tịt) | 1 | Hosts the 10:00 meeting. Arrives 09:20. Humble speech since v1.4.3 (§2). Nam calls him "bé Hạnh" when teasing (v1.8.1) and "Thạnh" in serious work talk (v1.8.2). Treat events (see `noi-dung-bat-ngo.md` §3.1). Cat lover: his cat is called Nhân Quả, and the trait "rất thích mèo" and the cat lines were added in v1.4.2. Quirk 12:50 (looks at cat photos). Cat plush on his desk. Surprises `cat` and `thanhmeo` (see `noi-dung-bat-ngo.md` §1.1) |
| 2 | Phú | nick: Siêu nhân may mắn | Backend Dev | 0 | Unlucky; loves investing and massages. Left table, north |
| 3 | Trung | — | Backend Dev | 4 | Catchphrase "Em nói thiệt". Custom look (v1.1.2). Right table, north |
| 4 | Toàn | — | Backend Dev | 3 | Quiet, says little. Left table, south |
| 5 | Hiện | — | Mobile Dev | 5 | Youngest. Refers to self as "em". Right table, north |
| 6 | Tùng | — | Mobile Dev | 8 | Often invites people out for a light after-work drink (nhậu, kept light). Likes dares and challenge games: the request is to say "MinhLee" ten times in a row. Quirk 16:50 calls for nhậu. Custom look (v1.1.2). Right table, south |
| 7 | Nam | — | Mobile Dev | 6 | At the printer on printer days. "khìn khìn". Same age as Chủ tịt and Chị Ba (confirmed 2026-11-04). Calls Chủ tịt "bé Hạnh" when teasing (playful duo, `say.absent`, v1.8.1) and "Thạnh" in serious work talk (serious duo; quirk 09:42, "Thạnh ơi, 10 giờ họp nhé…", v1.8.2). Before Chủ tịt arrives (09:20), he sometimes says lines about missing him and jokes about him being late (`say.absent`, §7.5). Right table, north |
| 8 | Thảo | nick: Bella | HR | 11 | The office foodie: knows many restaurants, drink shops, and good dishes. Greetings, chats, and requests are about food. Quirk 11:40 recommends a lunch place. Brings the birthday cake. Lower row |
| 9 | Yến | nick: Én Pink | QC | 12 | "Là sao?". Lower row, right end |
| 10 | Chú 7 | real: An (male) | QC | 7 | Young ("Chú" is a nickname). Loves tea (trà ô long, trà sen). Often teases Chị Ba, who answers with playful punches. Tea duo with Thông (v1.4.3). Custom look (v1.1.2). Right table, south. Chị Ba's teasing nickname for him is "bánh tét" (chat line, v1.7.1). When Chị Ba stands up and calls for "thằng bánh tét", he answers from behind his tea (`say.standReply`, §7.5) |
| 11 | Chị Ba | real: An (female) | Business Support | 10 | Supports product research: runs user surveys, builds reports, analyses the numbers. Strict in a fun way, and playfully "punches" colleagues (`visitAnim: 'punch'`, quirk 09:12). Quirk 09:48 re-checks charts before the meeting. Desk request: a survey report with only 40 respondents, and the options are to state the small sample, write it honestly, or overstate it as a joke. Afternoon quest: fetch "Báo cáo khảo sát người dùng" (`DOC_QUESTS`). Duo with Nam about survey data he forgot to send (`noi-dung-bat-ngo.md` §2). Same age as Chủ tịt and Nam. Stand-up catchphrase (v1.7.1): "Bực bội quá… thằng bánh tét đâu rồi!" (§7.5). Lower row |
| 12 | Anh Bảo | real: Bảo | Product | 2 | Oldest in the office. Asks "vì sao". Left table, south |
| 13 | Thông | nick: Bamboo | R&D | 9 | Lower row, left end (bottom-left of the office) |
| 14 | Nguyên | — | Designer | none (`desk: null`) | Works remotely. In the office on about half of the days. Rests on the pantry daybed (§3) |

Desks 0–12 are used by coworkers 1–13. Since v1.3.0: desks 0–3 are the left long table, 4–8 the right long table, and 9–12 the lower row. The player's own desk is a separate spot (`Bàn của bạn`) at the bottom left. Seat positions: `docs/spec/van-phong-layout.md` §3.

## 2. Address conventions

Coworkers mostly address each other by first name. These are the special cases:

| Who | Rule | Where it appears |
|---|---|---|
| Anh Bảo (Bảo) | The oldest. Others call him "Anh Bảo" | Surprises, duos, gossip, meeting lines |
| Chủ tịt (Thạnh) | Others call him "Chủ tịt" in game text. Nam calls him "Thạnh" in serious work talk (serious duo, quirk 09:42, v1.8.2) and "bé Hạnh" when teasing (playful duo, `say.absent`, v1.8.1). Cat lines and the cat surprises `cat` and `thanhmeo` (cat named Nhân Quả). Duo with Hiện about cats and games. Shown as "Chủ tịt" on cards, with real name Thạnh. Spelling is "Chủ tịt", not "Chủ tịch" (confirmed 2026-11-04) | Meeting host text (`HOSTN`), surprises, duos, gossip |
| Chủ tịt (Thạnh), speech (v1.4.3) | Humble style. Himself: "em". Most people, including the player (`{anh}`) and in group talk: "anh" / "chị". Normal "anh" / "em" with the younger coworkers below and with Chị Ba. Nam (same age) gets the humble style. Duo `thanh`–`hien` keeps "anh" | Greetings, idle, chat, pantry, request, reply, meeting, quirks, notes, treat bubble, duo lines, surprises, the document ask (`DOC_QUESTS`) |
| Younger coworkers (for Chủ tịt's speech) | Hiện (stated youngest). Chú 7, Trung, and Nguyên are assumed younger (not stated, to confirm, see `docs/tasks.md`) | Chủ tịt's speech above |
| Chị Ba (An, female) | Calls Chủ tịt "anh" (same age). Her line in surprise `dammhaam` uses the real name: "Chị xin lỗi anh Thạnh!" | Surprise `dammhaam` |
| Chú 7 (An, male) | Called "Chú 7". "Chú" is a nickname, not an age term. Chú 7 is young (confirmed 2026-11-04). Teases Chị Ba in surprise `khiatra` and in the 09:46 quirk | Profile name, surprise `khiatra` |
| Chị Ba → Chú 7 (v1.7.1) | Chị Ba's teasing nickname for Chú 7 is "bánh tét" (in her stand-up line and his chat line). Chú 7 answers her call with "Dạ có em đây chị Ba!" ("em", respectful to her) | `say.stand` and `say.standReply` on `an3`, chat line on `an7` |
| Ages | Anh Bảo is the oldest. Chủ tịt, Nam, and Chị Ba are the same age (confirmed 2026-11-04). Chú 7 is young (confirmed 2026-11-04). Toàn's age tier is not specified. Other ages are not recorded | — |
| Yến, Thông, Thảo, Tùng, Phú | Peers. Use first names. Thảo calls Yến "chị Yến" (duo `thao-yen`) | Duos |
| Hiện | Youngest. Refers to self as "em" and to others as anh / chị. Lines rewritten in v1.2.0 | Greet, pantry, chat, request, note lines |
| Nam | Peer-level lines (mình / bạn). No deferential "em" or "ạ". Keeps "khìn khìn". Same-age banter with Chị Ba (tui / ông) in duo `an3`–`nam`. Toward Chủ tịt (Thạnh): "Thạnh" in serious work lines (v1.8.2), "bé Hạnh" when teasing (v1.8.1) | Greet, pantry, chat, request, duo lines |

The player is addressed with `{anh}` / `{Anh}` by gender (`fill()`, see `mot-ngay-o-cong-ty.md` §4.2). That rule is unchanged.

## 3. Remote worker: Nguyên

- Profile: `id: 'nguyen'`, `role: 'Designer'`, `desk: null`. No gender is recorded: the profile has no gender field, no gender was stated, and Nguyên's lines contain no `{anh}` / `{Anh}`.
- Habits: `arrive: '10:15'`, `leave: '17:00'`, `coffee: 'morning'`, `lunch: 'pantry'`, `joinsMeeting: false`, `lounge: true`, `attendance: 0.5`.
- Attendance: `resetNpcDay()` rolls `Math.random() > attendance` each day. On a remote day `times.arrive` is 99999, so Nguyên stays hidden all day. On about 50% of days he comes in (raised from 0.3 on 2026-11-04).
- In office: the default goal (`decideGoal()`, after meeting, events, lunch, coffee, and visits) is `goalLounge()`. He walks to `LOUNGE_SEAT` (cx −4.0, cz −6.9, `lie: true`) and plays pose `lie`. He is not a desk worker, so he is never a visit candidate. Lunch and coffee still use pantry spots. `LOUNGE_SEAT` is one seat, and `goalLounge()` does not check occupancy, so only one coworker may use `habits.lounge` at a time (only Nguyên does).
- Daybed (moved in v1.3.0 to the north wall, east of the pantry): obstacle at (−4.6, −6.9), 1.8 × 1.0 m (`addObst`). Scene parts: teal frame, cream mattress, orange pillow. Built in section 5, `buildOffice()`.
- Arrival toast: `processTimeEvents()` shows "😴 Nguyên hiếm hoi lên công ty hôm nay, đang nằm ở pantry!" at arrival + 8 min. Not shown on remote days. Quirk: 11:20, "(nằm dài ở pantry, mắt lim dim)", no animation.
- Pantry: `PANTRY_SPOTS` still has 8 standing spots. Two were moved in v1.2.0. Their previous coordinates are not recorded.

## 4. Profile fields added in v1.2.0

| Field | Type | Meaning |
|---|---|---|
| `desk` | number or `null` | `null`: no desk. `goalDesk()` returns `goalLounge()` instead |
| `habits.lounge` | boolean | Idle default goal is the pantry daybed instead of the desk |
| `habits.attendance` | number 0–1 | Chance of coming in on a given day. Missing means always in |

The section 2 header comment in `index.html` does not describe these three fields yet (see `docs/tasks.md`).

## 5. Acceptance criteria

Status legend as in `docs/spec/mot-ngay-o-cong-ty.md` section 3.

| # | Criterion | Status |
|---|---|---|
| AC-46 | `NPC_PROFILES` has 14 entries. 13 have desks 0–12. Nguyên has `desk: null`. The title subtitle says 14 coworkers. | Verified (14 NPCs in two headless runs). Subtitle checked in source only |
| AC-47 | Address conventions (§2) appear in rendered lines. No old names (Thạnh, Bảo) appear in rendered text, except Chị Ba's "anh Thạnh" line. | Not recorded (source only). Native-speaker review pending. v1.4.3 source check: one Chủ tịt line in surprise `dating100k` still uses "Anh" (see §6) |
| AC-48 | Nguyên is in the office on about 50% of days. On other days he never appears. | Not recorded (source only). Rate not measured |
| AC-49 | On an office day Nguyên arrives about 10:15, lies on the pantry daybed, and the arrival toast shows. | Partly verified (screenshot shows him lying on the daybed). Arrival time and toast not recorded |
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
| `pantry…` | "Nước em pha sẵn rồi nè, mọi người ra lấy nhé!" |
| `desk…` | "Em vừa đặt đồ uống cho cả nhà, lát giao tới nha!" |
| Other (walking, meeting, and so on) | "Em mời cả nhà nè, đừng ngại!" |

Applies to the 11:05 and 14:10 treats and the milk-tea day treats (`docs/spec/the-gioi-lien-tuc.md`, `docs/spec/noi-dung-bat-ngo.md`). The effects are unchanged (`mot-ngay-o-cong-ty.md` §4.2).

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
- Never mean. She teases, she does not insult. Teasing is aimed at Chú 7 (the "bánh tét" nickname) and in the duo with Nam, and the joke is always light.
- The playful "đấm nhẹ" (light punch) stays as a running joke. The punch animation is `visitAnim: 'punch'` (roster row 11, quirk 09:12).
- Keep her address terms (§2): "anh" for Chủ tịt, peer "tui / ông" banter with Nam.
- Lines updated in v1.9.1: `say.greet`, `say.idle`, `say.chat`, `say.pantry`, `reply`, `request` (ask), `meeting` (pos/neg), `quirks`, `note`, the `DOC_QUESTS` ask line, duo lines with Chú 7 and Nam, and the `dammhaam` result. Unchanged: `say.stand`, `say.standReply`.
- Wording is not native-reviewed (see `docs/tasks.md`).

## 8. Detailed looks (v1.9.2 to v1.9.4, `look.detail` on 13 of 14, Trung keeps his original face; hair is `hairStyle` unless noted; fields in `docs/glossary.md`)

| Coworker | Hair | Neck (`neck`) | Other |
|---|---|---|---|
| Chủ tịt (Thạnh) | `quiff` (v1.9.3) | `collar`, gingham (`pat:gingham`), short sleeves (`shortSleeve`) | thin light-silver rect glasses, slimmer face, teeth |
| Phú | `side` (v1.9.3) | `collar`, dark (`0x141416`) | rect dark glasses, wider face (`round`), teeth |
| Trung | original face (no `look.detail`, kept at the user's request: closer to him) | striped shirt | rect glasses, mustache |
| Toàn | `side` | `collar`, navy (`0x1f2a5c`), closes the polo-collar gap | mustache, wider face (`round`), no glasses |
| Hiện | `quiff` | `crew`, purple (`0x654a8c`) | round glasses, smile |
| Tùng | `style: 'fringe'` (no `hairStyle`) | `crew`, pale lilac (`0xd9d4e6`) | smile |
| Nam | `style: 'fringe'` (no `hairStyle`) | `collar`, plaid (`pat:plaid`) | smile, teeth, no glasses |
| Thảo | `wavy`, long over the shoulders | `vneck`, orange | lashes, gold earrings, pink lips |
| Yến | `sleek`, centre part (`part: 'center'`) | `crew`, dark | lashes, coral lips, gold earrings, thin rose-gold glasses, teeth |
| Chú 7 | `tousled` | `crew`, cream | smile |
| Chị Ba | `style: 'bob'` (no `hairStyle`) | `crew`, dark grey | lashes, muted lips, silver earrings, dark thick round glasses, flat mouth (no smile) |
| Anh Bảo | `side` | `collar`, yellow (`0xd4ac4d`) | smile |
| Thông | `side`, neat side part | `crew`, light grey ring on white tee | — |
| Nguyên | `style: 'fringe'` (no `hairStyle`) | `crew`, black | detailed eyes and brows, no glasses |
