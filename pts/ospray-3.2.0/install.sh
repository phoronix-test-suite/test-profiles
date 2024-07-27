#!/bin/sh
if [ $OS_ARCH = "aarch64" ]
then
	ARCH_BIN="aarch64"
else
	ARCH_BIN="x86_64"
fi
tar -xf ospray-3.2.0.$ARCH_BIN.linux.tar.gz
echo "#!/bin/sh
cd ospray-3.2.0.$ARCH_BIN.linux/bin
./ospBenchmark --benchmark_min_time=30 \$@ > \$LOG_FILE 2>&1
sed -i 's/=/ /' \$LOG_FILE
echo \$? > ~/test-exit-status" > ospray
chmod +x ospray
