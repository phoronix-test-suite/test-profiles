#!/bin/sh

tar -xjf ffmpeg-0.10.tar.bz2
mkdir ffmpeg_/

cd ffmpeg-0.10/
./configure --disable-zlib --prefix=$HOME/ffmpeg_/
make -j $NUM_CPU_JOBS
echo $? > ~/install-exit-status
make install
cd ..
rm -rf ffmpeg-0.10/
rm -rf ffmpeg_/lib/

echo "#!/bin/sh

./ffmpeg_/bin/ffmpeg -i \$TEST_EXTENDS/pts-trondheim.avi -threads \$NUM_CPU_CORES -y -target ntsc-vcd /dev/null 2>&1
echo \$? > ~/test-exit-status" > ffmpeg
chmod +x ffmpeg
