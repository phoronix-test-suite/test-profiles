#!/bin/sh

tar -jxvf Botan-1.11.6.tbz

cd Botan-1.11.6/
./configure.py
make
make check
echo \$? > ~/test-exit-status

cd ~

echo "#!/bin/sh
cd Botan-1.11.6/
LD_LIBRARY_PATH=\`pwd\`:\$LD_LIBRARY_PATH time ./check --benchmark > \$LOG_FILE 2>&1
echo \$? > ~/test-exit-status" > botan
chmod +x botan


