#!/bin/sh
rm -rf valkey-8.0.0
tar -xzf valkey-8.0.0.tar.gz

cd ~/valkey-8.0.0/deps
make hiredis jemalloc linenoise lua

cd ~/valkey-8.0.0
make MALLOC=libc -j $NUM_CPU_CORES
echo $? > ~/install-exit-status

cd ~
echo "#!/bin/sh
cd ~/valkey-8.0.0

echo \"io-threads \$NUM_CPU_PHYSICAL_CORES\" > valkey.conf

./src/valkey-server valkey.conf &
REDIS_SERVER_PID=\$!
sleep 6

./src/valkey-benchmark --threads \$NUM_CPU_CORES \$@ > \$LOG_FILE
kill \$REDIS_SERVER_PID
sed \"s/\\\"/ /g\" -i \$LOG_FILE" > valkey
chmod +x valkey
