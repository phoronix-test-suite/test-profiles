#!/bin/sh
if which gm >/dev/null 2>&1 ;
then
	echo 0 > ~/install-exit-status
else
	echo "ERROR: gm is not found on the system! This test profile needs a working GraphicsMagick gm binary in the PATH."
	echo 2 > ~/install-exit-status
fi
gm convert sample-photo-mars.jpg input.mpc
echo "#!/bin/sh
OMP_NUM_THREADS=\$NUM_CPU_CORES gm benchmark -duration 60 convert input.mpc \$@ null: > \$LOG_FILE 2>&1
echo \$? > ~/test-exit-status
gm version 2>/dev/null | head -1 > ~/pts-footnote" > graphics-magick
chmod +x graphics-magick
