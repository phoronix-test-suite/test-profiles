#!/bin/sh

tar -xjf fio-1.57.tar.bz2
cd fio-1.57/
make -j $NUM_CPU_JOBS
echo $? > ~/install-exit-status
cd ..

echo "#!/bin/sh
cd fio-1.57/
./fio \$@ 2>&1" > fio-run
chmod +x fio-run
