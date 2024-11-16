#!/bin/sh
tar -xf rustls-v-0.23.17.tar.gz
cd  rustls-v-0.23.17
cargo build  --profile=bench -p rustls --example bench
echo $? > ~/install-exit-status
cd ~
echo "#!/bin/sh
cd  rustls-v-0.23.17
./target/release/examples/bench --threads 24 --api buffered \$@ > \$LOG_FILE 2>&1
echo \$? > ~/test-exit-status" > rustls
chmod +x rustls > \
