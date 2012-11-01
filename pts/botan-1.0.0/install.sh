#!/bin/sh

tar -jxvf Botan-1.10.3.tbz

cd Botan-1.10.3/
./configure.py
make
make check
echo \$? > ~/test-exit-status

cd ~

echo "#!/bin/sh
cd Botan-1.10.3/
LD_LIBRARY_PATH=\`pwd\`:\$LD_LIBRARY_PATH time ./check --benchmark > \$LOG_FILE 2>&1
echo \$? > ~/test-exit-status" > botan
chmod +x botan


