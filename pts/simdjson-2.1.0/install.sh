#!/bin/sh
rm -rf simdjson-3.10.0
tar -xf simdjson-3.10.0.tar.gz
cd simdjson-3.10.0
mkdir build
cd build
cmake .. -DCMAKE_BUILD_TYPE=Release -DSIMDJSON_JUST_LIBRARY=OFF
make -j $NUM_CPU_CORES
echo $? > ~/install-exit-status
cd ~
echo "#!/bin/sh
cd simdjson-3.10.0/build/benchmark
./bench_ondemand --benchmark_min_warmup_time=2 --benchmark_min_time=30 --benchmark_filter=\$@\<simdjson_ondemand\> > \$LOG_FILE 2>&1
echo \$? > ~/test-exit-status" > simdjson
chmod +x simdjson
