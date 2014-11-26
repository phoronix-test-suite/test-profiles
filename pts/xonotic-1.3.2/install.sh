#!/bin/sh

rm -rf Xonotic_

unzip -o xonotic-0.7.0.zip
mv Xonotic Xonotic_

echo "#!/bin/sh
cd Xonotic_/
if [ \$OS_TYPE = \"MacOSX\" ]
then
	./Xonotic.app/Contents/MacOS/xonotic-osx-sdl \$@ > \$LOG_FILE 2>&1
else
	./xonotic-linux-glx.sh \$@ > \$LOG_FILE 2>&1
fi" > xonotic
chmod +x xonotic
