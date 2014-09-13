#!/bin/sh

tar -xjf fio-2.1.11.tar.bz2
cd fio-2.1.11/
make -j $NUM_CPU_JOBS
echo $? > ~/install-exit-status
cd ~

echo "#!/bin/sh
cd fio-2.1.11/
cat \$1 > test.fio
if [ -w \$2 ]
then
echo \"directory=\$2\" >> test.fio
fi
./fio test.fio 2>&1 > \$LOG_FILE" > fio-run
chmod +x fio-run
