#!/bin/sh

echo "#!/bin/sh

cd gcc-8.4.0
make -s -j \$NUM_CPU_CORES 2>&1
echo \$? > ~/test-exit-status" > build-gcc

chmod +x build-gcc
