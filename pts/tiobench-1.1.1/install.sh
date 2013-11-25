#!/bin/sh

tar -zxvf tiobench-0.3.3.tar.gz
cd tiobench-0.3.3/

echo "--- tiotest.c.orig	2001-03-04 20:34:00.000000000 -0600
+++ tiotest.c	2013-11-25 11:40:41.192702749 -0600
@@ -31,7 +31,7 @@
 */
 ArgumentOptions args;
 
-static void * aligned_alloc(ssize_t size)
+static void * faligned_alloc(ssize_t size)
 {
 	caddr_t a;
 	a = mmap((caddr_t )0, size, 
@@ -41,7 +41,7 @@
 	return a;
 }
 
-static int aligned_free(caddr_t a, ssize_t size)
+static int faligned_free(caddr_t a, ssize_t size)
 {
 	return munmap(a, size);
 }
@@ -281,7 +281,7 @@
 		pthread_attr_setscope(&(d->threads[i].thread_attr),
 				      PTHREAD_SCOPE_SYSTEM);
 
-		d->threads[i].buffer = aligned_alloc( d->threads[i].blockSize );
+		d->threads[i].buffer = faligned_alloc( d->threads[i].blockSize );
 		if( d->threads[i].buffer == NULL )
 		{
 			perror("Error allocating memory");
@@ -383,7 +383,7 @@
 	{
 		if (!args.rawDrives)
 		unlink(d->threads[i].fileName);
-		aligned_free( d->threads[i].buffer, d->threads[i].blockSize );
+		faligned_free( d->threads[i].buffer, d->threads[i].blockSize );
 		d->threads[i].buffer = 0;
 	
 		pthread_attr_destroy( &(d->threads[i].thread_attr) );
" | patch -p0

make -j $NUM_CPU_JOBS
echo $? > ~/install-exit-status
cd ..

echo "#!/bin/sh
cd tiobench-0.3.3/
./tiotest \$@ > \$LOG_FILE 2>&1" > tiobench
chmod +x tiobench
