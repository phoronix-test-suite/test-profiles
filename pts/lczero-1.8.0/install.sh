#!/bin/sh
rm -rf lc0-0.31.1
tar -xf lc0-0.31.1.tar.gz
cd lc0-0.31.1
mkdir build
meson build --buildtype release -Dgtest=false
cd build
ninja
echo $? > ~/install-exit-status
cd ~
gunzip t1-256x10-distilled-swa-2432500.pb.gz
cp -f t1-256x10-distilled-swa-2432500.pb lc0-0.31.1/build/
echo "#!/bin/bash
cd  lc0-0.31.1/build/
./lc0 \$@ --threads=\$NUM_CPU_CORES -w t1-256x10-distilled-swa-2432500.pb > \$LOG_FILE 2>&1
echo \$? > ~/test-exit-status" > lczero
chmod +x lczero
