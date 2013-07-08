#!/bin/sh

unzip -o unvanquished-0.17-universal.zip
mv unvanquished unvanquished-game

unzip -o unvanquished-17-1.zip
mkdir unvanquished-game/main/demos/
mv pts.cfg unvanquished-game/main/
mv pts1.dm_86 unvanquished-game/main/demos/

echo "#!/bin/sh
cd unvanquished-game/
if [ \$OS_TYPE = \"MacOSX\" ]
then
	open ./Unvanquished.app \$@ > \$LOG_FILE 2>&1
else
	./daemon \$@ > \$LOG_FILE 2>&1
fi" > unvanquished
chmod +x unvanquished
