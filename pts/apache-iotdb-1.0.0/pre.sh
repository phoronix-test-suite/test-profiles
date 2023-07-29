#!/bin/bash
cd ~/apache-iotdb-1.1.2-all-bin/
rm -rf data
rm -rf logs
cd ~/apache-iotdb-1.1.2-all-bin/sbin
./start-standalone.sh
sleep 3
