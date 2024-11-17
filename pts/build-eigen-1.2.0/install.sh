#!/bin/sh
echo "#!/bin/sh
cd eigen-3.4.0/build
make doc -j \$NUM_CPU_CORES
echo \$? > ~/test-exit-status" > build-eigen
chmod +x build-eigen
