#!/bin/sh

cp /home/$USER/gb4_files/gb4-linux.tar.gz .
tar -zxvf gb4-linux.tar.gz
gb4-linux/activar.sh
echo $? > ~/install-exit-status

echo "#!/bin/sh
cd gb4-linux
./geekbench4 --section 2 > \$LOG_FILE 2>&1" > ~/gb4
chmod +x ~/gb4
