#!/bin/bash
# Tạo thư mục dist/netlify/ chỉ gồm một file index.html (bản offline, tự chứa) để kéo thả lên Netlify.
# Chạy lại sau mỗi lần sửa game, rồi kéo thả thư mục này vào mục Deploys của site (hoặc dùng CLI bên dưới).
set -euo pipefail
ROOT="$(cd "$(dirname "$0")/.." && pwd)"
python3 "$ROOT/tools/build-offline.py"
mkdir -p "$ROOT/dist/netlify"
cp "$ROOT/index-offline.html" "$ROOT/dist/netlify/index.html"
echo "Sẵn sàng: $ROOT/dist/netlify/index.html ($(du -k "$ROOT/dist/netlify/index.html" | cut -f1) KB)"
echo "Kéo thả thư mục dist/netlify vào Netlify > Site > Deploys, hoặc:  npx netlify-cli deploy --prod --dir=dist/netlify"
