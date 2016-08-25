#!/bin/sh

unzip -o crafty-23.4.zip

cd crafty-23.4/

if [ $OS_TYPE = "MacOSX" ]
then
	export target=FreeBSD
elif [ $OS_TYPE = "BSD" ]
then
	export target=FreeBSD
elif [ $OS_TYPE = "Solaris" ]
then
	export target=SUN
else
	export target=LINUX
fi

if [ "X$CFLAGS_OVERRIDE" = "X" ]
then
          CFLAGS="$CFLAGS -O3 -march=native"
else
          CFLAGS="$CFLAGS_OVERRIDE"
fi

export CFLAGS="-Wall -pipe -fomit-frame-pointer $CFLAGS"
export CXFLAGS="-Wall -pipe -O3 -fomit-frame-pointer"
export LDFLAGS="$LDFLAGS -lstdc++"
make crafty-make

echo $? > ~/install-exit-status

cd ..

echo "#!/bin/sh
cd crafty-23.4/
./crafty \$@ > \$LOG_FILE 2>&1
echo \$? > ~/test-exit-status" > crafty
chmod +x crafty
