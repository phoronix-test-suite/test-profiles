#!/bin/sh
chmod +x FluidX3D-Benchmark-*
echo "#!/bin/sh
./FluidX3D-Benchmark-\$1-Linux-30 > \$LOG_FILE 2>&1
echo \$? > ~/test-exit-status" > fluidx3d
chmod +x fluidx3d
