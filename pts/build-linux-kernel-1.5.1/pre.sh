#!/bin/sh

rm -rf linux-3.18-rc6/
tar -xf linux-3.18-rc6.tar.gz

cd linux-3.18-rc6/

case $OS_ARCH in
	"x86_64" )
	make x86_64_defconfig
	;;
	"i386" )
	"i686" )
	make i386_defconfig
	;;
	* )
	make defconfig
	;;
esac

make clean
