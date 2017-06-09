#!/bin/bash
GAME_PREFS="$DEBUG_REAL_HOME/.local/share/feral-interactive/Dawn of War III"

DATETIME=$( cat /tmp/dow3-bkp-dt )
rm -f /tmp/dow3-bkp-dt
GAME_PREFS_BKP="${GAME_PREFS}.$DATETIME.pts-bkp"

rm -rf "${GAME_PREFS:?}/"
mv "$GAME_PREFS_BKP/" "$GAME_PREFS"
