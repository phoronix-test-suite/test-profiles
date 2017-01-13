#!/bin/sh

rm -rf povray-3.7.0/
tar -xjf povray-3.7.0.tar.bz2
mv povray povray-3.7.0
cd povray-3.7.0/

cd unix/
autoupdate
./prebuild.sh
cd ..
automake --add-missing
LIBS="-lboost_system" ./configure COMPILED_BY="PhoronixTestSuite" --with-boost-thread=boost_thread
make -j $NUM_CPU_JOBS
echo $? > ~/install-exit-status

cd ~

echo "#!/bin/sh
cd povray-3.7.0/
echo 1 | ./unix/povray -benchmark > \$LOG_FILE 2>&1" > povray
chmod +x povray
