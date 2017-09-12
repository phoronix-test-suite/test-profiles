#!/bin/sh

if which iozone>/dev/null 2>&1 ;
then
	echo 0 > ~/install-exit-status
else
	echo "ERROR: iozone is not found on the system! This test profile needs a working installation in the PATH."
	echo 2 > ~/install-exit-status
fi

echo "#!/bin/sh
iozone \$@ > \$LOG_FILE 2>&1
echo \$? > ~/test-exit-status" > ~/iozone
chmod +x ~/iozone
