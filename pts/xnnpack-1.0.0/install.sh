#!/bin/bash
rm -rf XNNPACK-2cd86b37c0be1a433a1fbc9433eef2c826e250dd
unzip -o XNNPACK-2cd86b37c0be1a433a1fbc9433eef2c826e250dd.zip
cd XNNPACK-2cd86b37c0be1a433a1fbc9433eef2c826e250dd
mkdir build
cd build
cmake .. -DCMAKE_BUILD_TYPE=Release
make -j $NUM_CPU_CORES
echo $? > ~/install-exit-status
cd ~/
cat>xnnpack<<EOT
#!/bin/sh
cd XNNPACK-2cd86b37c0be1a433a1fbc9433eef2c826e250dd/build
./end2end-bench --benchmark_min_time=8 --benchmark_min_warmup_time=2 --benchmark_filter="\$NUM_CPU_CORES/real_time" > \$LOG_FILE 2>&1
echo \$? > ~/test-exit-status
EOT
chmod +x xnnpack
