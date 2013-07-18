#!/bin/sh

unzip -o tf2-demo-1.zip
mv pts2.dem $DEBUG_REAL_HOME/.steam/root/SteamApps/common/Team\ Fortress\ 2/tf

echo "#!/bin/sh
cd \$DEBUG_REAL_HOME/.steam/root/SteamApps/common/Team\ Fortress\ 2

LD_LIBRARY_PATH=\$DEBUG_REAL_HOME/.local/share/Steam/SteamApps/common/Team\ Fortress\ 2/bin:\$DEBUG_REAL_HOME/.local/share/Steam/ubuntu12_32:\$DEBUG_REAL_HOME/.local/share/Steam/ubuntu12_32/steam-runtime/i386/lib/i386-linux-gnu:\$DEBUG_REAL_HOME/.local/share/Steam/ubuntu12_32/steam-runtime/i386/lib:\$DEBUG_REAL_HOME/.local/share/Steam/ubuntu12_32/steam-runtime/i386/usr/lib/i386-linux-gnu:\$DEBUG_REAL_HOME/.local/share/Steam/ubuntu12_32/steam-runtime/i386/usr/lib:\$DEBUG_REAL_HOME/.local/share/Steam/ubuntu12_32/steam-runtime/amd64/lib/x86_64-linux-gnu:\$DEBUG_REAL_HOME/.local/share/Steam/ubuntu12_32/steam-runtime/amd64/lib:\$DEBUG_REAL_HOME/.local/share/Steam/ubuntu12_32/steam-runtime/amd64/usr/lib/x86_64-linux-gnu:\$DEBUG_REAL_HOME/.local/share/Steam/ubuntu12_32/steam-runtime/amd64/usr/lib:/usr/lib32:\$DEBUG_REAL_HOME/.local/share/Steam/ubuntu12_32:\$DEBUG_REAL_HOME/.local/share/Steam/ubuntu12_64:\$DEBUG_REAL_HOME/.local/share/Steam/SteamApps/common/Team\ Fortress\ 2:\$DEBUG_REAL_HOME/.local/share/Steam/SteamApps/common/Team\ Fortress\ 2/bin ./hl2_linux -game tf +con_logfile \$LOG_FILE +cl_showfps 1 +timedemoquit pts2 \$@" > tf2
chmod +x tf2
