#!/bin/sh

unzip -o pts4-tf2-aug15.zip
mv pts4.dem $DEBUG_REAL_HOME/.steam/steam/steamapps/common/Team\ Fortress\ 2/tf

echo "#!/bin/sh
cd \$DEBUG_REAL_HOME/.steam/steam/steamapps/common/Team\ Fortress\ 2

export __GL_THREADED_OPTIMIZATIONS=1

LD_LIBRARY_PATH=\$DEBUG_REAL_HOME/.steam/steam/steamapps/common/Team\ Fortress\ 2/bin:\$DEBUG_REAL_HOME/.steam/ubuntu12_32:\$DEBUG_REAL_HOME/.steam/ubuntu12_32/steam-runtime/i386/lib/i386-linux-gnu:\$DEBUG_REAL_HOME/.steam/ubuntu12_32/steam-runtime/i386/lib:\$DEBUG_REAL_HOME/.steam/ubuntu12_32/steam-runtime/i386/usr/lib/i386-linux-gnu:\$DEBUG_REAL_HOME/.steam/ubuntu12_32/steam-runtime/i386/usr/lib:\$DEBUG_REAL_HOME/.steam/ubuntu12_32/steam-runtime/amd64/lib/x86_64-linux-gnu:\$DEBUG_REAL_HOME/.steam/ubuntu12_32/steam-runtime/amd64/lib:\$DEBUG_REAL_HOME/.steam/ubuntu12_32/steam-runtime/amd64/usr/lib/x86_64-linux-gnu:\$DEBUG_REAL_HOME/.steam/ubuntu12_32/steam-runtime/amd64/usr/lib:/usr/lib32:\$DEBUG_REAL_HOME/.steam/ubuntu12_32:\$DEBUG_REAL_HOME/.local/share/Steam/ubuntu12_64:\$DEBUG_REAL_HOME/.steam/steam/steamapps/common/Team\ Fortress\ 2:\$DEBUG_REAL_HOME/.steam/steam/steamapps/common/Team\ Fortress\ 2/bin ./hl2_linux -game tf +con_logfile \$LOG_FILE +cl_showfps 1 -fullscreen -novid +timedemoquit pts4 \$@" > tf2
chmod +x tf2
