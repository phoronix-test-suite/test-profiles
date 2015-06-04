#!/bin/sh

tar -xzf stress-ng-0.04.05.tar.gz

cd ~/stress-ng-0.04.05
make
echo $? > ~/install-exit-status

cd ~
echo "#!/bin/sh
cd ~/stress-ng-0.04.05
./stress-ng \$@ > \$LOG_FILE" > stress-ng
chmod +x stress-ng
