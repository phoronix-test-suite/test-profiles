#!/bin/sh

if [ $OS_ARCH = "x86_64" ]
then
	tar -xjvf supertuxkart-0.8-lin-amd64.tar.bz2
	mv \ supertuxkart-0.8-lin64/ supertuxkart-0.8/
	./warsow.x86_64 $@
else
	tar -xjvf supertuxkart-0.8-linux-glibc2.7-i386.tar.bz2
	mv supertuxkart-0.8-linux-glibc2.7-i386/ supertuxkart-0.8/
	./warsow.i386 $@
fi

echo "#!/bin/sh
cd supertuxkart-0.8/
./supertuxkart \$@ > \$LOG_FILE 2>&1" > supertuxkart
chmod +x supertuxkart

