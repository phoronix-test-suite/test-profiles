#!/bin/sh

tar -xzvf memcached-1.4.34.tar.gz
cd memcached-1.4.34
./configure
make
echo $? > ~/install-exit-status

cd ~
tar -xzvf mcperf-0.1.1.tar.gz
cd mcperf-0.1.1
./configure
make

cd ~

echo "#!/bin/sh
cd ~/memcached-1.4.34
./memcached -d
MEMCACHED_PID=\$!
sleep 3

cd ~/mcperf-0.1.1
./src/mcperf \$@ > \$LOG_FILE 2>&1
echo \$? > ~/test-exit-status

kill \$MEMCACHED_PID
sleep 3" > mcperf

chmod +x mcperf
