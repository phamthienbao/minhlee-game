# Spec: Bố cục văn phòng (office layout)

Status: v1.3.0 (2026-11-04). Wall clock (north wall) updated in v1.8.8 (AC-74). Unlocked desk items on the player's desk added in v1.9.0 (`docs/spec/bang-nhiem-vu.md` §9, AC-79). Source of truth: `index.html`, the layout constants block that starts at the comment "Bố cục theo sơ đồ" (section 5, about line 755), `buildOffice()` (section 5), and `buildSpots()` (section 11). Parent spec: `docs/spec/mot-ngay-o-cong-ty.md`. Coworker seats are listed by name in `docs/spec/dong-nghiep.md`.

The layout follows a user-supplied floor plan, `so-do-van-phong-2.svg` (1200 × 900 px, top-down). The file is not in the repo. Before v1.3.0 the office had a different layout (desks in two rows, meeting table top right, door on the south wall). That layout is not recorded here.

## 1. Coordinate conversion

| Item | Rule |
|---|---|
| Plan to metres | `planX(px) = (px − 600) × 0.02243`, `planZ(py) = (py − 450) × 0.02353` |
| Axes | +x is east (right wall). +z is south (the glass south wall). −z is north (back wall). Origin is the plan centre |
| Plan y | Increases downward on the plan, which is +z (south) in the game |
| Fidelity | Checked by eye on headless-Chrome screenshots. Not measured against the SVG |

## 2. Zones and fixed objects

All values in metres. Walls: north z −8.1, west x −12.1, east x 12.1 (with the door gap), south z 8.1 (low glass wall, 1.0 m solid base). Floor 24.4 × 16.4.

| Zone or object | Position and extent | Constant or code | Notes |
|---|---|---|---|
| Walkway | z 1.29 to 3.29, full width | `DOOR_GAP` (plan y 505–590) | Open floor band between the two seating zones. No separate object |
| Left long table | centre (−6.62, −2.09), 6.9 × 1.5, spans x −10.07 to −3.17 | `LONG_TABLES[0]` | Seats 0–3 |
| Right long table | centre (6.62, −2.09), 6.9 × 1.5, spans x 3.17 to 10.07 | `LONG_TABLES[1]` | Seats 4–8 |
| Lower row of own desks | z 4.73 (seat z 5.85) | `DESKS` 9–12 | Four 2.0 × 1.0 desks |
| Column 1 | centre (−0.39, −2.18), 1.0 × 1.06, 3.2 m tall | `COLUMNS[0]` | Middle of the room, just south of the meeting room |
| Column 2 | centre (−1.77, 4.49), 0.94 × 1.0, 3.2 m tall | `COLUMNS[1]` | Lower middle, at the level of the lower row, between Thông's and Chị Ba's desks |
| Meeting room | x −3.0 to 3.0, z −8.0 to −2.9 | `MEET_ROOM` | Top centre, between the long tables. Not in the plan (see §6) |
| Pantry | Counter x −11.5 to −7.3, z −7.85 to −7.05. Fridge at (−11.45, −5.9). Pantry area about x −11.9 to −6.4, z −8.0 to −4.6 | `PANTRY_SPOTS`, `buildOffice()` | Top left (north west) |
| Daybed | Obstacle centre (−4.6, −6.9), 1.8 × 1.0 | `LOUNGE_SEAT` | North wall, east of the pantry. Used by Nguyên |
| Sofa | Obstacle centre (8.0, −7.3), 3.0 × 1.0 | `SOFA_SEATS` | North east corner |
| Printer | Obstacle centre (−11.3, 0.3), 1.2 × 0.8 | `PRINTER_SPOT` | West wall |
| Front door | East wall, gap z 1.29 to 3.29, centre `DOOR.z` 2.29 | `DOOR`, `DOOR_GAP` | Aligned with the walkway. See §5 |
| Notice board | East wall, plane at x 11.93, centre z 4.6 | `buildOffice()` | Next to the front door |
| Wall clock | North wall, plane at z −7.93, centre (2.2, 2.6), 0.6 × 0.6 m | `buildOffice()`, `WALL_CLOCK`, `drawWallClock()`, `applyTimeOfDay()` | Face shows the in-game time. Redrawn once per in-game minute (v1.8.8). Hands: hour 30 px, minute 46 px, 12 ticks. Not drawn in list mode |
| Filing cabinet | Obstacle centre (11.3, 6.2), 1.1 × 0.8 | `buildOffice()` | South east corner |
| Coat stand | Obstacle centre (11.3, 0.4) | `buildOffice()` | Beside the door |
| Work carpet | 23 × 11.8, centre (0, 1.6) | `buildOffice()` | Covers the seating zones and walkway |

## 3. Seats (`DESKS` index)

The index is the value of `desk` in `NPC_PROFILES` (`index.html`, section 2). Long-table seats are on the north or south side. Seats face each other across the table. Lower-row seats face north.

| Index | Coworker (in-game name) | Place | x | Seat z | Faces |
|---|---|---|---|---|---|
| 0 | Phú | Left table, north | −8.30 | −3.39 | south |
| 1 | Chủ tịt (Thạnh) | Left table, north | −5.16 | −3.39 | south |
| 2 | Anh Bảo (Bảo) | Left table, south | −8.30 | −0.79 | north |
| 3 | Toàn | Left table, south | −5.16 | −0.79 | north |
| 4 | Trung | Right table, north | 3.81 | −3.39 | south |
| 5 | Hiện | Right table, north | 6.17 | −3.39 | south |
| 6 | Nam | Right table, north | 8.52 | −3.39 | south |
| 7 | Chú 7 (An) | Right table, south | 4.93 | −0.79 | north |
| 8 | Tùng | Right table, south | 8.07 | −0.79 | north |
| 9 | Thông | Lower row | −6.84 | 5.85 | north |
| 10 | Chị Ba (An) | Lower row | 3.41 | 5.85 | north |
| 11 | Thảo | Lower row | 6.44 | 5.85 | north |
| 12 | Yến | Lower row | 9.47 | 5.85 | north |
| none | Nguyên | Remote. No seat at a desk (`desk: null`) | — | — | — |
| player | Player | `PLAYER_DESK`, lower row, left of Thông | −10.20 | 5.85 | north |

Notes:
- Long-table seat z is the table z ± 1.3 (north −1.3, south +1.3). Each seat has a visit point 1.2 m to its east (`visit`).
- Lower-row desks sit at z 4.73, and the seat is 1.12 m south of the desk.
- Seat x values come from the plan x of each mark.

## 4. Fixed interaction points (`buildSpots()`)

| Spot (label) | Centre | Radius (m) | Notes |
|---|---|---|---|
| Làm việc (Bàn của bạn) | (−10.2, 6.48) | 2.3 | Player desk. Position is `PLAYER_DESK.x` and `seat.az − 0.4` |
| Pantry (drinks, lunch, party) | (−8.8, −6.0) | 3.0 | Top left |
| Tham gia họp | (0, −2.9) | 3.1 | Meeting room, south opening |
| Tìm hồ sơ (filing cabinet) | (10.9, 5.9) | 2.2 | South east |
| Xem máy in (printer) | (−9.9, 0.5) | 2.0 | West wall |
| Đọc bảng tin (notice board) | (10.9, 4.6) | 1.7 | East wall |
| Nghỉ ngơi (sofa) | (8.0, −6.0) | 1.9 | North east |
| Ra về (front door) | (10.8, 2.29) | 1.9 | East wall, from 16:00 |

## 5. Entrance and spawn

- NPCs appear at `DOOR` (x 11.2, z 2.29 ± 0.5 at random) when they arrive (`setGoal()`, state `hidden` → `standing`). When they leave, their path target is `DOOR` (the `leave` goal, `G_LEAVE`).
- The player starts at (10.3, 2.29), facing west (yaw −π/2), beside the door. This is set in `startDay()`.
- The door mat (`matMesh`) is at (11.0, 2.29) on the floor.

## 6. Assumptions (not taken from the plan)

The user can change each of these. The value to change is shown. The daybed, sofa, printer, and notice board positions follow the brief for v1.3.0. They are not positions read from the SVG.

| Item | Current value | Where to change | Reason |
|---|---|---|---|
| Player desk | (−10.2, z 4.73), bottom left, left of Thông | `PLAYER_DESK` | The plan has no desk for the player. The position was chosen by the maintainer |
| Meeting room | x −3 to 3, z −8 to −2.9, top centre | `MEET_ROOM`, `MEET_TABLE`, `MEET_SEATS` | The plan has no meeting room. It sits between the two long tables. Glass walls on the east and west sides for z −8.0 to −5.1. The lower part of each side (z −5.1 to −2.9) is open as a side door. The south side is glass with an opening at x −1.9 to 1.9 |
| Daybed | North wall, east of the pantry | `LOUNGE_SEAT` | Plan item moved as requested |
| Sofa | North east corner | `SOFA_SEATS` | Plan item moved as requested |
| Printer | West wall, z 0.3 | `PRINTER_SPOT` | Plan item moved as requested |
| Notice board | East wall, z 4.6 | `buildOffice()`, spot in `buildSpots()` | Plan item moved as requested |
| Filing cabinet | South east, stays | `buildOffice()`, spot in `buildSpots()` | Not moved |
| Plants, windows, posters, calendar, logo | Positions from v1.2.0 | `buildOffice()` | Decorative. Not in the plan. Checked by eye only |
| Wall clock | Position from v1.2.0 (§2). Face follows the in-game time since v1.8.8 | `buildOffice()`, `drawWallClock()` | Not in the plan. Checked by eye and by exported face image only |

## 7. Pantry spots and sitting spots

- `PANTRY_SPOTS` has 8 standing spots, all facing north (yaw π): (−10.6, −6.3), (−9.6, −6.3), (−8.6, −6.3), (−7.6, −6.3), (−10.2, −5.0), (−9.0, −5.0), (−7.8, −5.0), (−6.6, −5.4).
- `SOFA_SEATS`: (7.3, −7.2) and (8.7, −7.2), facing south.
- `LOUNGE_SEAT`: centre (−4.0, −6.9), access point (−4.6, −5.4), yaw π/2, pose `lie`. Only one coworker uses it (Nguyên).
- `PRINTER_SPOT`: (−10.2, 0.3), facing west (yaw −π/2). The printer jam event sends Nam here.
- Meeting seats (`MEET_SEATS`, 8): north row z −6.5 at x −1.1, −0.37, 0.37, 1.1 (yaw 0); south row z −3.9 at the same x values (yaw π). Table `MEET_TABLE` at (0, −5.2), 3.0 × 1.5.

## 8. Verification

| Check | Result |
|---|---|
| Headless Chrome run, throwaway harness (not in the repo), 2026-11-04 | No JS errors. No collision violations, except one transient NPC overlap sample |
| Full simulated day | Completes |
| NPCs reach the pantry | Confirmed with a 75-second lunch simulation |
| Screenshots | Show the two long tables, the lower row, the two columns, the door, and the meeting room |
| Not tested | Real devices, touch input, audio, Safari, Firefox |

## 9. Acceptance criteria

Status legend as in `docs/spec/mot-ngay-o-cong-ty.md` section 3.

| # | Criterion | Status |
|---|---|---|
| AC-52 | Two shared long tables. Left: desks 0–3 (two north, two south). Right: desks 4–6 north, 7–8 south. Seated people face each other across the table | Partly verified (screenshots, checked by eye) |
| AC-53 | Lower row: desks 9–12 face north. Player desk at bottom left, left of Thông | Partly verified (screenshots). Player desk position is an assumption (§6) |
| AC-54 | Two columns at the plan positions block movement | Verified (no collision violations; screenshot) |
| AC-55 | Front door on the east wall, aligned with the walkway. NPCs arrive and leave there. The player starts beside it | Partly verified (harness and screenshots) |
| AC-56 | Pantry top left with fridge and counter. NPCs reach pantry spots | Verified (75-second lunch simulation) |
| AC-57 | Meeting room top centre with glass walls. 8 meeting seats. "Tham gia họp" spot reachable | Partly verified (screenshots). Placement is an assumption (§6) |
| AC-58 | Daybed on the north wall, sofa north east, printer west wall, notice board by the door, cabinet south east | Partly verified (screenshots) |
| AC-59 | Layout matches the SVG by measurement | Not verified (checked by eye only) |
| AC-60 | Layout works on phones and touch devices | Not verified (headless Chrome only) |
| AC-74 | Wall clock on the north wall shows the in-game time and its hands move with the game clock. Redrawn when the in-game minute changes, and after a time skip | Partly verified (headless Chrome: face exported at 08:30, 10:10, 14:20; three different images; 14:20 hands correct). Not viewed on a real device |

## 10. Related docs

- Behavior and architecture: `docs/spec/mot-ngay-o-cong-ty.md` (section 4.1, section 5 description)
- Coworkers and seats by name: `docs/spec/dong-nghiep.md` (§1)
- Birthdays and notice board spot: `docs/spec/the-gioi-lien-tuc.md`
- Open work: `docs/tasks.md`
