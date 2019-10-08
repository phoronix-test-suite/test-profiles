#!/bin/sh

tar -xf rocksdb-6.3.6.tar.gz
cd rocksdb-6.3.6/
mkdir build
cd build
cmake -DCMAKE_BUILD_TYPE=Release  ..
make -j $NUM_CPU_CORES
make db_bench
echo $? > ~/install-exit-status


cd ~
echo "#!/bin/bash
rm -rf /tmp/rocksdbtest-1000/dbbench/

cd rocksdb-6.3.6/build/


./db_bench \$@ -compression_type \"none\" --threads \$NUM_CPU_CORES --duration 60 > \$LOG_FILE 2>&1
echo \$? > ~/test-exit-status
" > rocksdb
chmod +x rocksdb
