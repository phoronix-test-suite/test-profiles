#!/bin/sh

unzip -o dow3-prefs-2.zip

HOME=$DEBUG_REAL_HOME steam steam://install/285190
mkdir -p $DEBUG_REAL_HOME/.local/share/feral-interactive/Dawn\ of\ War\ III

echo "#!/bin/bash
GAME_PREFS=\"\$DEBUG_REAL_HOME/.local/share/feral-interactive/Dawn of War III\"
. steam-env-vars.sh

# cd \$DEBUG_REAL_HOME/.steam/steam/steamapps/common/Dawn\ of\ War\ III/ || exit
cd /opt/steam/steamapps/common/Dawn\ of\ War\ III/ || exit

# Run the game as if from steam
./DawnOfWar3.sh

cd \"\$GAME_PREFS/VFS/User/AppData/Roaming/My Games/Dawn of War III/LogFiles/\"
cat perfreport*.csv  > \"\$LOG_FILE\"
" > dow3
chmod +x dow3
