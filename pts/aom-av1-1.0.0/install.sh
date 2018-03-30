#!/bin/sh

tar -xf aom-20180330.tar.xz
cd aom/build
cmake ..
make -j $NUM_CPU_CORES
echo $? > ~/install-exit-status
cd ~

7z x Bosphorus_1920x1080_120fps_420_8bit_YUV_Y4M.7z

echo "#!/bin/sh
./aom/build/aomenc -v --good --threads=\$NUM_CPU_CORES --tile-columns=2 --limit=3 -o test.av1 Bosphorus_1920x1080_120fps_420_8bit_YUV.y4m > \$LOG_FILE 2>&1
echo \$? > ~/test-exit-status" > aom-av1
chmod +x aom-av1
