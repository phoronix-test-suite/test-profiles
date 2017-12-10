#!/bin/sh

unzip -o cpuminer-opt-3.7.5.zip
cd cpuminer-opt-3.7.5
./build.sh

cd ~
echo "#!/bin/sh
cd cpuminer-opt-3.7.5
./cpuminer --quiet --time-limit=30 --benchmark \$@ > \$LOG_FILE 2>&1
echo \$? > ~/test-exit-status" > cpuminer-opt
chmod +x cpuminer-opt
