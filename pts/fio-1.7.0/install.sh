#!/bin/sh

tar -xjf fio-2.1.13.tar.bz2
cd fio-2.1.13/
make -j $NUM_CPU_JOBS
echo $? > ~/install-exit-status
cd ~

echo "#!/bin/sh
cd fio-2.1.13/

echo \"[global]
rw=\$1
ioengine=\$2
iodepth=64
size=1g
direct=0
buffered=\$3
startdelay=5
ramp_time=5
runtime=20
time_based
disk_util=0
clat_percentiles=0
disable_lat=1
disable_clat=1
disable_slat=1
filename=fiofile

[test]
name=\$4 test
bs=\$4
stonewall\" > test.fio

if [ -w \$5 ]
then
echo \"directory=\$5\" >> test.fio
fi
./fio test.fio 2>&1 > \$LOG_FILE" > fio-run
chmod +x fio-run
