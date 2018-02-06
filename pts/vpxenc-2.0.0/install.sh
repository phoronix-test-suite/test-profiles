#!/bin/sh

tar -xzf libvpx-1.7.0.tar.gz

mkdir vpx
cd libvpx-1.7.0

./configure --disable-install-docs --enable-shared --prefix=$HOME/vpx
make -j $NUM_CPU_JOBS
echo $? > ~/install-exit-status
make install
cd ~
rm -rf libvpx-1.7.0

echo "#!/bin/sh
cd vpx/bin
LD_PRELOAD=../lib/libvpx.so.5  ./vpxenc --good --cpu-used=5 --codec=vp9 --psnr -v --threads=\$NUM_CPU_CORES --tile-columns=4 -o /dev/null ~/big_buck_bunny_720p_h264.mov --width=1280 --height=720 2> \$LOG_FILE 
echo \$? > ~/test-exit-status" > vpxenc
chmod +x vpxenc
