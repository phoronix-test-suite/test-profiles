#!/bin/bash
GAME_PREFS="$DEBUG_REAL_HOME/.local/share/feral-interactive/Dawn of War III"

# Clean out the game temp files to ensure we have a clean run
rm -rf "${GAME_PREFS:?}/VFS"

# clear previous runs
rm -rf "$GAME_PREFS/VFS/User/AppData/Roaming/My Games/Dawn of War III/LogFiles/"
