#!/bin/bash
# 1. Ganti spasi dengan underscore agar aman di web
for f in *.mp3; do mv "$f" "${f// /_}" 2>/dev/null; done
# 2. Ambil semua list mp3
songs=$(ls *.mp3 | sed "s/.*/'&',/" | tr -d '\n' | sed 's/,$//')
# 3. Masukkan ke index.html
sed -i "s|let s = \[.*\];|let s = [$songs];|" index.html
echo "Berhasil memperbarui playlist dengan $(ls *.mp3 | wc -l) lagu."
