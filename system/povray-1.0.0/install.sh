#!/bin/sh
if which povray >/dev/null 2>&1 ;
then
	echo 0 > ~/install-exit-status
else
	echo "ERROR: povray is not found on the system! This test profile needs a working POV-Ray povray binary in the PATH."
	echo 2 > ~/install-exit-status
fi
echo "#!/bin/sh
echo 1 | povray -benchmark > \$LOG_FILE 2>&1
echo \$? > ~/test-exit-status
povray --version 2>&1 | grep official | grep POV-Ray > ~/pts-footnote" > povray
chmod +x povray
