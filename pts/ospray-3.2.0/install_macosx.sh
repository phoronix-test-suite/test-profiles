#!/bin/sh
if [ $OS_ARCH = "aarch64" ]
then
	ARCH_BIN="arm64"
else
	ARCH_BIN="x86_64"
fi
unzip -o ospray-3.2.0.$ARCH_BIN.macosx.zip
echo "#!/bin/sh
cd ospray-3.2.0.$ARCH_BIN.macosx/bin
./ospBenchmark --benchmark_min_time=30 \$@ > \$LOG_FILE 2>&1
sed -i 's/=/ /' \$LOG_FILE
echo \$? > ~/test-exit-status" > ospray
chmod +x ospray
