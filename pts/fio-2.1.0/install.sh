#!/bin/sh
tar -xzf fio-3.36.tar.gz
cd fio-3.36
./configure --extra-cflags="-O3 -fcommon"
if [ "$OS_TYPE" = "BSD" ]
then
	gmake -j $NUM_CPU_CORES
else
	make -j $NUM_CPU_CORES
fi
echo $? > ~/install-exit-status
cd ~
echo "#!/bin/sh
cd fio-3.36
if [ \"X\$7\" = \"X\" ]
then
	DIRECTORY_TO_TEST=\"fiofile\"
else
	DIRECTORY_TO_TEST=\"\$7/fiofile\"
fi
if [ \"X\$6\" = \"X\" ]
then
	NUM_JOBS=1
else
	NUM_JOBS=\"\$6\"
fi
if [ \"\$2\" = \"io_uring\" ]
then
	FORCE_ASYNC=\"force_async=4\"
else
	FORCE_ASYNC=\"\"
fi
echo \"[global]
rw=\$1
ioengine=\$2
iodepth=64
size=1g
direct=\$3
startdelay=20
\$FORCE_ASYNC
ramp_time=5
runtime=60
group_reporting=1
numjobs=\$NUM_JOBS
time_based\" > test.fio
if [ \"\${OPERATING_SYSTEM}\" != \"freebsd\" ]
then
	echo \"disk_util=0\" >> test.fio
fi
echo \"clat_percentiles=0
disable_lat=1
disable_clat=1
disable_slat=1
filename=\$DIRECTORY_TO_TEST
[test]
name=test
bs=\$4
stonewall\" >> test.fio
./fio test.fio 2>&1 > \$LOG_FILE
echo \$? > ~/test-exit-status" > fio-run
chmod +x fio-run
