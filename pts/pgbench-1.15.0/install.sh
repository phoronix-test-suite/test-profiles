#!/bin/sh
version=17.0
tar -xjf postgresql-${version}.tar.bz2 
rm -rf $HOME/pg_
mkdir -p $HOME/pg_/data/postgresql/extension/
touch $HOME/pg_/data/postgresql/extension/plpgsql.control
# Junk up the root checking code so test profiles can easily run as root
patch -p0 <<'EOF'
diff -Naur postgresql-17.0.orig/src/backend/main/main.c postgresql-17.0/src/backend/main/main.c
--- postgresql-17.0.orig/src/backend/main/main.c	2024-09-23 15:02:53.000000000 -0500
+++ postgresql-17.0/src/backend/main/main.c	2024-09-26 14:14:31.335983041 -0500
@@ -57,7 +57,7 @@
 int
 main(int argc, char *argv[])
 {
-	bool		do_check_root = true;
+	bool		do_check_root = false;
 
 	reached_main = true;
 
diff -Naur postgresql-17.0.orig/src/bin/initdb/initdb.c postgresql-17.0/src/bin/initdb/initdb.c
--- postgresql-17.0.orig/src/bin/initdb/initdb.c	2024-09-23 15:02:53.000000000 -0500
+++ postgresql-17.0/src/bin/initdb/initdb.c	2024-09-26 14:15:11.250576555 -0500
@@ -758,7 +758,7 @@
 {
 	const char *username;
 
-#ifndef WIN32
+#if 0
 	if (geteuid() == 0)			/* 0 is root's uid */
 	{
 		pg_log_error("cannot be run as root");
diff -Naur postgresql-17.0.orig/src/bin/pg_ctl/pg_ctl.c postgresql-17.0/src/bin/pg_ctl/pg_ctl.c
--- postgresql-17.0.orig/src/bin/pg_ctl/pg_ctl.c	2024-09-23 15:02:53.000000000 -0500
+++ postgresql-17.0/src/bin/pg_ctl/pg_ctl.c	2024-09-26 14:15:52.473302181 -0500
@@ -2241,7 +2241,7 @@
 	/*
 	 * Disallow running as root, to forestall any possible security holes.
 	 */
-#ifndef WIN32
+#if 0
 	if (geteuid() == 0)
 	{
 		write_stderr(_("%s: cannot be run as root\n"
diff -Naur postgresql-17.0.orig/src/bin/pg_upgrade/option.c postgresql-17.0/src/bin/pg_upgrade/option.c
--- postgresql-17.0.orig/src/bin/pg_upgrade/option.c	2024-09-23 15:02:53.000000000 -0500
+++ postgresql-17.0/src/bin/pg_upgrade/option.c	2024-09-26 14:16:31.755910166 -0500
@@ -100,10 +100,6 @@
 		}
 	}
 
-	/* Allow help and version to be run as root, so do the test here. */
-	if (os_user_effective_id == 0)
-		pg_fatal("%s: cannot be run as root", os_info.progname);
-
 	while ((option = getopt_long(argc, argv, "b:B:cd:D:j:kNo:O:p:P:rs:U:v",
 								 long_options, &optindex)) != -1)
 	{
EOF

cd postgresql-${version}
./configure --prefix=$HOME/pg_ --without-readline --without-zlib

if [ "$OS_TYPE" = "BSD" ]
then
	gmake -j $NUM_CPU_CORES
	gmake -C contrib/pgbench all
	# echo $? > ~/install-exit-status
	gmake install
	gmake -C contrib/pgbench install
else
	make -j $NUM_CPU_CORES
	make -C contrib/pgbench all
	# echo $? > ~/install-exit-status
	make install
	make -C contrib/pgbench install
fi
cd ~
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
SHARED_BUFFER_SIZE=\`echo \"\$SYS_MEMORY * 0.25 / 1\" | bc\`
SHARED_BUFFER_SIZE=\$(( \$SHARED_BUFFER_SIZE < 8192 ? \$SHARED_BUFFER_SIZE : 8192 ))
echo \"Buffer size is \${SHARED_BUFFER_SIZE}MB\" > \$LOG_FILE
pg_/bin/pg_ctl start -o \"-c max_connections=6000 -c shared_buffers=\${SHARED_BUFFER_SIZE}MB\"
# wait for server to start
sleep 10

# create test db
pg_/bin/createdb pgbench

# set up tables
pg_/bin/pgbench -i \$1 \$2 -n pgbench

# run the test 
pg_/bin/pgbench --protocol=prepared -j \$NUM_CPU_CORES \$@ -n -T 120 -r pgbench >>\$LOG_FILE 2>&1
# drop test db
pg_/bin/dropdb pgbench
# stop server
pg_/bin/pg_ctl stop" > pgbench
chmod +x pgbench
