#!/bin/sh

HOME=$DEBUG_REAL_HOME steam steam://install/730

unzip -o pts3-csgo-aug2015.zip
mv pts3.dem $DEBUG_REAL_HOME/.steam/steam/steamapps/common/Counter-Strike\ Global\ Offensive/csgo

echo "#!/bin/bash
. steam-env-vars.sh
cd \$DEBUG_REAL_HOME/.steam/steam/steamapps/common/Counter-Strike\ Global\ Offensive/
./csgo_linux -game csgo +con_logfile \$LOG_FILE +cl_showfps 1 +timedemoquit pts3 -novid -fullscreen \$@" > csgo
chmod +x csgo
