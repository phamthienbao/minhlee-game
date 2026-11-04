# Deploy and Share

Status: v1.8.5 (2026-11-04). No change to sharing steps in v1.8.5; recipient advice names Safari or an updated Chrome (since v1.8.3, `docs/spec/tuong-thich-trinh-duyet.md` §3).

## Before you share

- The game shows coworkers' names and stylized likenesses. Get their consent before sharing outside the team, and prefer private sharing (option 1).
- Save data stays in each person's browser (`localStorage`). The game uploads nothing.
- The only network request is the Three.js download from the jsDelivr CDN, made by `index.html` on first load.

## Option 1: send the file (private, simplest)

1. Send `index.html` through company chat or a shared drive.
2. The recipient double-clicks it, or uses File > Open, in a current browser (Chrome 89+, Edge 89+, Firefox 108+, Safari 16.4+).

- Works from `file://`, with no hosting.
- The first open needs internet to download Three.js. After that the game runs offline in that browser.
- Progress is saved per browser. Another browser or device starts a new save.
- If the recipient may have no internet at all, send `index-offline.html` instead (option 3).
- Do not send the link inside Zalo, Messenger, Facebook, Instagram, TikTok, Line, WeChat, or Snapchat. 3D often does not show there. Tell the recipient to tap ⋯ and choose "Mở bằng trình duyệt" (open in browser), then open the link in Safari (iPhone or Mac), or in the updated Chrome (Android or Windows). The game shows a banner with the same advice in those apps.

## Option 2: free static host (link)

Upload `index.html` to a free static host and share the link. Keep the file name `index.html`.

- Netlify Drop: put `index.html` in a folder and drag the folder onto the Drop page.
- Cloudflare Pages: create a project with direct upload and add the file.
- GitHub Pages: commit `index.html` to a repository and enable Pages in the repository settings. Check GitHub's current rules for private repositories first.

Maintainers: `tools/prepare-netlify.sh` runs `tools/build-offline.py` and copies `index-offline.html` to `dist/netlify/index.html`, ready to drop on Netlify. The file is named `index.html` but holds the offline copy (Three.js inlined, no CDN request).

Caution: a link is public unless the host protects it. Anyone with the link can open the game and see the coworkers' names and likenesses. Check the host's access-protection options before you upload. For sharing inside the company, use option 1.

## Option 3: offline file (built, v1.5.0)

`index-offline.html` (about 1.1 MB, about 0.9 MB larger than `index.html`) is the same game with Three.js inlined. It makes no network request. Use it for USB sticks, intranet shares, or places without internet.

Maintainers: this file is generated. After any edit to `index.html`, run this from the project root, then send the regenerated file:

```
python3 tools/build-offline.py
```

The first run downloads `tools/three.module.min.js` (needs internet once). Later runs use the cached copy.

Status: headless Chrome (3D, `?lite`, mid-game fallback). Real Safari 27.0.1 on macOS 27 rendered the 3D scene in the v1.7.0 check (file not recorded). Not tested in Firefox, Edge, or mobile browsers.

## Option 4: macOS app (built, v1.6.0)

`dist/MinhLee-mac.zip` (about 1.5 MB) holds `MinhLee.app`. It is the offline game (`index-offline.html`) in its own Mac window. No browser, no network. Technical details: `docs/spec/phan-phoi-offline.md` §8.

Send the zip only: `dist/MinhLee-mac.zip`. Do not send `dist/.build` or a loose `MinhLee.app`.

Recipient, on a Mac:

1. Double-click `MinhLee-mac.zip` to unzip it. Optionally move `MinhLee.app` to Applications.
2. First open: macOS warns that the app cannot be verified. The app is ad-hoc signed and not notarized, so this is expected. Right-click (or Control-click) `MinhLee.app`, choose **Open**, then click **Open** in the dialog. Later opens are normal.
3. If macOS says the app is **damaged** and will not open, open Terminal and run the command below. Drag `MinhLee.app` into the Terminal window to fill in the path, then press Return. Use it only for a file that came from the team.

```
xattr -dr com.apple.quarantine MinhLee.app
```

- Requires macOS 11 or later (`LSMinimumSystemVersion` 11.0). Tested only on Apple Silicon with macOS 27. Intel Macs and older macOS versions are not tested.
- macOS only. Windows coworkers cannot use this option. Send `index-offline.html` (option 3) instead. A Windows build is not made yet.
- Save data is kept by the app, separately from any browser. Another Mac or a browser starts a new save.

Maintainers, on a Mac with Xcode Command Line Tools (`swiftc`):

```
tools/build-mac-app.sh
```

The script rebuilds `index-offline.html`, compiles arm64 and x86_64, joins them with `lipo`, signs ad-hoc, and writes `dist/MinhLee.app` and `dist/MinhLee-mac.zip`. Run it after every change to `index.html`, because the app holds its own copy of the game.

Status: built and self-tested on one Mac (macOS 27, Apple Silicon). Not yet checked by eye, with audio, on Intel, or on a second Mac through Gatekeeper.
