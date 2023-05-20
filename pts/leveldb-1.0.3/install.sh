#!/bin/sh

tar -xf leveldb-1.22.tar.gz
cd leveldb-1.22
sed -i '4 a #include <ctime>' ./doc/bench/db_bench_sqlite3.cc
mkdir build
cd build
cmake  -DCMAKE_BUILD_TYPE=Release ..
make -j $NUM_CPU_THREADS
echo $? > ~/install-exit-status

cd ~

cd ~
echo "#!/bin/sh
cd ~/KeyDB-5.3.1/
cd leveldb-1.22/build
./db_bench --threads=\$NUM_CPU_CORES \$@ > \$LOG_FILE
" > leveldb
chmod +x leveldb
