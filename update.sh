#!/bin/bash
# Ganti spasi ke underscore
for f in *.mp3; do mv "$f" "${f// /_}" 2>/dev/null; done
# Ambil semua list mp3 yang ada di folder saat ini
songs=$(ls *.mp3 | sed "s/.*/'&',/" | tr -d '\n' | sed 's/,$//')
# Masukkan ke index.html dan pastikan tertulis benar
sed -i "s|let s = \[.*\];|let s = [$songs];|" index.html
echo "Daftar lagu berhasil diperbarui."
