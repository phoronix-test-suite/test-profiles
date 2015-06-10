#!/bin/sh

version=9.4.3
tar -xjf postgresql-${version}.tar.bz2 

rm -rf $HOME/pg_
mkdir -p $HOME/pg_/data/postgresql/extension/
touch $HOME/pg_/data/postgresql/extension/plpgsql.control

cd postgresql-${version}
./configure --prefix=$HOME/pg_ --without-readline --without-zlib
make -j $NUM_CPU_JOBS
make -C contrib/pgbench all
echo $? > ~/install-exit-status
make install
make -C contrib/pgbench install
cd ..
rm -rf postgresql-${version}/
rm -rf pg_/doc/

# initialize database with encoding and locale
$HOME/pg_/bin/initdb -D $HOME/pg_/data/db --encoding=SQL_ASCII --locale=C

echo "#!/bin/sh
PGDATA=\$HOME/pg_/data/db/
PGPORT=7777
export PGDATA
export PGPORT
# start server
pg_/bin/pg_ctl start -o '-c checkpoint_segments=8 -c autovacuum=false'
# wait for server to start
sleep 10

# create test db
pg_/bin/createdb pgbench

# set up tables
case \$1 in
	\"BUFFER_TEST\")
		SCALING_FACTOR=\`echo \"\$SYS_MEMORY * 0.003\" | bc\`
	;;
	\"MOSTLY_CACHE\")
		SCALING_FACTOR=\`echo \"\$SYS_MEMORY * 0.03\" | bc\`
	;;
	\"ON_DISK\")
		SCALING_FACTOR=\`echo \"\$SYS_MEMORY * 0.3\" | bc\`
	;;
esac

pg_/bin/pgbench -i -s \$SCALING_FACTOR pgbench

case \$2 in
	\"SINGLE_THREAD\")
		PGBENCH_ARGS=\"-c 1\"
	;;
	\"NORMAL_LOAD\")
		PGBENCH_ARGS=\"-j \$NUM_CPU_CORES -c \$((\$NUM_CPU_CORES*4))\"
	;;
	\"HEAVY_CONTENTION\")
		PGBENCH_ARGS=\"-j \$((\$NUM_CPU_CORES*2)) -c \$((\$NUM_CPU_CORES*32))\"
	;;
esac

case \$3 in
	\"READ_WRITE\")
		PGBENCH_MORE_ARGS=\"\"
	;;
	\"READ_ONLY\")
		PGBENCH_MORE_ARGS=\"-S\"
	;;
esac

# run the test 
pg_/bin/pgbench \$PGBENCH_ARGS \$PGBENCH_MORE_ARGS -T 60 pgbench >\$LOG_FILE 2>&1
# drop test db
pg_/bin/dropdb pgbench
# stop server
pg_/bin/pg_ctl stop" > pgbench
chmod +x pgbench

