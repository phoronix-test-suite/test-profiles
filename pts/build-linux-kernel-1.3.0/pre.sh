#!/bin/sh

rm -rf linux-3.1/
tar -xjf linux-3.1.tar.bz2

cd linux-3.1/

case $OS_ARCH in
	"x86_64" )
	make x86_64_defconfig
	;;
	* )
	make i386_defconfig
	;;
esac

make clean
