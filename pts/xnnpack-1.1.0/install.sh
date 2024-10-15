#!/bin/bash
rm -rf XNNPACK-b7b0486488393c645cefd464648da85c664380e3
unzip -o XNNPACK-b7b0486488393c645cefd464648da85c664380e3.zip
cd XNNPACK-b7b0486488393c645cefd464648da85c664380e3
mkdir build
cd build
cmake .. -DCMAKE_BUILD_TYPE=Release
make -j $NUM_CPU_CORES
echo $? > ~/install-exit-status
cd ~/
cat>xnnpack<<EOT
#!/bin/sh
cd XNNPACK-b7b0486488393c645cefd464648da85c664380e3/build
./bench-models --num_threads=\$NUM_CPU_CORES --benchmark_min_time=10 --benchmark_min_warmup_time=2 --benchmark_filter="MobileNet" > \$LOG_FILE 2>&1
echo \$? > ~/test-exit-status
EOT
chmod +x xnnpack
