# Spec: Nhiệm vụ tài liệu (afternoon document quest)

Status: v1.13.0 (2026-11-04). No hints. The cabinet card, the afternoon hint, and the mission-board line no longer name the document. The asker's "🔁 Hỏi lại" choice repeats the ask. A wrong pick gets a reaction from the asker in their own voice (§5). Earlier releases: `docs/changelog.md`.

Source of truth: `index.html`, variety block between sections 2 and 3 (`DOC_QUESTS`, `WRONG_DOC`, `DOC_NAMES`), section 10 (`afternoonHint()`, `extraTasks()`), section 11 (`startTalk()`, `questAsk()`, `cabinetFlow()`, the cabinet spot), section 14 (`processTimeEvents()` for the 13:45 start, `newDayState()` for the day's pick). Parent spec: `docs/spec/mot-ngay-o-cong-ty.md` §4.2 and AC-10. Mission board: `docs/spec/bang-nhiem-vu.md` §3.3.

## 1. Goal

In the afternoon, one coworker asks the player to fetch one named document from the filing cabinet. The player must remember what was asked. The game does not repeat the name except where listed in §3 and §5. There is no failure state. A wrong pick costs nothing except time.

## 2. Stages

`D.quest` = `{ def, stage }`. `def` is one entry of `DOC_QUESTS`, picked at random in `newDayState()`. `stage` starts at 0.

| Stage | Meaning | How it is reached | What the player sees |
|---|---|---|---|
| 0 | Not started | Day start | Nothing about the quest |
| 1 | Asked | 13:45 (`processTimeEvents()`): the asker's bubble "Ai rảnh giúp mình một việc nhỏ với…" and the toast "📎 <name> đang cần nhờ giúp một việc" | Talk menu with the asker: "📎 Hỏi xem họ cần gì". Afternoon hint: "<name> đang cần nhờ gì đó. Ghé bàn nói chuyện nhé." Mission row: "Giúp <name> tìm hồ sơ đã nhờ ở tủ tài liệu" (open) |
| 2 | Accepted | Ask card, "Được ạ, để mình đi tìm" | Cabinet spot "Tìm hồ sơ" (10.9, 5.9) enabled. Toast "📎 Nhiệm vụ: tìm hồ sơ ở tủ tài liệu". Talk menu: "🔁 Hỏi lại: cần lấy gì nhỉ?". Afternoon hint: "Tìm hồ sơ <name> đã nhờ ở tủ tài liệu (góc phải phía dưới, gần cửa). Quên thì ghé hỏi lại nhé." |
| 3 | Done | Correct document at the cabinet | Mission row ✅. Badge "🗄 Thám tử hồ sơ" at day end |

- "Để mình xong việc rồi giúp nhé" on the ask card keeps the quest at stage 1.
- The afternoon hint shows the printer-jam line first while that event is open, then the stage 1 or 2 line.
- The 13:30 "Buổi chiều" milestone is done when `D.tasks >= 2` and `D.quest.stage >= 3` (`MS`, section 10).

## 3. Asking, and asking again

- **Ask card (stage 1 to 2):** the asker's `ask` line from `DOC_QUESTS`, in quotes. It is the only place, besides §5, where the document name appears before the cabinet. Two choices: accept, or postpone.
- **🔁 Hỏi lại (stage 2 only):** shown in the talk menu of the asker only. It speaks the same `ask` line as a bubble and opens a card with the line and "Ok, mình đi lấy". No stage change, no penalty, no diary entry.
- The choice is not shown at stage 1 (before acceptance), and not for other coworkers.

## 4. The cabinet

- Spot "Tìm hồ sơ" at (10.9, 5.9), south east, enabled only at stage 2. Runs `cabinetFlow()`.
- Card: title "Tủ tài liệu", role "Hồ sơ cần tìm" (no document name in the role line, since v1.13.0). Text: "Bạn mở ngăn kéo, có vài tập hồ sơ. Chọn đúng tập <name> đã nhờ nhé."
- Buttons: the right document plus 4 others drawn at random from `DOC_NAMES` (6 entries in total, shuffled), then "Đóng tủ". Five document buttons per visit.
- **Correct pick:** stage 3. The asker gains +5 affinity, the player +6 mood and −3 energy, the asker +15 mood (capped at 100). A diary moment "Tìm giúp <name> đúng hồ sơ “<doc>”." is written. Card: "Bạn mang hồ sơ tới tận bàn <name>." with a reply line. Button "📁 Đưa hồ sơ" closes it.
- **Wrong pick:** stage stays 2. Card "Bạn mang “<document brought>” tới <asker>." with the asker's reaction (§5). Buttons: "Quay lại tủ tìm" (reopens the cabinet) and "Để lát nữa" (closes; the quest stays open).

## 5. Wrong-pick reactions

`WRONG_DOC[npc]` holds 2–3 lines per asker. One is picked at random per wrong pick. `{doc}` is replaced by the needed document and `{name}` by the document the player brought. The line is also shown as a bubble. Per-person tone and examples: `docs/spec/dong-nghiep.md` §7.7.

| Asker (`npc`) | Needed document (`doc`) | Ask line starts with |
|---|---|---|
| Chị Ba (`an3`) | Báo cáo khảo sát người dùng | "Em ơi, lấy giùm chị bản…" |
| Chủ tịt (Thạnh, `thanh`) | Hợp đồng đối tác game | "{Anh} lấy giúp em bản…" |
| Nam (`nam`) | Biên bản họp tuần | "Bạn ơi, giúp mình lấy…" |
| Yến (`yen`, new in v1.13.0) | Danh sách lỗi cần kiểm | "Ủa, bạn lấy giùm chị…" |
| Thảo (`thao`, new in v1.13.0) | Hồ sơ nhân sự | "Em ơi, lấy giúp chị…" |

`DOC_NAMES` also holds "Kế hoạch quý 4", which no quest asks for. It only appears as a decoy in the cabinet.

## 6. Acceptance criteria

| ID | Criterion | Status |
|---|---|---|
| AC-95 | No hint text names the document, except the ask line (§3) and the asker's reaction after a wrong pick (§5). The cabinet card role, the afternoon hint, the mission row, and the accept toast do not name it | Verified (headless Chrome, reported by requester: no hint text) |
| AC-96 | A wrong pick shows a card "Bạn mang “X” tới <name>." with the asker's reaction. The reaction names the needed document. Stage stays 2. All 5 askers were checked | Partly verified (headless Chrome, reported by requester: each of the 5 askers names the needed document). Wording not native-reviewed |
| AC-97 | A correct pick sets stage 3, applies the effects in §4, and lights the badge at day end | Partly verified (headless Chrome, reported by requester: correct pick completes at stage 3). Effects and badge not recorded |
| AC-98 | "🔁 Hỏi lại" appears only at stage 2, only for the asker, repeats the ask line, and changes nothing else | Not recorded (code reading only) |
| AC-99 | The cabinet shows the needed document and 4 others from `DOC_NAMES`, then "Đóng tủ" | Not recorded (code reading only) |

## 7. Open items

- Native-speaker review of the new lines: the ask lines (Yến, Thảo), every `WRONG_DOC` line (5 askers, 2–3 lines each), and the "Hỏi lại" card. See `docs/tasks.md` (v1.13.0).
- The stage 2 reply after accepting, "Cảm ơn nhé, tủ ở góc phải phía dưới đó!", is the same for every asker. It is still generic. A per-asker "where the cabinet is" line is a follow-up (`docs/tasks.md`).
- Mission-board row: the shipped text is "Giúp <name> tìm hồ sơ đã nhờ ở tủ tài liệu". It is the text in `extraTasks()` (section 10). Check the wording against the intended one.
- Not tested over a full day or on a real device.

## 8. Related docs

- Parent rules and acceptance: `docs/spec/mot-ngay-o-cong-ty.md` (§4.2, AC-10)
- Mission board row and hint: `docs/spec/bang-nhiem-vu.md` (§3.3)
- Asker and reaction voices: `docs/spec/dong-nghiep.md` (§7.7)
- Badge list: `docs/spec/noi-dung-bat-ngo.md` (§4)
- Player guide: `docs/product-guide.md`
