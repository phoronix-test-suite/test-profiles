#!/bin/sh

if [ $OS_ARCH = "x86_64" ]
then
	tar -xjvf supertuxkart-0.8.1-2-linux-glibc2.11-x86-64.tar.bz2
	mv supertuxkart-0.8.1-2-linux-glibc2.11-x86-64/ supertuxkart-0.8.1/
else
	tar -xjvf supertuxkart-0.8.1-linux-glibc2.7-i386.tar.bz2
	mv supertuxkart-0.8-linux-glibc2.7-i386/ supertuxkart-0.8.1/
fi

echo "#!/bin/sh
cd supertuxkart-0.8.1/
LD_LIBRARY_PATH=./bin/: ./bin/supertuxkart \$@ > \$LOG_FILE 2>&1" > supertuxkart
chmod +x supertuxkart

