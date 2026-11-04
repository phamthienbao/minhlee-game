#!/bin/bash
# Tạo dist/MinhLee.app (universal: Apple Silicon + Intel) và dist/MinhLee-mac.zip để gửi cho đồng nghiệp.
# Yêu cầu: macOS + Xcode Command Line Tools (swiftc). Chạy lại sau mỗi lần sửa index.html.
set -euo pipefail
ROOT="$(cd "$(dirname "$0")/.." && pwd)"
SRC="$ROOT/tools/macapp"
APP="$ROOT/dist/MinhLee.app"
TMP="$ROOT/dist/.build"
mkdir -p "$TMP" "$APP/Contents/MacOS" "$APP/Contents/Resources"

python3 "$ROOT/tools/build-offline.py"                                  # 1. bản offline mới nhất

for ARCH in arm64 x86_64; do                                            # 2. biên dịch cho cả hai kiến trúc
  swiftc -O -swift-version 5 -target "$ARCH-apple-macos11.0" -o "$TMP/MinhLee-$ARCH" "$SRC/main.swift"
done
lipo -create -output "$APP/Contents/MacOS/MinhLee" "$TMP/MinhLee-arm64" "$TMP/MinhLee-x86_64"

cp "$SRC/Info.plist" "$APP/Contents/Info.plist"                         # 3. đóng gói tài nguyên
cp "$SRC/AppIcon.icns" "$APP/Contents/Resources/AppIcon.icns"
cp "$ROOT/index-offline.html" "$APP/Contents/Resources/index.html"

codesign --force --deep -s - "$APP"                                     # 4. ký ad-hoc (không cần tài khoản Apple Developer)
( cd "$ROOT/dist" && ditto -c -k --keepParent MinhLee.app MinhLee-mac.zip )
echo "Xong: $APP"
echo "Gói để gửi:  $ROOT/dist/MinhLee-mac.zip"
