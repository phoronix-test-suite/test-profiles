#!/bin/sh

tar -xzf stress-ng-0.07.09.tar.gz

cd ~/stress-ng-0.07.09
make
echo $? > ~/install-exit-status

cd ~
echo "#!/bin/sh
cd ~/stress-ng-0.07.09
./stress-ng \$@ > \$LOG_FILE" > stress-ng
chmod +x stress-ng
