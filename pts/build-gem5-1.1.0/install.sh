#!/bin/sh
echo "#!/bin/sh
cd gem5-23.0.1.0
scons -j \$NUM_CPU_CORES
echo \$? > ~/test-exit-status" > build-gem5
chmod +x build-gem5
