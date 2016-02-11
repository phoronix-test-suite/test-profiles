#!/bin/sh

tar -xjvf multichase-1.tar.bz2
mv multichase multichase-bin
cd multichase-bin
make
echo 0 > ~/test-exit-status
cd ~/

echo "#!/bin/sh
cd multichase-bin
./\$@ > \$LOG_FILE 2>&1
echo \$? > ~/test-exit-status" > multichase
chmod +x multichase
