# Spec: Nội dung đa dạng (surprises, duos, day themes, badges)

Status: v1.10.0 (2026-11-04). Two `nguyen`→`thao` duo scripts added (§2), 21 scripts in total. Then two `trung`→`nguyen` scripts, for Trung's visits to Nguyên (§2): 23 scripts for 19 pairs. They are reachable since a later v1.10.0 change: Nguyên visits Chị Thảo from a pantry sofa (§2 note). Earlier: v1.9.5 (2026-11-04). `th-cat` intro text and options changed (Chị Ba is not allergic to cats; §3.2). Two cat-banter duo scripts added for Chị Ba and Chủ tịt (§2). Earlier: v1.9.0. Six new day themes, each with a story intro at 08:50 (§3.2, AC-75 to AC-77). Earlier: surprise trigger changed in v1.8.7 (§1, AC-40): a surprise waits for the player to stand near the related coworker instead of popping up at its time. Narration uses "anh" (not "ông") for Chủ tịt in three `SURPRISES` strings. The Nam–Thạnh scripts (v1.8.1, v1.8.2) and the random script pick per visit are in §2.

## 1. Daily surprises

- Each day has 3 surprises. A busy-theme day has 4 (`min(4, 3 + extra)`). A day whose theme has an `intro` (§3.2) adds one more, the intro, so it has 4 (5 on the `demo` and `hack` days, which have `extra: 1`).
- The day has 4 time windows: 09:05–09:40, 11:15–11:55, 13:40–14:25, and 16:05–16:40. Each surprise uses one randomly chosen window, at a random minute inside it. Windows are sorted by time.
- Events are drawn from `SURPRISES` (18 events plus the gift box, 19 entries). Events not in `recentEv` are drawn first. No event repeats within one day.
- Firing runs in `tickClock()`. Only one surprise fires at a time, only in `play` mode, and only when no card or dialog holds the player (`!P.lock`).
- Trigger (v1.8.7). After its scheduled time `sp.t` has passed, a surprise waits until the player is within `CFG.SURPRISE_NEAR` (4.2 m) of the related coworker (`ev.npc`). A surprise with no `npc` fires when any visible coworker is within 4.2 m. A hidden coworker (not in the office) never counts as near. The distance is measured from the player to the coworker's position (`P.pos` to `n.pos`).
- Skip (v1.8.7). If the trigger has not happened within 150 game-minutes after `sp.t`, or after 17:10 (`CFG.END - 20`), whichever comes first, the surprise is marked fired and skipped for the day. Nothing is shown. A skipped surprise is still written to `recentEv` when the day ends, though the player never saw it. Known edge case, see `docs/tasks.md`.
- Before v1.8.7 the surprise fired at its scheduled time regardless of distance, and was skipped only when the related coworker was hidden (after 90 game-minutes).
- Each surprise shows a card with 3 options. Each option shows a result card, then applies effects: `mood`, `energy`, `aff` (per-coworker affinity), and `moment` (a diary line). Effects go through `applyFx()`.
- Surprises fired in a day feed the "Bạn của những điều bất ngờ" badge (3 or more in one day, see section 4).

### 1.1 Event list

| # | id | Title | Related coworker | Options |
|---|---|---|---|---|
| 1 | `dating100k` | Tin vui: App Dating | Chủ tịt (Thạnh) | 3 |
| 2 | `likebug` | Bug "Nút Thích" | Yến | 3 |
| 3 | `phulai` | Phú bất ngờ có lời | Phú | 3 |
| 4 | `dammhaam` | Cú đấm nhầm | Chị Ba | 3 |
| 5 | `thongdat` | Kèo đất của Thông | Thông | 3 |
| 6 | `wifi` | Mất mạng | none | 3 |
| 7 | `vip` | Nhà đầu tư ghé thăm | Anh Bảo | 3 |
| 8 | `cat` | Chú mèo lạc | Chủ tịt (Thạnh) | 3 |
| 9 | `thanhmeo` | Ảnh mèo của Chủ tịt | Chủ tịt (Thạnh) | 3 |
| 10 | `toannoi` | Toàn lên tiếng | Toàn | 3 |
| 11 | `namdo` | Trà sữa đổ | Nam | 3 |
| 12 | `review5` | Đánh giá 5 sao | Anh Bảo | 3 |
| 13 | `nhanqua` | Câu chuyện nhân quả | Chủ tịt (Thạnh) | 3 |
| 14 | `trungbug` | Lỗi hay tính năng? | Trung | 3 |
| 15 | `yenlasao` | Chuỗi "Là sao?" | Yến | 3 |
| 16 | `thaoquan` | Thảo khoe quán ngon | Thảo | 3 |
| 17 | `tungthach` | Tùng thách đố | Tùng | 3 |
| 18 | `khiatra` | Cuộc khịa bằng trà | Chú 7 (Chị Ba in the text) | 3 |
| 19 | `gift` | Hộp quà bí ẩn | none | 3 boxes (special) |

- Rows 16–18 were added in v1.4.0. `thanhmeo` (row 9) and the `cat` changes were added in v1.4.2 (see `docs/changelog.md`). `cat` (row 8) now names Chủ tịt as the related coworker and has new option text (Chủ tịt looks for pate, and sends photos instead of bringing the cat). `gift` is now row 19.
- `dating100k` fills the user count from `Store.world.users` into its text at fire time.
- Options with `aff` raise affinity with the named coworkers. The effects are listed under each option in `SURPRISES`.

### 1.2 Mystery gift box (`gift`)

- Three boxes (🔴 red, 🔵 blue, 🟡 yellow). Each box gives one of five outcomes, shuffled per draw, so color does not predict the outcome.
- Outcomes: a warm milk tea (energy +14, mood +4); a thank-you card (mood +10); a rubber duck named "Debug" (mood +6, diary moment); a sticky note from a random coworker (mood +5, affinity +4 with that coworker); a chocolate bar (energy +10, mood +5).
- Sets the `gift` flag, which feeds the "Thợ săn quà bí ẩn" badge.

## 2. Coworker duos

- When a coworker visits a seated colleague's desk (visit rules in `mot-ngay-o-cong-ty.md` section 4.2), the pair plays scripted lines if a duo exists for them. Each duo has one line per stage.
- A visit prefers a duo partner 70% of the time when one is available. Otherwise it picks any seated colleague.
- When a pair has more than one script, one is picked at random for each visit (`runVisit()`, v1.8.2). The pick is stored with the visit, so the script stays the same until the visit ends.
- The visit ends after the last duo line or after 24 seconds, whichever comes first.
- Reachability (v1.10.0): a visit starts from a seated coworker at `desk:work`, or from a sofa seat for Nguyên (`habits.lounge`, goal `sofa:N`). Nguyên may visit only Chị Thảo (`npcAmbient()`, `dong-nghiep.md` §3). The partner must be seated at `desk:work`. So the two `nguyen`→`thao` scripts can play. Headless: 6 of 6 runs.
- Trung → Nguyên (v1.10.0): when Trung is at `desk:work` in a visit window, each visit attempt has a 40% chance to add Nguyên to the partner candidates, if Nguyên is on a sofa seat or the daybed (not frozen, not visiting). A `trung`↔`nguyen` duo is then preferred. Nguyên has no desk, so the visitor stands at his seat approach point (`seat.ax` / `seat.az`, facing the seat; `LOUNGE_SEAT` if the goal has no seat). Verified headless only: 1 of 6 short runs.
- When the visitor speaks at stage 0, the visitor plays `visitAnim` (Chị Ba: `punch`). The animation also plays on any visitor line that contains "đấm".

| Pair | Lines |
|---|---|
| Phú – Thông | 4 |
| Yến – Phú | 4 |
| Chị Ba – Nam (same-age banter, tui / ông; rewritten in v1.2.0; v1.6.1: Chị Ba asks Nam for the survey data he forgot to send) | 4 |
| Chủ tịt (Thạnh) – Thông (humble style since v1.4.3, "Anh Thông ơi") | 4 |
| Trung – Yến | 4 |
| Hiện – Toàn | 5 |
| Anh Bảo – Tùng | 3 |
| Thảo – Chủ tịt (Thạnh) (Chủ tịt's reply humble since v1.4.3: "Nhân quả mà chị… em sẽ cố") | 3 |
| Chú 7 – Thông (rewritten v1.4.3, tea persona; was 3 lines in this table) | 4 |
| Thảo – Yến (added v1.2.0) | 4 |
| Hiện – Anh Bảo (added v1.2.0) | 3 |
| Chú 7 – Chị Ba (added v1.4.0) | 4 |
| Tùng – Phú (added v1.4.0) | 4 |
| Thảo – Tùng (added v1.4.0) | 3 |
| Chủ tịt (Thạnh) – Hiện (added v1.4.2, cat talk; v1.4.3: "anh" kept for younger Hiện) | 3 |
| Nam – Chủ tịt (Thạnh), playful: Nam teases with "Bé Hạnh" and asks for the milk tea; Thạnh says not to call him that, and agrees to buy it (in `DUOS` since v1.8.1, missing from this table until v1.8.2) | 4 |
| Nam – Chủ tịt (Thạnh), serious: Nam asks Thạnh to settle the mobile login-screen design by Friday; Thạnh replies humbly ("Dạ, anh Nam gửi em bản mới…") (added v1.8.2) | 4 |
| Nguyên – Chị Thảo (v1.10.0, new pair, reachable from Nguyên's sofa seat, see the note above): `nguyen`→`thao` two scripts, "Chị Thảo ơi, nay có ai mời nước không?" and "Chị Thảo, hôm nay ai mời trà sữa hông chị?" | 4 + 4 |
| Trung – Nguyên (v1.10.0, Trung visits Nguyên from his sofa or daybed, see the note above): `trung`→`nguyen` two scripts, "Nguyên ơi, đổi design lại chút đi, cái này khó quá." and "Nguyên, nút này vẽ đẹp mà code mất ba ngày. Đổi lại chút được không?" | 4 + 4 |
| Chị Ba – Chủ tịt (Thạnh), cat banter, two scripts (v1.9.5): `an3`→`thanh` (fridge-opening cat, "Mèo em thiền… lười có triết lý") and `thanh`→`an3` ("mèo em hơi ú", "Mập là có phúc!") | 4 + 4 |

Twenty-three scripts for 19 pairs (v1.10.0; 21 scripts for 18 pairs before the Trung–Nguyên scripts; 19 scripts for 17 pairs in v1.9.5). Nam–Chủ tịt, Chị Ba–Chủ tịt, Nguyên–Chị Thảo, and Trung–Nguyên each have two scripts. Pairs not in this table use the generic `say.chat` lines.

## 3. Day themes

One theme is drawn at the start of each day (`pickTheme()`), weighted by `w`, leaving out `lastTheme`. On Friday there is a 50% chance of the milk-tea theme before the weighted draw. Total weight is 17 (v1.9.0): 11 for the five original themes, 1 each for the six new ones.

| id | Name | Emoji | w | Energy decay | Visit rate | Extra surprises | Extra treats |
|---|---|---|---|---|---|---|---|
| `normal` | Ngày bình thường | 🌤 | 3 | 1.0 | 1.0 | 0 | none |
| `rain` | Ngày mưa | 🌧 | 2 | 0.9 | 1.1 | 0 | none |
| `busy` | Ngày chạy nước rút | 🔥 | 2 | 1.5 | 0.4 | +1 (4 total) | none |
| `chill` | Ngày thư thả | 🌿 | 2 | 0.6 | 1.7 | 0 | none |
| `milk` | Ngày trà sữa | 🧋 | 2 | 0.9 | 1.2 | 0 | 09:55 and 16:00 |
| `demo` | Ngày khách tới xem demo | 🤝 | 1 | 1.2 | 0.7 | +1 (4 random + intro = 5) | none |
| `power` | Ngày wifi chập chờn | 🔌 | 1 | 0.8 | 1.5 | 0 (+ intro = 4) | none |
| `cat` | Ngày mèo ghé thăm | 🐈 | 1 | 0.8 | 1.4 | 0 (+ intro = 4) | none |
| `hack` | Ngày hackathon mini | 🏁 | 1 | 1.3 | 0.8 | +1 (4 random + intro = 5) | none |
| `sick` | Ngày giao mùa | 🤧 | 1 | 0.9 | 1.2 | 0 (+ intro = 4) | none |
| `award` | Ngày bình chọn tháng | 🏆 | 1 | 1.0 | 1.3 | 0 (+ intro = 4) | none |

- Energy decay multiplies the normal energy loss per game-minute (0.04).
- Visit rate multiplies the chance that a seated coworker starts a visit.
- The theme emoji is shown after the clock in the HUD (`#hud-clock`). The theme name and description appear in the day-start toast and in the diary entry.
- Rain day: the scene uses a grey, soft light (`applyTimeOfDay`), and `Sfx.rain(true)` starts a looping filtered-noise rain sound. The sound stops at the summary or when leaving to the title.
- Chủ tịt's (Thạnh's) base treats at 11:05 and 14:10 happen on every theme. Milk-tea days add the two extra treats in the table.

### 3.1 Chủ tịt's (Thạnh's) treats

- Each treat fires once when the clock crosses its time, including on a time skip. It does nothing if Chủ tịt is hidden.
- Effect: +8 energy, +3 mood, +2 affinity with Chủ tịt, a diary moment, a toast, a chime, and a line from Chủ tịt.
- Base treats: 11:05 ("Chủ tịt mua nước mời cả phòng.") and 14:10 ("Chủ tịt mua đồ ăn vặt cho mọi người."). Milk-tea extras: 09:55 and 16:00.

### 3.2 Intro stories (v1.9.0)

- Six themes have an `intro` event: `demo`, `power`, `cat`, `hack`, `sick`, `award`. Its id is `th-<theme>`, e.g. `th-demo`.
- `startDay()` puts the intro at the front of `D.surprises` with `t = 08:50`. It uses the proximity gate in §1 (fires when a visible coworker is within 4.2 m, after 08:50). It is skipped at 11:20 (08:50 plus 150 game-minutes), so it is never shown after late morning.
- An intro has no `npc`, so any visible coworker counts. It shows as a normal surprise card with 3 options and the same `[label, result, fx]` shape as `SURPRISES`. It is not in the `SURPRISES` pool, so it is never drawn at random and `recentEv` does not affect it.
- The intro counts toward `D.stats.surprise`, so on a day with an intro the "Bạn của những điều bất ngờ" badge (3 or more) is easier to reach.
- Intro options (effects are `mood`, `energy`, `aff`, and a diary `moment` where listed):

| Intro | Option (short label) | Effects |
|---|---|---|
| `th-demo` | Phụ dọn khu pantry | mood +5, energy −4, aff `bao` +4, moment |
| `th-demo` | Hỏi anh Bảo có cần tập demo thử | mood +6, aff `bao` +5, moment |
| `th-demo` | Dọn bàn của mình | mood +3, moment |
| `th-power` | Rủ cả nhóm chia sẻ hotspot | mood +6, aff `thong` +4, moment |
| `th-power` | Sắp xếp lại ghi chú giấy | mood +4, energy +3, aff `an3` +3, moment |
| `th-power` | Đi pha cà phê chờ mạng về | mood +5, energy +6, moment |
| `th-cat` | Xin ít sữa cho mèo ở pantry | mood +8, aff `thanh` +5, moment |
| `th-cat` | Hỏi Chị Ba cho xem ảnh mèo vàng nhà chị | mood +7, aff `an3` +4, aff `thanh` +1, moment |
| `th-cat` | Chụp một tấm ảnh rồi gửi nhóm chung | mood +7, moment |
| `th-hack` | Xin vào đội của Nam | mood +7, aff `nam` +4, moment |
| `th-hack` | Xin vào đội của Trung | mood +5, aff `trung` +4, moment |
| `th-hack` | Làm thử một mình | mood +4, energy −3, aff `tung` +3, moment |
| `th-sick` | Mang trà gừng cho Yến | mood +6, aff `yen` +5, moment |
| `th-sick` | Khen Chú 7 chu đáo | mood +5, aff `an7` +4, moment |
| `th-sick` | Mở bớt cửa sổ cho thoáng | mood +3, moment |
| `th-award` | Bầu cho Phú | mood +6, aff `phu` +5, moment |
| `th-award` | Bầu cho Thông | mood +5, aff `thong` +4, moment |
| `th-award` | Bỏ phiếu trắng, vẽ ngôi sao | mood +4, aff `thao` +3, moment |

- `th-cat` intro text (v1.9.5): Chị Ba says her golden cat is prettier. No allergy line. Her cat is Nghệ, Chủ tịt's is Nhân Quả (see `dong-nghiep.md` §2 for the cat canon). Chị Ba's intro line is "Xấu hoắc. Mèo vàng nhà chị đẹp gấp mười."

## 4. End-of-day badges

`makeBadges()` builds up to 4 badges from the day's stats. The first 4 matching conditions in this order are shown. If none match, the fallback is "🌱 Người mới đáng yêu".

| Badge | Condition |
|---|---|
| 👋 Người hay chào | 6 or more greetings |
| ☕ Chuyên gia pantry | 3 or more pantry visits |
| 🖨 Cứu tinh máy in | Printer jam solved |
| 🌟 Người kết nối | Talked to 11 or more coworkers |
| 🗄 Thám tử hồ sơ | Document quest reached stage 3 |
| 🎲 Bạn của những điều bất ngờ | 3 or more surprises in the day |
| 🎁 Thợ săn quà bí ẩn | Opened a gift box |
| 🗣 Người phát biểu | Joined the meeting |
| 💻 Chăm chỉ | 3 tasks done |
| 🎂 Linh hồn bữa tiệc | Took part in the cake party |

Badges appear as chips on the summary and as the `badges` field of the diary entry.

## 5. Acceptance criteria

Status legend as in `docs/spec/mot-ngay-o-cong-ty.md` section 3.

| # | Criterion | Status |
|---|---|---|
| AC-37 | Each day has 3 surprises (4 on busy days), one per time window, with no event repeated within the day. | Partly verified (all 18 entries exercised in the v1.4.0 harness; per-day count not recorded) |
| AC-38 | Every surprise shows 3 options. Each option shows a result card and applies its effects. No raw placeholders appear. | Verified (v1.4.2 headless harness: all 19 surprises x 3 options exercised, no raw placeholders, no JS errors. v1.4.3 re-run: all 19 x 3 again, no JS errors. Earlier: v1.4.0 run, 18 surprises) |
| AC-39 | The mystery gift box shows 3 boxes, and each box gives an outcome. | Verified (every gift box exercised in the 12-day run) |
| AC-40 | A surprise waits after its time until the player is within 4.2 m of the related coworker (any visible coworker if none). It is skipped if not reached within 150 game-minutes or by 17:10. Far from the coworker: not fired. Near: fired. | Verified (v1.8.7, headless Chrome only: far not fired, near fired) |
| AC-41 | The duo pairs play their scripted lines when those pairs visit each other. Pairs: 19 and scripts: 23 since v1.10.0 (18 pairs and 21 scripts before the Trung–Nguyên scripts; 17 pairs and 19 scripts in v1.9.5). The Nguyên–Chị Thảo pair visits from a sofa seat (§2 note). | Partly verified (headless, v1.10.0: 6 of 6 runs Nguyên visited Chị Thảo and a `nguyen`→`thao` script was picked; scripted lines not recorded as played). Trung–Nguyên (v1.10.0): 1 of 6 short headless runs, Trung reached Nguyên's approach point and the duo was picked (consistent with 40%); not tested over a full day; scripted lines not recorded as played. Earlier (v1.4.0 harness: all duo and surprise ids valid, before `thanhmeo` and the Chủ tịt–Hiện duo were added in v1.4.2. Scripted lines not recorded as played. v1.4.3 re-run: 15 duos run, no JS errors) |
| AC-42 | All 5 day themes appear. The emoji shows after the clock. The rain day shows grey light and plays the rain sound. | Partly verified (themes varied in the 12-day run; rain light and sound not recorded; audio not tested) |
| AC-43 | Milk-tea days add Chủ tịt's (Thạnh's) treats at 09:55 and 16:00. | Not recorded (source only) |
| AC-44 | Up to 4 badges appear on the summary and in the diary. | Not recorded (source only) |
| AC-45 | The notice board shows either procedural gossip or one of the fixed notes. | Not recorded (source only) |
| AC-75 | Themes with an `intro` queue it as the first surprise at 08:50. It fires when the player is near a visible coworker, and is skipped at 11:20 (§3.2). | Partly verified (v1.9.0, headless Chrome only: intro fired near a coworker. Far-away skip and 11:20 cut-off not recorded) |
| AC-76 | The six new themes appear in the day draw with weight 1 each (total 17), and the day's theme emoji shows after the clock. | Source check only (v1.9.0, `DAY_THEMES`, `pickTheme()`). Draw spread not measured |
| AC-77 | Each intro shows 3 options, and each option applies its effects and shows its result card. No raw placeholders appear. | Not recorded (v1.9.0 source check only; full run not reported) |
| AC-69 | A visit to a pair with more than one script plays one script, chosen at random when the visit starts, and keeps it until the visit ends (§2). | Source check only (v1.8.2, `runVisit()`). The full-day headless run reported no JS errors and valid ids. Spread of the random pick not measured |
