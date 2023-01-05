#!/bin/sh

if /cygdrive/c/windows/system32/reg.exe query "HKEY_CURRENT_USER\Software\Valve\Steam" /v SteamPath
then
    STEAMPATH=`/cygdrive/c/windows/system32/reg.exe query "HKEY_CURRENT_USER\Software\Valve\Steam" /v SteamPath | awk '$1 ~ "SteamPath" && $2 ~ "REG_SZ" { print(substr($3, 1, length($3)-1)) }'`
else
    echo "ERROR: Steam is not found on the system! This test profile needs to find Steam configuration data in the Windows Registry."
	echo 2 > ~/install-exit-status
    exit
fi

/cygdrive/${STEAMPATH:0:1}/${STEAMPATH:3}/steam.exe "steam://install/730"

unzip -o csgo-demo-10.zip
mv pts10.dem "${STEAMPATH}/steamapps/common/Counter-Strike Global Offensive/csgo"

echo "#!/bin/sh
cd \"${STEAMPATH}/steamapps/common/Counter-Strike Global Offensive\"
rm -rf csgo/SourceBench*
rm -f UNKNOWN
./csgo.exe -game csgo \$@ +con_logfile log.log
cat csgo/log.log* > \$LOG_FILE
cat csgo/SourceBench* >> \$LOG_FILE
cat csgo/UNKNOWN >> \$LOG_FILE" > csgo
chmod +x csgo
echo 0 > ~/install-exit-status
