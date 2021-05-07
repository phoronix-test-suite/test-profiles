#!/bin/sh

tar -xf pjproject-2.11.tar.gz
cd pjproject-2.11
./configure
make dep -j $NUM_CPU_CORES
make -j $NUM_CPU_CORES
echo $? > ~/install-exit-status

cd ~

echo "#!/bin/bash
cd pjproject-2.11
././pjsip-apps/bin/samples/*/pjsip-perf --thread-count=\$NUM_CPU_PHYSICAL_CORES --window=10000 --count=2000000 --real-sdp \$@ > \$LOG_FILE 2>&1
echo \$? > ~/test-exit-status

sed -i 's/=/ /g' \$LOG_FILE" > pjsip
chmod +x pjsip
