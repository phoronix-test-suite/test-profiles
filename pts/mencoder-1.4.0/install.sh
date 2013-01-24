#!/bin/sh

tar -xvzf MPlayer-1.1.tar.gz
cd MPlayer-1.1/
./configure
make -j $NUM_CPU_JOBS
echo $? > ~/install-exit-status
cd ~/

echo "#!/bin/sh
cd MPlayer-1.1/
./mencoder \$TEST_VIDEO_SAMPLE/pts-trondheim.avi -o /dev/null -ovc lavc -oac copy -lavcopts vcodec=mpeg4:mbd=2:trell=1:v4mv=1:vstrict=1
echo \$? > ~/test-exit-status" > mencoder
chmod +x mencoder
