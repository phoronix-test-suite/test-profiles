#!/bin/sh

HOME=$DEBUG_REAL_HOME steam steam://install/730

unzip -o pts-csgo-1.zip
mv pts-csgo-1.dem $DEBUG_REAL_HOME/.steam/steam/steamapps/common/Counter-Strike\ Global\ Offensive/csgo

echo "#!/bin/sh
cd \$DEBUG_REAL_HOME/.steam/steam/steamapps/common/Counter-Strike\ Global\ Offensive/

HOME=\$DEBUG_REAL_HOME SteamGameId=730 Steam3Master=127.0.0.1:57343 STEAM_RUNTIME=\$DEBUG_REAL_HOME/.steam/ubuntu12_32/steam-runtime STEAM_CLIENT_CONFIG_FILE=\$DEBUG_REAL_HOME/.steam/steam.cfg LD_LIBRARY_PATH=\$DEBUG_REAL_HOME/.steam/steam/steamapps/common/Counter-Strike\ Global\ Offensive/bin:\$DEBUG_REAL_HOME/.steam/ubuntu12_32:\$DEBUG_REAL_HOME/.steam/ubuntu12_32/steam-runtime/i386/lib/i386-linux-gnu:\$DEBUG_REAL_HOME/.steam/ubuntu12_32/steam-runtime/i386/lib:\$DEBUG_REAL_HOME/.steam/ubuntu12_32/steam-runtime/i386/usr/lib/i386-linux-gnu:\$DEBUG_REAL_HOME/.steam/ubuntu12_32/steam-runtime/i386/usr/lib:\$DEBUG_REAL_HOME/.steam/ubuntu12_32/steam-runtime/amd64/lib/x86_64-linux-gnu:\$DEBUG_REAL_HOME/.steam/ubuntu12_32/steam-runtime/amd64/lib:\$DEBUG_REAL_HOME/.steam/ubuntu12_32/steam-runtime/amd64/usr/lib/x86_64-linux-gnu:\$DEBUG_REAL_HOME/.steam/ubuntu12_32/steam-runtime/amd64/usr/lib::/usr/lib32:\$DEBUG_REAL_HOME/.steam/ubuntu12_32:\$DEBUG_REAL_HOME/.steam/ubuntu12_64:\$DEBUG_REAL_HOME/.steam/steam/steamapps/common/Counter-Strike\ Global\ Offensive:\$DEBUG_REAL_HOME/.steam/steam/steamapps/common/Counter-Strike\ Global\ Offensive/bin ./csgo_linux -game csgo +con_logfile \$LOG_FILE +cl_showfps 1 +timedemoquit pts-csgo-1 -novid -fullscreen \$@" > csgo
chmod +x csgo
