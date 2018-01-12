#!/bin/sh

tar -zxvf Geekbench-4.2.0-Linux.tar.gz
echo $? > ~/install-exit-status

echo "#!/bin/sh
Geekbench-4.2.0-Linux/geekbench4 > \$LOG_FILE 2>&1
echo \$? > ~/test-exit-status" > ~/gb4
chmod +x ~/gb4
