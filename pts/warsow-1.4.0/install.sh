#!/bin/sh

unzip -o pts-warsow-10-1.zip

case $OS_TYPE in
	"MacOSX")
		unzip -o warsow_1.0_mac.zip
		mkdir -p Library/Application\ Support/Warsow-1.0/basewsw/demos
		cp -f pts-demo10.wd15 Library/Application\ Support/Warsow-1.0/basewsw/demos
	;;
	*)
		mkdir $HOME/extra-libs
		tar -xvf libpng-1.5.11.tar.gz
		cd libpng-1.5.11/
		./configure --prefix=$HOME/extra-libs
		make
		make install
		cd $HOME

		tar -xvf warsow_1.0_unified.tar.gz
		chmod +x warsow_1.0/warsow.*
		mkdir -p warsow_1.0/basewsw/demos
		cp -f pts-demo10.wd15 warsow_1.0/basewsw/demos
	;;
esac

echo "#!/bin/sh

case \$OS_TYPE in
	\"MacOSX\")
		/Volumes/Warsow\ 1.0/Warsow\ SDL.app/Contents/MacOS/Warsow\ SDL \$@
		cat Library/Application\ Support/Warsow-1.0/basewsw/pts-log.log > \$LOG_FILE
	;;
	*)
		cd warsow_1.0/
		export LD_LIBRARY_PATH=\$HOME/extra-libs/lib:\$LD_LIBRARY_PATH
		if [ \$OS_ARCH = \"x86_64\" ]
		then
			./warsow.x86_64 \$@
		else
			./warsow.i386 \$@
		fi
		cat ~/.warsow-1.0/basewsw/pts-log.log > \$LOG_FILE
	;;
esac" > warsow
chmod +x warsow
