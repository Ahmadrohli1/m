#!/bin/bash
songs=$(ls *.mp3 | sed "s/.*/'&',/" | tr -d '\n' | sed 's/,$//')
# Set transparansi ke 0 (Foto 100% jernih)
sed -i "s|let s = \[.*\];|let s = [$songs];|" index.html
sed -i "s/rgba(0,0,0,0.1), rgba(0,0,0,0.3)/rgba(0,0,0,0.0), rgba(0,0,0,0.0)/" index.html
echo "Daftar lagu telah dinormalisasi dan dimasukkan."
