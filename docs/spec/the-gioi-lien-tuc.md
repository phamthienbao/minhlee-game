# Spec: Thế giới liên tục (endless world)

Status: v1.3.1 (2026-11-04). v1.3.0 changed the birthday offsets (`× 4`, unique for all 14 coworkers), excluded remote coworkers from birthday and cake picks, and moved the notice board to the east wall. v1.2.0 changed the birthday roster (14 coworkers) and the notice-board name pool. Parent spec: `docs/spec/mot-ngay-o-cong-ty.md`. Source of truth: `index.html` (section 14 and the calendar block above section 3).

## 1. Purpose

The game has no ending. Each day is one work day. Days run Monday to Friday, then a weekend vignette, then Monday again. A small world state (the App Dating user count and app version) and the coworker relationships carry over from day to day.

## 2. Calendar

| Item | Rule | Code |
|---|---|---|
| Day number `dn` | `Store.days + 1`. Day 1 is the first day ever played | `newDayState()`, `startDay()` |
| Weekday | `wd = (dn - 1) % 5`: 0 Thứ Hai, 1 Thứ Ba, 2 Thứ Tư, 3 Thứ Năm, 4 Thứ Sáu | `calInfo()`, `WEEKDAYS` |
| Week | `week = floor((dn - 1) / 5) + 1` | `calInfo()` |
| Start | Day 1 is Thứ Hai, tuần 1 | |
| Day-start toast | "<weekday> · Tuần N · Ngày D" plus the day theme line (see `noi-dung-bat-ngo.md`) | `startDay()` |
| After Friday | The summary button reads "🌙 Qua cuối tuần" and opens the weekend vignette | `showSummary()`, `weekendFlow()` |
| Other days | The summary button reads "☀ Sang ngày tiếp theo" and starts the next day | `showSummary()` |
| Title button | "Bắt đầu ngày mới" when `days` is 0. Otherwise "▶ Tiếp tục: <weekday>, tuần N" | `refreshTitle()` |
| Title info | "Bạn đã làm ở MinhLee N ngày. Game không có hồi kết…" | `refreshTitle()` |
| Ending | None. No end screen, no game-over, no day cap. The 17:30 prompt ends only the current day | `processTimeEvents()` |

## 3. Weekend vignette

- Shown once after each Friday summary. One of 8 `WEEKENDS` entries is picked at random.
- The bonus applies only to the next Monday: mood +6 to +10, energy +6 to +16. A normal day starts at mood 60 and energy 80. Both are clamped to 0–100.
- The bonus is held in memory (`G.bonus`), not in `Store`. Reloading the page while the weekend screen is open drops it. Known issue, see `docs/tasks.md`.
- Buttons: "☀ Thứ Hai rồi, đi làm thôi!" starts Monday. "🏠 Màn hình chính" goes to the title.

## 4. Persistent world state

| Field | Start | Change | Shown in |
|---|---|---|---|
| `world.users` | 12 (thousands) | At each summary: `+ round(rand(0.6, 2.4) × (1 + tasks × 0.15))`, so +1 to +3 thousand per day | Summary line, notice board line, the "Tin vui: App Dating" surprise text |
| App version | Not stored. Derived from `dn` by `appVersion()` | Minor number rises each week (+0.1). Every 4 weeks the major number rises and the minor resets | Summary (version for the next day), notice board (today's version), Monday meeting |

App version examples: days 1–5 show v1.0, days 6–10 v1.1, days 11–15 v1.2, days 16–20 v1.3, days 21–25 v2.0.

- `world` is written to `Store` at the summary, together with `days`, `diary`, `affinity`, `lastTheme`, and `recentEv`.
- Coworker relationships (`affinity`) persist. They are written at the summary, and also immediately after each surprise option (`saveProgress()`), so surprise effects survive even if the day is abandoned. The day record itself is not saved.

## 5. Monday meeting

- On Monday (`wd === 0`) the 10:00 meeting question is `mondayTopic(dn)`. It asks where the team should focus before the app version ships. The version number is `appVersion(dn)`.
- Its three options use the same tag mechanics as `MEETING_TOPICS`: attendees whose `meeting.values` match the tags react positively.
- Other weekdays draw one entry from `MEETING_TOPICS`.

## 6. Repeat avoidance

- `Store.recentEv` holds the ids of the last 8 surprises that fired. `scheduleSurprises()` puts events not in this list first.
- `Store.lastTheme` holds the previous day's theme id. `pickTheme()` leaves it out of the random pool.
- Exception: on Friday, a 50% milk-tea roll runs before the pool and ignores `lastTheme`, so a Thursday milk-tea day can repeat on Friday. Known issue, see `docs/tasks.md`.

## 7. NPC birthdays (65-day cycle)

- Each coworker has a fixed offset `(index × 4 + 3) % 65`, where index is the position in `NPCS` (14 coworkers, index 0–13). A coworker's birthday is the day where `dn % 65` equals that offset. Changed in v1.3.0 from `× 5`.
- Offsets are 3, 7, 11, … 55 for index 0–13. All 14 are unique, so every coworker, including Nguyên (index 13, offset 55), has one birthday every 65 days. (v1.2.0 gave Nguyên offset 3, the same as Chủ tịt, so Nguyên never got a birthday. Fixed in v1.3.0.)
- The lookup is `NPCS.find()` with an in-office check (`n.times.arrive < 99999`). A coworker working remotely that day cannot be picked. If the birthday coworker is remote, no birthday is set for that day, and the normal daily-event roll applies.
- On a birthday day the printer event is not rolled. A cake party (15:20–15:55) is held for that coworker instead.
- Without a birthday, the daily event is a 50% printer jam (14:30) or a cake party for a random coworker who is in the office and is not Thảo. The pick excludes remote coworkers (v1.3.0; the v1.2.0 pick could choose Nguyên on a remote day). See `docs/spec/dong-nghiep.md` §6.

## 8. Friends

- A coworker with affinity 75 or more counts as a friend (`AFF[id] >= 75`).
- A friend's automatic greeting always uses `FRIEND_GREET`. A friend's card intro uses `FRIEND_GREET` 60% of the time. Other coworkers use their normal greet or idle lines.
- `FRIEND_GREET` lines contain `{ten}` and are filled by `fill()`.

## 9. Notice board

- Spot "Đọc bảng tin" (`Bảng thông báo`) on the east wall, beside the front door (spot at (10.9, 4.6), board at x 11.93). Moved from the back wall in v1.3.0. Always enabled.
- Opens one card with one note.
- 55% chance: procedural office gossip, "🗞 Tin đồn văn phòng: <who> <action> <thing>. <ending>", built from `GOSSIP_A` (14 names, including Nguyên since v1.2.0), `GOSSIP_ACT` (8), `GOSSIP_THING` (13, including "tấm ảnh mèo của Chủ tịt" since v1.4.2; was 12), and `GOSSIP_END` (7). That is 10,192 combinations (was 9,408 before v1.4.2, and 8,736 with 13 names).
- 45% chance: one of 5 fixed notes. Notes: the world line (users and version), Friday lunch, a shutdown reminder, a pantry bookshelf request, and a quiet-corner reminder.

## 10. Acceptance criteria

Status legend as in `docs/spec/mot-ngay-o-cong-ty.md` section 3.

| # | Criterion | Status |
|---|---|---|
| AC-27 | Day 1 is Thứ Hai, tuần 1. Weekdays advance Mon → Fri, and the week number advances every 5 days. | Verified (12-day simulated run: weekday and week progression correct) |
| AC-28 | No ending: play continues after Friday. The title button reads "▶ Tiếp tục: <weekday>, tuần N" when a save exists. | Partly verified (no ending reached in the 12-day run; title label checked in source only) |
| AC-29 | After Friday's summary, a weekend vignette shows, then Monday starts with the mood and energy bonus. | Partly verified (weekend flow reached in the 12-day run; bonus values not recorded) |
| AC-30 | `world.users` grows each day and is shown in the summary and on the notice board. | Partly verified (user count growth verified; notice-board line not recorded) |
| AC-31 | App version follows `appVersion()` and appears in the summary, the notice board, and the Monday meeting. | Not recorded (source only) |
| AC-32 | The Monday 10:00 meeting asks about the upcoming app version. Other days draw from `MEETING_TOPICS`. | Not recorded (source only) |
| AC-33 | Affinity carries over between days. Friends (≥75) greet with `FRIEND_GREET`. | Not recorded (source only) |
| AC-34 | Theme and surprise do not repeat on consecutive days (`lastTheme`, `recentEv`), except the known Friday milk-tea path. | Partly verified (themes varied in the 12-day run; the no-repeat rule itself not recorded) |
| AC-35 | Each coworker's birthday recurs every 65 days and forces a cake party that day. Offsets are unique (v1.3.0). Remote coworkers are not picked (§7). | Not recorded (a 65-day cycle is longer than the 12-day run; source only) |
| AC-36 | The diary keeps the most recent 150 entries. | Not recorded (source only) |
