#!/bin/sh

tar -xf aom-add4b15580e410c00c927ee366fa65545045a5d9.tar.gz
cd aom/build
cmake ..
make -j $NUM_CPU_CORES
echo $? > ~/install-exit-status
cd ~

7z x Bosphorus_1920x1080_120fps_420_8bit_YUV_Y4M.7z

echo "#!/bin/sh
./aom/build/aomenc -v --good --threads=\$NUM_CPU_CORES --tile-columns=2 --limit=3 --row-mt=1 -o test.av1 Bosphorus_1920x1080_120fps_420_8bit_YUV.y4m > \$LOG_FILE 2>&1
echo \$? > ~/test-exit-status" > aom-av1
chmod +x aom-av1
