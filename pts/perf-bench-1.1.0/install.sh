#!/bin/sh
tar -xf linux-6.9.tar.xz
cd linux-6.9/tools/perf
NO_LIBTRACEEVENT=1 make -j $NUM_CPU_CORES
echo $? > ~/install-exit-status
cp perf ~
cd ~
rm -rf linux-6.2.6
echo "#!/bin/sh
./perf bench \$@ > \$LOG_FILE 2>&1
echo \$? > ~/test-exit-status" > perf-bench
chmod +x perf-bench
