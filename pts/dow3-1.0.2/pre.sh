#!/bin/bash
set -o xtrace
exec > /tmp/test
exec 2>&1

STEAM_GAME_ID=285190
GAME_BINARY=DawnOfWar3
WIDTH=$1
HEIGHT=$2
SETTING=$3
VULKAN=$4

export HOME=$DEBUG_REAL_HOME
GAME_PREFS="$DEBUG_REAL_HOME/.local/share/feral-interactive/Dawn of War III"

# Gather the steam env variables the game runs with
steam steam://run/$STEAM_GAME_ID &
sleep 6
GAME_PID=`pgrep $GAME_BINARY | tail -1`
echo '#!/bin/sh' > steam-env-vars.sh
echo "# PID: $GAME_PID" >> steam-env-vars.sh
while read -d $'\0' ENV; do NAME=`echo $ENV | cut -d= -f1`; VAL=`echo $ENV | cut -d= -f2`; echo "export $NAME=\"$VAL\""; done < /proc/$GAME_PID/environ >> steam-env-vars.sh
chmod +x steam-env-vars.sh

killall -9 DawnOfWar3
sleep 6

# Set up (and back up) the game preferences files
DATETIME=$( date +%Y-%d-%m-%H-%M )
echo $DATETIME > /tmp/dow3-bkp-dt
GAME_PREFS_BKP="${GAME_PREFS}.$DATETIME.pts-bkp"
cp -r "$GAME_PREFS" "$GAME_PREFS_BKP"

# clear previous runs
rm -rf "$GAME_PREFS/VFS/User/AppData/Roaming/My Games/Dawn of War III/LogFiles/"

# clear out intermediate files
rm -rf "${GAME_PREFS:?}/VFS/"
cp "preferences.$SETTING.xml" "$GAME_PREFS/preferences"

cd "$GAME_PREFS" || exit
sed -i "s/1920/$WIDTH/g" preferences
sed -i "s/1080/$HEIGHT/g" preferences

if [ "X$VULKAN" = "XVULKAN" ]
then
	sed -i  's/<value name="UseVulkan" type="integer">0<\/value>/<value name="UseVulkan" type="integer">1<\/value>/' preferences
fi

