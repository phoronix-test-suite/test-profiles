#!/bin/sh
chmod +x FluidX3D-Benchmark-*.exe
echo "#!/bin/sh
./FluidX3D-Benchmark-\$1-Linux.exe > \$LOG_FILE 2>&1
echo \$? > ~/test-exit-status" > fluidx3d
chmod +x fluidx3d
