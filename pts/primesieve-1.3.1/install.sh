#!/bin/sh

version=5.4.2
gunzip -f primesieve-$version.tar.gz
tar xvf primesieve-$version.tar
cd primesieve-$version

./configure
make -j $NUM_CPU_JOBS
echo $? > ~/install-exit-status
cd ..

echo "#!/bin/sh
primesieve-$version/./primesieve \$@ > \$LOG_FILE 2>&1
echo \$? > ~/test-exit-status" > primesieve
chmod +x primesieve
