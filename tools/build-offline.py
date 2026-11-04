#!/usr/bin/env python3
"""Tạo index-offline.html: bản tự chứa (nhúng Three.js vào file), chạy được khi không có mạng.

Cách dùng (chạy từ thư mục dự án, cần mạng ở bước tải thư viện):
    python3 tools/build-offline.py
Kết quả: index-offline.html (giữ nguyên index.html bản dùng CDN).
Chạy lại script mỗi khi sửa index.html để hai bản luôn khớp nhau.
"""
import base64, re, sys, urllib.request
from pathlib import Path

ROOT = Path(__file__).resolve().parent.parent
SRC, OUT = ROOT / 'index.html', ROOT / 'index-offline.html'
CACHE = ROOT / 'tools' / 'three.module.min.js'

html = SRC.read_text(encoding='utf-8')
m = re.search(r'<script type="importmap">\{"imports":\{"three":"https://cdn\.jsdelivr\.net/npm/three@([0-9.]+)/build/three\.module\.js"(,"@supabase/supabase-js":"[^"]+")?\}\}</script>', html)
if not m:
    sys.exit('Không tìm thấy importmap Three.js trong index.html')
version = m.group(1)
if not CACHE.exists() or CACHE.read_text(encoding='utf-8', errors='ignore').find('REVISION') < 0 and CACHE.stat().st_size < 100000:
    url = f'https://cdn.jsdelivr.net/npm/three@{version}/build/three.module.min.js'
    print('Đang tải', url)
    CACHE.write_bytes(urllib.request.urlopen(url, timeout=60).read())
lib = CACHE.read_bytes()
data_url = 'data:text/javascript;base64,' + base64.b64encode(lib).decode('ascii')
new = ('<!-- Bản offline: Three.js ' + version + ' (MIT License, © Three.js Authors) được nhúng sẵn, không cần mạng. -->\n'
       '<script type="importmap">{"imports":{"three":"' + data_url + '"' + (m.group(2) or '') + '}}</script>')      # Supabase (đăng nhập) vẫn nạp từ CDN, cần mạng khi đăng nhập
OUT.write_text(html.replace(m.group(0), new, 1), encoding='utf-8')
print('Đã tạo', OUT, f'({OUT.stat().st_size // 1024} KB)')
