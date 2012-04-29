#!/bin/sh

tar -xvzf qvdpautest-0.5.1.tar.gz
cd qvdpautest-0.5.1/

echo "--- mainwidget.cpp.orig	2012-04-29 09:01:20.009007783 -0400
+++ mainwidget.cpp	2012-04-29 09:01:32.773008163 -0400
@@ -177,7 +177,7 @@
 			QString res = vw->benchMT();
 			printf( "%s", res.toAscii().data() );
 			te->append( vw->getSummary() );
-			setCurrentIndex( 0 );
+			QApplication::exit(0);
 		}
 	}
 	" | patch -p0
qmake
make
echo $? > ~/install-exit-status
cd ~/

echo "#!/bin/sh
cd qvdpautest-0.5.1/
./qvdpautest > \$LOG_FILE 2>&1
echo \$? > ~/test-exit-status" > qvdpautest
chmod +x qvdpautest
