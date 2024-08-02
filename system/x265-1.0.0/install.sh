#!/bin/sh
7z x Bosphorus_3840x2160_120fps_420_8bit_YUV_Y4M.7z -aoa
7z x Bosphorus_1920x1080_120fps_420_8bit_YUV_Y4M.7z -aoa
echo $? > ~/install-exit-status
if which x265 >/dev/null 2>&1 ;
then
	echo 0 > ~/install-exit-status
else
	echo "ERROR: x265 is not found on the system! This test profile needs a working x265 in the PATH."
	echo 2 > ~/install-exit-status
fi
echo "#!/bin/sh
x265 \$@ /dev/null > \$LOG_FILE 2>&1
echo \$? > ~/test-exit-status
x265 --version 2>&1 | grep version > ~/pts-footnote" > x265
chmod +x x265
