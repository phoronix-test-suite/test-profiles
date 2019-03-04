#!/bin/sh

tar -zxvf openssl-1.0.2q.tar.gz

cd openssl-1.0.2q/
./config no-zlib
make
echo \$? > ~/install-exit-status
cd ~

echo "#!/bin/sh
./openssl-1.0.2q/apps/openssl speed rsa4096 > \$LOG_FILE 2>&1
echo \$? > ~/test-exit-status" > openssl
chmod +x openssl


