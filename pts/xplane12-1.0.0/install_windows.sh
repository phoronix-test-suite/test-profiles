#!/bin/sh
steam steam://install/2014780
cd "C:\Program Files (x86)\Steam\steamapps\common\X-Plane 12"
echo "269950" > steam_appid.txt
cd ~
echo "#!/bin/sh
cd \"C:\Program Files (x86)\Steam\steamapps\common\X-Plane 12\"
./X-Plane.exe \$@
sed -i 's/FRAMERATE TEST/\nFRAMERATE TEST/g' Log.txt
mv Log.txt \$LOG_FILE" > xplane12
chmod +x xplane12
