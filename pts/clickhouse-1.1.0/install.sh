#!/bin/sh

# Based on https://clickhouse.com/docs/en/operations/performance-test/

if [ $OS_ARCH = "aarch64" ]
then
	tar -xf clickhouse-common-static-22.5.4.19-arm64.tgz
else
	tar -xf clickhouse-common-static-22.5.4.19-amd64.tgz
fi

tar -xf hits_100m_obfuscated_v1.tar.xz -C .
echo $? > ~/install-exit-status
mv hits_100m_obfuscated_v1/* .

cd ~
CLICKHOUSE_CLIENT=clickhouse-common-static-22.5.4.19/usr/bin/clickhouse
echo "#!/bin/bash
TRIES=3
./$CLICKHOUSE_CLIENT server 2>/dev/null &
SERVER_PID=\$!
sleep 5

./$CLICKHOUSE_CLIENT client --query \"SELECT count() FROM hits_100m_obfuscated\"
echo \$? > ~/test-exit-status

cat clickhouse_queries.sql | sed \"s/{table}/hits_100m_obfuscated/g\" | while read query; do
    sync
    echo \"QUERY: \$query\" >> \$LOG_FILE
    for i in \$(seq 1 \$TRIES); do
    	echo -n \"Clickhouse Query Time \$i: \" >> \$LOG_FILE
    	./$CLICKHOUSE_CLIENT client --time --format=Null --max_memory_usage=100G --query=\"\$query\" >> \$LOG_FILE 2>&1
    	retval=\$?
	if [ \$retval -ne 0 ]; then
	    echo \$retval > ~/test-exit-status
	    kill -9 \$SERVER_PID
	    sleep 3
	    exit
	fi
    done
done

kill -9 \$SERVER_PID
sleep 2

./$CLICKHOUSE_CLIENT server --version > ~/pts-footnote 2>/dev/null" > clickhouse
chmod +x clickhouse
