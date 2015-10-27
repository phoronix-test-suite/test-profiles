#!/bin/sh

HOME=$DEBUG_REAL_HOME steam steam://install/222880

unzip -o insurgency-pts1-dem.zip
mv insurgency-pts1.dem $DEBUG_REAL_HOME/.steam/steam/steamapps/common/insurgency2/insurgency

echo "#!/bin/sh
cd \$DEBUG_REAL_HOME/.steam/steam/steamapps/common/insurgency2/

export __GL_THREADED_OPTIMIZATIONS=1

HOME=\$DEBUG_REAL_HOME LD_LIBRARY_PATH=\$DEBUG_REAL_HOME/.local/share/Steam/steamapps/common/insurgency2/bin:\$DEBUG_REAL_HOME/.local/share/Steam/ubuntu12_32:\$DEBUG_REAL_HOME/.local/share/Steam/ubuntu12_32/panorama:\$DEBUG_REAL_HOME/.local/share/Steam/ubuntu12_32/steam-runtime/i386/lib/i386-linux-gnu:\$DEBUG_REAL_HOME/.local/share/Steam/ubuntu12_32/steam-runtime/i386/lib:\$DEBUG_REAL_HOME/.local/share/Steam/ubuntu12_32/steam-runtime/i386/usr/lib/i386-linux-gnu:\$DEBUG_REAL_HOME/.local/share/Steam/ubuntu12_32/steam-runtime/i386/usr/lib:\$DEBUG_REAL_HOME/.local/share/Steam/ubuntu12_32/steam-runtime/amd64/lib/x86_64-linux-gnu:\$DEBUG_REAL_HOME/.local/share/Steam/ubuntu12_32/steam-runtime/amd64/lib:\$DEBUG_REAL_HOME/.local/share/Steam/ubuntu12_32/steam-runtime/amd64/usr/lib/x86_64-linux-gnu:\$DEBUG_REAL_HOME/.local/share/Steam/ubuntu12_32/steam-runtime/amd64/usr/lib::/usr/lib32:\$DEBUG_REAL_HOME/.local/share/Steam/ubuntu12_32:\$DEBUG_REAL_HOME/.local/share/Steam/ubuntu12_64:\$DEBUG_REAL_HOME/.local/share/Steam/steamapps/common/insurgency2:\$DEBUG_REAL_HOME/.local/share/Steam/steamapps/common/insurgency2/bin ./insurgency_linux +con_logfile \$LOG_FILE +cl_showfps 1 +timedemoquit insurgency-pts1 -novid -fullscreen \$@" > insurgency
chmod +x insurgency
