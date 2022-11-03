#!/bin/sh

if which docker>/dev/null 2>&1 ;
then
	echo 0 > ~/install-exit-status
else
	echo "ERROR: Docker is not found on the system! This test profile needs a working docker installation in the PATH."
	echo 2 > ~/install-exit-status
	exit
fi

docker pull cloudsuite3/hadoop
docker pull cloudsuite3/data-analytics
echo $? > ~/install-exit-status

docker network create hadoop-net

echo "#!/bin/bash
export HOME=\$DEBUG_REAL_HOME 

# Start master and slaves
SLAVE_COUNT=\$1
docker run -d --net hadoop-net --name master --hostname master cloudsuite3/data-analytics master
for (( SLAVE_I=1; SLAVE_I<=\$SLAVE_COUNT; SLAVE_I++ ))
do 
   docker run -d --net hadoop-net --name slave\$SLAVE_I --hostname slave\$SLAVE_I cloudsuite3/hadoop slave
done

# Run data analytics benchmark
docker exec master benchmark > \$LOG_FILE 2>&1
echo \$? > ~/test-exit-status

# Stop them
docker stop master
for (( SLAVE_I=1; SLAVE_I<=\$SLAVE_COUNT; SLAVE_I++ ))
do 
   docker stop slave\$SLAVE_I
done
sleep 2
docker container rm master
for (( SLAVE_I=1; SLAVE_I<=\$SLAVE_COUNT; SLAVE_I++ ))
do 
   docker container rm slave\$SLAVE_I
done" > cloudsuite-da
chmod +x cloudsuite-da
