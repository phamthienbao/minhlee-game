# Spec: Tương thích trình duyệt và chế độ dự phòng (Browser compatibility and fallbacks)

Status: v1.8.5 (2026-11-04). No help-text change since v1.8.3 (§3); the boot-error text, with Safari or updated Chrome as tip ①, is accepted as-is.

## 1. Goal

- A browser that cannot run the 3D game says so before the player presses start.
- An in-app browser (Zalo, Messenger, and others) gets a banner that asks the player to open the link in a real browser.
- If 3D rendering fails, the player is told why and can keep playing in list mode (`#lite`).
- Every one of those messages points to a next step that is likely to work: Safari, or an updated Chrome (v1.8.3).

## 2. Layers, in the order they run

| Step | Where (`index.html`) | What it does | What the player sees |
|---|---|---|---|
| 1. Env check | Classic `<script>` in `<head>`, after the boot timer | `HTMLScriptElement.supports('importmap')` sets `window.__env.noMap`. A user-agent test sets `window.__env.inApp`. On `DOMContentLoaded`: `noMap` shows `#env-note` and sets `#btn-start` text | Too-old message, or in-app banner |
| 2. Boot timer | Same script | 10 s after load, if `window.__gameReady` is still false, `#boot-error` is shown | Boot error with three things to try |
| 3. Renderer creation | `init()` (module) | `new THREE.WebGLRenderer` with `antialias: true`, then `antialias: false`. If both throw, `LITE = true` and `LITE_WHY = 'webgl'` | List mode, with a WebGL note in `#env-note` |
| 4. Title toggle | `#btn-lite`, set in `init()` | Stores the choice in `settings.lite` and reloads without `?lite` | Button label switches between the two modes |
| 5. Render watchdog | `frame()` | On the 150th counted frame, if `renderer.info.render.calls === 0`, calls `fallbackToLite('render')` | Toast, then list mode |
| 6. Context-loss timer | `webglcontextlost` listener in `init()` | Calls `preventDefault()`, shows a toast, starts a 4 s timer. `webglcontextrestored` clears it. If the timer fires, calls `fallbackToLite('lost')` | Toast, then list mode after 4 s |
| 7. Mid-game switch | `fallbackToLite(why)` | Sets `LITE`, hides `#game`, `#stick`, `#keys`, `#act`. Shows `#lite` if the day has started. Refreshes the list every 800 ms | Toast for 9 s (text below) |

Notes:

- Step 5 counts frames only after the game starts and not while paused. It runs once, on the 150th counted frame. It does not re-check later.
- Steps 5 and 6 do not write to `settings.lite`. The next page load tries 3D again.
- Step 1 `noMap` is true whenever `HTMLScriptElement.supports` is missing or returns false. The check cannot tell "no import map support" from "no `supports` function" (see §6).

## 3. Triggers and messages

| `LITE_WHY` | Trigger | Title note (`#env-note`) | `#btn-lite` label | Button action |
|---|---|---|---|---|
| `user` | `settings.lite` is true, or `?lite` is in the URL | None | "🎮 Thử lại chế độ 3D" | Sets `settings.lite` to false, reloads |
| `webgl` | Both renderer attempts fail | See the WebGL note below | "🧩 Không thấy hình? Dùng chế độ đơn giản" | Sets `settings.lite` to true, reloads |
| `render` | Watchdog (mid-game) | None on this load | Unchanged (set at load) | None |
| `lost` | Context not restored within 4 s | None on this load | Unchanged (set at load) | None |
| (none) | 3D running | Shown only if in-app | "🧩 Không thấy hình? Dùng chế độ đơn giản" | Sets `settings.lite` to true, reloads |

### 3.1 Texts (Vietnamese, as in the code, v1.8.3)

Messages shown before the game starts:

| Condition | `#env-note` text | `#btn-start` text |
|---|---|---|
| No import map support (`noMap`) | "Trình duyệt này quá cũ nên chưa chạy được game 3D. Hãy thử mở bằng Safari, hoặc cập nhật Chrome lên bản mới nhất rồi tải lại trang." | "Trình duyệt chưa hỗ trợ" (button stays disabled, because the module never runs) |
| In-app browser (`inApp`) | "Bạn đang mở trong một ứng dụng (Zalo, Messenger…), đồ họa 3D có thể không hiện. Hãy bấm biểu tượng ⋯ rồi chọn “Mở bằng trình duyệt”, và mở bằng Safari (iPhone, Mac) hoặc Chrome đã cập nhật (Android, Windows)." | Unchanged |

Generic boot error (`#boot-error`): "Game chưa khởi động được. Bạn thử: ① mở bằng Safari, hoặc cập nhật Chrome lên bản mới nhất, ② nếu đang mở trong Zalo hoặc Messenger thì chọn “Mở bằng trình duyệt”, ③ kiểm tra mạng rồi tải lại trang." Accepted as-is (2026-11-04): tip ① is the Safari / Chrome tip, placed first, as v1.8.3 specified.

WebGL note (`#env-note`, `LITE_WHY === 'webgl'`, title screen): "Máy hoặc trình duyệt của bạn đang tắt đồ họa 3D (WebGL) nên game chạy ở chế độ danh sách đơn giản. Muốn xem 3D: hãy thử mở bằng Safari, hoặc cập nhật Chrome lên bản mới nhất rồi tải lại trang (nếu dùng Chrome, nhớ bật “Tăng tốc phần cứng” trong Cài đặt)."

Mid-game and list-mode texts:

| Where | Text | Duration |
|---|---|---|
| Toast, switch to list mode (`fallbackToLite()`, any `why`). Two lines, the second starts "Hãy thử…" | "Đồ họa 3D trên máy bạn không chạy được, game chuyển sang chế độ danh sách đơn giản." then "Hãy thử mở bằng Safari hoặc cập nhật Chrome rồi tải lại trang." | 9 s (was 6 s before v1.8.3) |
| Toast, context lost | "Đồ họa tạm gián đoạn, đang khôi phục…" | 4 s (unchanged) |
| List-mode panel note, automatic switch (`LITE_WHY !== 'user'`) | "Chế độ đơn giản (trình duyệt không hiện được 3D): chọn nơi hoặc người muốn tương tác. Muốn xem 3D, hãy thử mở bằng Safari hoặc cập nhật Chrome lên bản mới nhất rồi tải lại trang." | Shown while `#lite` is visible |
| List-mode panel note, chosen by the player (`LITE_WHY === 'user'`) | "Chế độ đơn giản: chọn nơi hoặc người muốn tương tác. Muốn xem 3D thì quay về màn hình chính và bấm “Thử lại chế độ 3D”." | Shown while `#lite` is visible |

The texts name Safari and Chrome for every platform, except the in-app banner. That banner names the device (Safari on iPhone and Mac, Chrome on Android and Windows). The game does not detect the platform for the other messages.

## 4. Browser support

Import maps and ES modules are required. Minimums as stated in the v1.7.0 limitation note (not re-tested for v1.7.0 or v1.8.3):

| Browser | Minimum | Tested for v1.7.0 |
|---|---|---|
| Safari | 16.4 | Safari 27.0.1 on macOS 27 (Apple GPU): 3D rendered (CP-8). Older Safari not tested |
| Chrome | 89 | Headless Chrome only (CP-9) |
| Edge | 89 | Not tested |
| Firefox | 108 | Not tested |
| iOS Safari, Android Chrome | Not stated | Not tested |
| In-app browsers | Not stated. The banner says 3D may not show | Not tested. The banner is a source check only |

In-app user-agent tokens checked by `index.html` (case-insensitive): `Zalo`, `FBAN`, `FBAV`, `FB_IAB`, `Messenger`, `Instagram`, `MicroMessenger` (WeChat), `TikTok`, `Snapchat`, `Line/`. Snapchat is in the code but was not in the original brief.

Known limitation: browsers below these minimums get the too-old message and no game. A classic (non-module) bundle for them is an optional follow-up (`docs/tasks.md`).

## 5. Acceptance criteria

Status legend as in `docs/spec/mot-ngay-o-cong-ty.md` §3.

| # | Criterion | Status |
|---|---|---|
| CP-1 | A browser without import map support shows the too-old message and the "Trình duyệt chưa hỗ trợ" button text | Source check only (no old browser run) |
| CP-2 | An in-app user agent shows the "Mở bằng trình duyệt" banner | Source check only (no real in-app browser run) |
| CP-3 | Both renderer attempts failing gives list mode with the WebGL note on the title screen | Simulated |
| CP-4 | `?lite` in the URL starts in list mode, and the title button switches the mode and survives reload | `?lite` verified in headless Chrome. Button not recorded |
| CP-5 | Watchdog: 0 draw calls on the 150th counted frame switches to list mode with a toast | Simulated. Not with a broken GPU |
| CP-6 | Context lost for more than 4 s switches to list mode with a toast | Simulated. Not with a real context loss |
| CP-7 | Mid-game `fallbackToLite()` keeps the day playable in list mode | Verified in headless Chrome |
| CP-8 | 3D renders in real Safari | Verified: Safari 27.0.1, macOS 27, Apple GPU. webgl2 and webgl1 available, 226 draw calls, 6128 triangles, 7 programs, no errors, canvas 3608×2308. Measured with a temporary on-page diagnostic. No Safari settings changed. The file loaded is not recorded |
| CP-9 | Full simulated day in 3D mode, headless Chrome | Verified |
| CP-10 | Boot error text lists three things to try | Source check only |
| CP-11 | Older Safari (below 16.4), iOS Safari, Firefox, Edge, Android Chrome, in-app browsers, WebGL disabled by policy, a genuinely broken GPU | Not verified |
| CP-12 | v1.8.3: the mid-game toast, the list-mode note, the boot-error text, and the title WebGL note (WebGL creation forced to fail) each contain the Safari or Chrome suggestion | Headless Chrome check, reported by the requester. Not re-run in the doc pass. Texts confirmed in `index.html` source and in the built files |
| CP-13 | v1.8.3: the too-old message and the in-app banner contain the Safari or Chrome suggestion | Source check only |
| CP-14 | v1.8.3: the suggestion is shown on a real affected machine (Safari on iPhone or Mac, updated Chrome on Android or Windows, in-app browser, Chrome with hardware acceleration off) | Not verified |

## 6. Known risks

- `noMap` uses `HTMLScriptElement.supports('importmap')`. A browser that runs the game but lacks `supports` would show the too-old message. Confirm `#env-note` stays hidden in Safari 27 and in Chrome.
- The render watchdog checks one frame only (the 150th counted frame). A GPU that fails later is not caught by it. The context-loss timer covers the lost-context case.
- Both fallbacks are simulated. Nothing here has been checked against a real failing GPU.
- The Safari report from players ("could open the game in Safari afterwards") has no identified cause. See `docs/tasks.md`.
- The Safari and Chrome suggestions are advice, not a fix. They are not known to resolve the "no graphics" reports (v1.8.3 CP-14).

## 7. Open items

Tracked in `docs/tasks.md` under "Compatibility (v1.7.0)" and "Help text (v1.8.3)".
