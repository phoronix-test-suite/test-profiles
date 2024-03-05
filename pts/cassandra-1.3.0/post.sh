#!/bin/sh
CASSANDRA_SERVER_PID=`cat ~/cassandra-server-pid`
kill -9 $CASSANDRA_SERVER_PID
sleep 3
cd apache-cassandra-5.0-beta1/
rm -rf data/
