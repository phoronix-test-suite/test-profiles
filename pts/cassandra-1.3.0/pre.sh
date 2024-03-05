#!/bin/sh
cd apache-cassandra-5.0-beta1/
rm -rf data/
cd bin/
./cassandra -R -p ~/cassandra-server-pid
sleep 10
# Prep  fill
cd ~/apache-cassandra-5.0-beta1/tools/bin
./cassandra-stress write -rate threads=\$NUM_CPU_CORES
