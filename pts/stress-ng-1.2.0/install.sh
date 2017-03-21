#!/bin/sh

tar -xzf stress-ng-0.07.26.tar.gz

cd ~/stress-ng-0.07.26
make
echo $? > ~/install-exit-status

cd ~
echo "#!/bin/sh
cd ~/stress-ng-0.07.26
./stress-ng \$@ > \$LOG_FILE" > stress-ng
chmod +x stress-ng
