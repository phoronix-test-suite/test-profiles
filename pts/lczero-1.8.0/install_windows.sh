#!/bin/sh
unzip -o lc0-v0.31.1-windows-cpu-openblas.zip
chmod +x lc0.exe
gunzip t1-256x10-distilled-swa-2432500.pb.gz
echo "#!/bin/sh
./lc0.exe \$@ --threads=\$NUM_CPU_CORES -w t1-256x10-distilled-swa-2432500.pb > \$LOG_FILE 2>&1
echo \$? > ~/test-exit-status" > lczero
chmod +x lczero
