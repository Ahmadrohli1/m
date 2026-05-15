#!/bin/bash
# Pindah ke folder project
cd ~/m

# Ambil daftar file MP3 dan buat format array JavaScript
songs=$(ls *.mp3 | sed 's/.*/"&",/' | tr '\n' ' ' | sed 's/,$//')

# Masukkan ke dalam index.html
cat <<HTML > index.html
<!DOCTYPE html>
<html lang="id">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>ROHLI PLAYER AUTO</title>
    <style>
        * { margin: 0; padding: 0; box-sizing: border-box; }
        body { 
            background: linear-gradient(rgba(0,0,0,0.4), rgba(0,0,0,0.7)), url('Cantik.jpg');
            background-size: cover; background-position: center; background-attachment: fixed;
            color: #fff; font-family: sans-serif; height: 100vh; display: flex; flex-direction: column; 
        }
        .player-ui { padding: 30px 20px; text-align: center; background: rgba(0,0,0,0.1); backdrop-filter: blur(8px); }
        #t { font-size: 1.2rem; color: #1db954; text-transform: uppercase; margin-bottom: 20px; }
        .controls { display: flex; gap: 20px; justify-content: center; align-items: center; }
        .btn-main { width: 55px; height: 55px; border-radius: 50%; border: none; background: #fff; font-size: 1.2rem; }
        .btn-nav { background: none; border: none; color: #fff; font-size: 1.8rem; }
        .playlist { flex-grow: 1; background: rgba(0,0,0,0.2); padding: 10px 20px; overflow-y: auto; }
        .song-item { padding: 15px; border-bottom: 1px solid rgba(255,255,255,0.05); cursor: pointer; }
        .active { background: rgba(29, 185, 84, 0.2); color: #1db954; border-radius: 10px; }
    </style>
</head>
<body>
    <div class="player-ui">
        <h2 id="t">Memuat...</h2>
        <div class="controls">
            <button class="btn-nav" onclick="c(-1)">⏮</button>
            <button class="btn-main" id="pBtn" onclick="togglePlay()">▶</button>
            <button class="btn-nav" onclick="c(1)">⏭</button>
        </div>
        <audio id="a"></audio>
    </div>
    <div class="playlist" id="list"></div>
    <script>
        const s = [$songs];
        let i = 0;
        const a = document.getElementById('a'), t = document.getElementById('t'), l = document.getElementById('list'), pB = document.getElementById('pBtn');
        function build() { l.innerHTML = s.map((n, idx) => \`<div class="song-item \${idx===i?'active':''}" onclick="lS(\${idx})">\${idx+1}. \${n.replace('.mp3','')}</div>\`).join(''); }
        function lS(x) { i = x; a.src = s[i]; t.innerText = s[i].replace('.mp3','').toUpperCase(); build(); a.play(); pB.innerText = "⏸"; }
        function togglePlay() { if(a.paused){ a.play(); pB.innerText="⏸"; } else { a.pause(); pB.innerText="▶"; } }
        function c(d) { i = (i + d + s.length) % s.length; lS(i); }
        a.onended = () => c(1);
        build(); lS(0); a.pause();
    </script>
</body>
</html>
HTML

echo "Index.html berhasil diperbarui dengan $(ls *.mp3 | wc -l) lagu."
