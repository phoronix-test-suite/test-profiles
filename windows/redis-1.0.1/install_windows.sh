#!/bin/sh

unzip -o Redis-x64-3.2.100.zip

echo "#!/bin/sh
./redis-server.exe &
REDIS_SERVER_PID=\$!
sleep 10

./redis-benchmark.exe \$@ > \$LOG_FILE
kill \$REDIS_SERVER_PID
sed \"s/\\\"/ /g\" -i \$LOG_FILE" > redis
chmod +x redis
