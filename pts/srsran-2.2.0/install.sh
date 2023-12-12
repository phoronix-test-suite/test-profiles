#!/bin/sh
tar -xf srsRAN_Project-release_23_10_1.tar.gz
cd srsRAN_Project-release_23_10_1/
mkdir build
cd build
cmake -DENABLE_GUI=OFF -DCMAKE_BUILD_TYPE=Release ..
make -j $NUM_CPU_CORES
echo $? > ~/install-exit-status
cd ~
echo "#!/bin/sh
cd srsRAN_Project-release_23_10_1/build/
./\$@ 2>&1 > \$LOG_FILE
echo \$? > ~/test-exit-status" > srsran
chmod +x srsran
