#!/bin/sh

unzip -o pts-warsow-4.zip

case $OS_TYPE in
	"MacOSX")
		unzip -o warsow_0.61_mac.zip
		mkdir -p Library/Application\ Support/Warsow-0.61/basewsw/demos
		cp -f pts-demo.wd12 Library/Application\ Support/Warsow-0.61/basewsw/demos/
	;;
	*)
		unzip -o warsow_0.61_unified.zip
		chmod +x warsow_0.61_unified/warsow.*
		mkdir -p warsow_0.61_unified/basewsw/demos
		cp -f pts-demo.wd12 warsow_0.61_unified/basewsw/demos
	;;
esac

echo "#!/bin/sh
rm -f .warsow/basewsw/1.log

case \$OS_TYPE in
	\"MacOSX\")
		/Volumes/Warsow\ 0.61/Warsow\ SDL.app/Contents/MacOS/Warsow\ SDL \$@
		cat Library/Application\ Support/Warsow-0.61/basewsw/pts-log.log > \$LOG_FILE
	;;
	*)
		cd warsow_0.61_unified/
		if [ \$OS_ARCH = \"x86_64\" ]
		then
			./warsow.x86_64 \$@
		else
			./warsow.i386 \$@
		fi
		cat ~/.warsow-0.6/basewsw/pts-log.log > \$LOG_FILE
	;;
esac" > warsow
chmod +x warsow
