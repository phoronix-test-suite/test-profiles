#!/bin/sh

tar -xvzf cl-mem-20170113.tar.gz
mv cl-mem cl-mem-program
cd cl-mem-program
make
echo $? > ~/install-exit-status

cd ~/
echo "#!/bin/sh
cd cl-mem-program
./cl-mem > \$LOG_FILE 2>&1
echo \$? > ~/test-exit-status" > cl-mem
chmod +x cl-mem
