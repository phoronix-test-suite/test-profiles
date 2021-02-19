#!/bin/sh

unzip -o portal2-demo-pts2.zip
mv pts2.dem $DEBUG_REAL_HOME/Library/Application\ Support/Steam/steamapps/common/Portal\ 2/portal2/

echo "#!/bin/sh
cd \$DEBUG_REAL_HOME/Library/Application\ Support/Steam/steamapps/common/Portal\ 2/

./portal2.sh -game portal2 +con_logfile \$LOG_FILE +cl_showfps 1 +timedemoquit pts2 -novid -fullscreen \$@" > portal2
chmod +x portal2
