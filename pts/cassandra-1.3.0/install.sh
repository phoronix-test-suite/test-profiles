#!/bin/sh
tar -xf apache-cassandra-5.0.0-bin.tar.gz
cd ~/apache-cassandra-5.0.0/bin/
chmod +x cassandra
cd ~/apache-cassandra-5.0.0/tools/bin
chmod +x cassandra-stress
mkdir ~/apache-cassandra-5.0.0/logs
cd ~
echo "#!/bin/bash
cd ~/apache-cassandra-5.0.0/tools/bin
case \"\$1\" in
\"WRITE\")
	./cassandra-stress write duration=2m -rate threads=\$NUM_CPU_CORES > \$LOG_FILE 2>&1
	;;
\"MIXED_1_1\")
	#./cassandra-stress write -rate threads=\$NUM_CPU_CORES
	sleep 2
	./cassandra-stress mixed ratio\(write=1,read=1\) duration=1m -rate threads=\$NUM_CPU_CORES > \$LOG_FILE 2>&1
	;;
\"MIXED_1_3\")
	#./cassandra-stress write -rate threads=\$NUM_CPU_CORES
	sleep 2
	./cassandra-stress mixed ratio\(write=1,read=3\) duration=1m -rate threads=\$NUM_CPU_CORES > \$LOG_FILE 2>&1
	;;
esac" > cassandra
chmod +x cassandra