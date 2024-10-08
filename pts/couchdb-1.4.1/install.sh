#!/bin/bash
tar -xf otp_src_27.1.tar.gz
cd otp_src_27.1
./configure --prefix=$HOME/erl 
make -j $NUM_CPU_CORES
make install
cd ~

export PATH=$HOME/erl/bin:$PATH
tar -xf apache-couchdb-benchbulk-1.tar.xz
tar -xf apache-couchdb-3.4.1.tar.gz
cd apache-couchdb-3.4.1
./configure --disable-docs --disable-fauxton --disable-spidermonkey
make -j $NUM_CPU_CORES
make release
echo $? > ~/install-exit-status
echo "admin = couchPTStest" >> rel/couchdb/etc/local.ini

cd ~
echo "#!/bin/sh
cd apache-couchdb-3.4.1/rel/couchdb
./bin/couchdb &
echo \$? > ~/test-exit-status
COUCH_SERVER_PID=\$!
sleep 5
cd ~
bash benchbulk.sh \$@ > \$LOG_FILE 2>&1
kill \$COUCH_SERVER_PID
sleep 1" > couchdb
chmod +x couchdb
