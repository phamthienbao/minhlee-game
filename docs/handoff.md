# Handoff: continue work in a new conversation

Written 2026-11-04 at the end of a very long session. Read this first, then `docs/tasks.md` (open work) and the spec files in `docs/spec/`. No secrets, emails or keys are stored here on purpose.

## 1. What this project is

"Một Ngày Ở MinhLee": a Vietnamese 3D office-day simulation in one HTML file (`index.html`, Three.js 0.160.0 from the jsDelivr CDN). 14 coworker NPCs, endless Mon–Fri days (08:30–18:00 game time, about 7.6 real minutes per day), no ending. The project owner is also coworker "Anh Bảo" (Product). Everything user-facing is in Vietnamese. Release history: `docs/changelog.md` (latest entries v2.0.x–v2.1.0-alpha, 2026-11-04).

Live copies: GitHub Pages of the repo `minhlee-game` (branch `main`, root) and a Cloudflare Pages site on the owner's own domain (auto-deploys from the same repo; the address is in the owner's Cloudflare account, ask them). A push to `main` updates both within about a minute.

## 2. How to work (important differences from older notes)

- **`index.html` is the only source.** During this session the game was edited in separate scratch parts that were concatenated; those parts do NOT exist in the repo. Edit `index.html` directly. The header comment of its script lists the numbered sections 1–14; the sign-in/cloud block is after section 14.
- **No test files in the repo** (owner's rule). Verify with throwaway pages in a scratch folder and headless Chrome. Recipe that worked: copy `index.html`, append a `setTimeout(...)` block before `</script></body>` that drives the game (`startDay()`, `update(0.1)` in a loop, `D`, `NPCS`, `Store`, `CLOUD`, `MEMBER`, `showLogin()`...), write a JSON result into `document.body` as `@@{...}@@`, then run  
  `"/Applications/Google Chrome.app/Contents/MacOS/Google Chrome" --headless=new --no-sandbox --use-angle=swiftshader --enable-unsafe-swiftshader --virtual-time-budget=30000 --dump-dom <url>` and grep the `@@...@@` text. Serve over `python3 -m http.server` when the page needs `http` (importmap + Supabase). Real network calls do not finish under virtual time; mock the Supabase client instead (examples in the changelog's Verification parts), and use Node + `npm i @supabase/supabase-js@2.45.4` for real-server probes. Screenshots: `--screenshot=file.png`.
- **Owner's standing rules** (also in `~/.claude/rules/`): spawn the `doc-keeper` agent (model haiku) after code changes and wait for it before committing; every Agent call needs a `model`; error handlers log with the debug-only `dlog` and show friendly Vietnamese messages; **commit and push only when the owner says "commit và push"**; run existing tests but do not add test files; no destructive commands without naming target and rollback.
- **`CLAUDE.md` is gitignored by the owner's choice.** Keep it updated locally, never commit it. Do not put real emails, API keys or the Supabase project URL in `docs/`.
- Language: reply to the owner in Vietnamese, short and concrete, say what was verified and what was not.

## 3. Build and deploy

- Deploy = `git push` (see above). `index.html` loads Three.js and supabase-js from the CDN, so it needs internet.
- `index-offline.html`, `dist/netlify/index.html`, `dist/MinhLee.app` and `dist/MinhLee-mac.zip` are **out of date on purpose** (owner: offline not needed for now). `tools/build-offline.py` and `tools/prepare-netlify.sh` were adapted to the two-entry importmap and still run. `dist/` holds heavy binaries tracked in git; removing it from the repo is a pending suggestion (needs the owner's OK).
- `tools/macapp/Info.plist` still says 1.8.5.

## 4. What exists (all documented in `docs/spec/`)

Gameplay: day cycle with milestones, 14 coworkers with personalities shown through speech (no trait labels), duos, surprises, day themes with intro stories, unlockable desk items, mission board, diary, pantry round table with takeaway cups and random food/drink treats, work mini-games assigned by all 14 coworkers (nag at end of day if fewer than 2 jobs done), hint-free document quest with personality reactions, "ngồi làm việc" time-lapse, 18:00 farewell scene, mid-day save and welcome-back popup, Guest mode (solo, localStorage). Address-term canon is in `docs/spec/dong-nghiep.md` (Bảo is eldest: everyone says "anh Bảo").

Multiplayer **stage 1** (login + cloud save), see `docs/spec/nhieu-nguoi-choi.md` and `docs/spec/dang-nhap-cong-ty.md`:
- Supabase (free tier). Tables `roster(email, char_id, dept)` and `progress(user_id, char_id, days, tasks_total, unlocked, affinity, diary, session, data, updated_at)` with RLS; function `claim_character()`; table grants for `authenticated` were needed (this project does not grant new tables by default). The owner runs all server SQL and creates accounts by hand (Authentication → Users → Create new user, Auto Confirm, password chosen by the owner). No email flows, no password recovery.
- Client: `SUPABASE_URL` / `SUPABASE_KEY` (publishable key, public by design) constants near the top of the script; `loginEnabled` flag; `cloudInit/cloudEnter/cloudApply/cloudFlush/cloudFlushNow/cloudConflict`, `showLogin`, `memberLogout`, `MEMBER`, `MEMBER_CALL(S)`, `applyPlayerDesk`.
- **Login is hidden from normal visitors.** It is only on in a browser opened once with `?login` (stored in `localStorage['mot-ngay.dev']`; `?login=off` turns it off). Remove the flag (make `loginEnabled` true) when the owner wants to announce it.
- A member plays as their own character: their NPC is hidden (`times.arrive = 99999`), they sit at that character's desk, others address them via `MEMBER_CALL` (e.g. "anh Bảo"; for Bảo "bạn" becomes "anh" in `fill()`).
- Saving: Store → `cloudPush()` (2 s debounce) → `cloudFlush()` with an optimistic-concurrency check on `updated_at`; `cloudFlushNow()` uses `fetch keepalive` on page close. **One open tab/device per account**: the last login takes ownership and any other place gets the "đang được mở ở nơi khác" window. (Two tabs overwriting each other caused a reported "progress reset" bug on 2026-11-04.)
- A temporary diagnostic line in the members' welcome popup ("☁ Đã tải từ máy chủ… chẩn đoán…") is still there; remove it once the owner confirms saving is stable.

## 5. Decisions already made for multiplayer (do not ask again)

Login with company email, mapped to the real character; characters without a logged-in person run as NPCs, a logged-in person replaces their NPC; max 14. Guest account (new employee) kept for fun, playing alone. Game time (not wall-clock time) but one shared clock when several people play. Per-department job content (Backend: servers, QC: bugs, ...); shared rewards are company metrics (revenue, users, version), personal rewards are desk items. Simple chat; assigning/confirming jobs by choices; nagging kept; praise/nag can be typed or auto-chosen. Offline build not needed for now. Owner wants it simple: internal fun and realtime testing; the owner's spouse may test with a non-company email mapped to a spare character (update `roster`).

## 6. Next steps (in this order)

1. Commit/push state is current as of the last push; check `git log` and `git status` first.
2. Owner real-world checks pending: two-tab conflict window, keepalive save on close, accounts for the other 13 people, spouse test account.
3. **Stage 2: see each other** (Supabase Realtime): channel per game day; Presence for who is online; Broadcast player position/pose about 5–10 Hz; remote humans drawn as that character, their NPC hidden on every client; first version without chat and without shared NPC simulation (NPCs may differ between machines). Then stage 3 (shared clock from server time, a "NPC host" client chosen among online players broadcasting NPC positions and events), stage 4 (department jobs and company metrics), stage 5 (chat, assign/confirm, praise/nag), stage 6 (polish, test with real people). Keep Guest working solo throughout.
4. Possible small items: a "move Guest progress into my account" button; address terms per speaker (NPC "mình" toward Anh Bảo should be "em"); native-speaker review of Vietnamese lines; real-device tests; `CLAUDE.md` stays local.

## 7. Where to look

- Open work and known defects: `docs/tasks.md`; terms: `docs/glossary.md`; player guide: `docs/product-guide.md`.
- Specs: `mot-ngay-o-cong-ty.md` (core), `dong-nghiep.md` (people, address terms), `ngoai-hinh-dong-nghiep.md` (looks), `van-phong-layout.md`, `noi-dung-bat-ngo.md`, `the-gioi-lien-tuc.md`, `bang-nhiem-vu.md`, `nhiem-vu-tai-lieu.md`, `ngoi-lam-viec.md`, `tan-ca-18-gio.md`, `nhieu-nguoi-choi.md`, `dang-nhap-cong-ty.md`.
