#!/bin/sh

HOME=$DEBUG_REAL_HOME steam steam://install/570

unzip -o pts-dota2-2.zip
mv pts2.dem $DEBUG_REAL_HOME/.steam/steam/steamapps/common/dota\ 2\ beta/game/dota

echo "#!/bin/bash
HOME=\$DEBUG_REAL_HOME 
. steam-env-vars.sh
cd \$DEBUG_REAL_HOME/.steam/steam/steamapps/common/dota\ 2\ beta/game
mv -f \$HOME/.steam/steam/steamapps/common/dota\ 2\ beta/game/dota/Source2Bench.csv \$HOME/.steam/steam/steamapps/common/dota\ 2\ beta/game/dota/Source2Bench.csv.1
./dota.sh +con_logfile \$LOG_FILE +timedemoquit pts2 +demo_quitafterplayback 1 +cl_showfps 1 +fps_max 0 -novconsole -fullscreen +timedemo_start 1 +timedemo_end 1000 \$@ &
sleep 75
killall -9 dota2
cat \$HOME/.steam/steam/steamapps/common/dota\ 2\ beta/game/dota/Source2Bench.csv > \$LOG_FILE" > dota2-benchmark
chmod +x dota2-benchmark
