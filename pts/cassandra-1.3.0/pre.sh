#!/bin/sh
cd apache-cassandra-5.0.0
rm -rf data/
cd bin/
./cassandra -Djava.security.manager=allow -R -p ~/cassandra-server-pid
sleep 10
# Prep  fill
cd ~/apache-cassandra-5.0.0/tools/bin
./cassandra-stress write -rate threads=$NUM_CPU_CORES