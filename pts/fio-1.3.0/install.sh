#!/bin/sh

tar -xjf fio-2.1.9.tar.bz2
cd fio-2.1.9/
make -j $NUM_CPU_JOBS
echo $? > ~/install-exit-status
cd ~

echo "#!/bin/sh
cd fio-2.1.9/
./fio \$@ 2>&1" > fio-run
chmod +x fio-run
