#!/bin/sh
helsing_version='helsing-1.1-beta'
tar -xf $helsing_version.tar.gz

cd $helsing_version/helsing/
sed "s|^#define THREADS .*|#define THREADS $NUM_CPU_CORES|g" configuration.h > tmp
mv tmp configuration.h
case $OS_TYPE in
	"Solaris")
		sed "s|^LFLAGS := -Wl,--gc-sections .*|LFLAGS := |g" Makefile > tmp
		mv tmp Makefile
		gmake
	;;
	"BSD")
		gmake
	;;
	*)
		make
	;;
esac
echo $? > ~/install-exit-status
cd ~

echo "#!/bin/sh
./$helsing_version/helsing/helsing \$@ > \$LOG_FILE 2>&1
echo \$? > ~/test-exit-status" > ~/helsing
chmod +x ~/helsing
