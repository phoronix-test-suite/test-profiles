#!/bin/sh

echo "#!/bin/sh

cd linux-3.18-rc3/
make -s -j \$NUM_CPU_JOBS 2>&1
echo \$? > ~/test-exit-status" > time-compile-kernel

chmod +x time-compile-kernel
