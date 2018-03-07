#!/bin/sh

steam steam://install/730

unzip -o csgo-demo-6.zip
mv pts6.dem "C:\Program Files (x86)\Steam\steamapps\common\Counter-Strike Global Offensive\csgo"

echo "#!/bin/sh
cd \"C:\Program Files (x86)\Steam\steamapps\common\Counter-Strike Global Offensive\"
./csgo.exe -game csgo +cl_showfps 1 +con_logfile 1.txt +timedemoquit pts6 -novid -fullscreen \$@

cat csgo/1.txt > \$LOG_FILE" > csgo
chmod +x csgo
