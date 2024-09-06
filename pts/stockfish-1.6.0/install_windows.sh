#!/bin/sh
unzip -o stockfish-17-windows-x86-64-avx2.zip
mv stockfish stockfish_17_win_x64_avx2
echo "#!/bin/sh
cd stockfish_17_win_x64_avx2
./stockfish-windows-x86-64-avx2.exe bench 4096 \$NUM_CPU_CORES 26 > \$LOG_FILE 2>&1" > stockfish
chmod +x stockfish

