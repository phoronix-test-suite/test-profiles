#!/bin/sh

tar -jxf stream-2013-01-17.tar.bz2
cc stream.c -O3 -march=native -fopenmp -o stream-bin
echo \$? > ~/install-exit-status

echo "#!/bin/sh
export OMP_NUM_THREADS=\$NUM_CPU_CORES
./stream-bin > \$LOG_FILE 2>&1
echo \$? > ~/test-exit-status" > stream
chmod +x stream
