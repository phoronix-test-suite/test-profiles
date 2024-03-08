#!/bin/sh
unzip -o srsRAN_Project-bcf941b34faba5e14b4d614772fa45068721afdf.zip
cd srsRAN_Project-bcf941b34faba5e14b4d614772fa45068721afdf/
mkdir build
cd build
cmake -DENABLE_GUI=OFF -DCMAKE_BUILD_TYPE=Release ..
make -j $NUM_CPU_CORES
echo $? > ~/install-exit-status
cd ~
echo "#!/bin/sh
cd srsRAN_Project-bcf941b34faba5e14b4d614772fa45068721afdf/build/
./\$@ 2>&1 > \$LOG_FILE
echo \$? > ~/test-exit-status" > srsran
chmod +x srsran
