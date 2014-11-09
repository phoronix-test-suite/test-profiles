#!/bin/sh

rm -rf linux-3.18-rc3/
tar -xf linux-3.18-rc3.tar.gz

cd linux-3.18-rc3/

case $OS_ARCH in
	"x86_64" )
	make x86_64_defconfig
	;;
	* )
	make i386_defconfig
	;;
esac

make clean
