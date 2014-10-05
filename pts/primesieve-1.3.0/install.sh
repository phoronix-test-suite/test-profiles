#!/bin/sh

gunzip -f primesieve-5.4.tar.gz
tar xvf primesieve-5.4.tar
cd primesieve-5.4

./configure
make -j $NUM_CPU_JOBS
echo $? > ~/install-exit-status
cd ..

echo "#!/bin/sh
primesieve-5.4/./primesieve \$@ > \$LOG_FILE 2>&1
echo \$? > ~/test-exit-status" > primesieve
chmod +x primesieve
