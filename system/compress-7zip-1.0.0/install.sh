#!/bin/sh
if which 7z >/dev/null 2>&1 ;
then
	echo 0 > ~/install-exit-status
else
	echo "ERROR: 7z is not found on the system! This test profile needs a working 7z in the PATH."
	echo 2 > ~/install-exit-status
fi
echo "#!/bin/sh
7z b > \$LOG_FILE 2>&1
echo \$? > ~/test-exit-status
7z 2>/dev/null | grep Copyright > ~/pts-footnote" > compress-7zip
chmod +x compress-7zip
