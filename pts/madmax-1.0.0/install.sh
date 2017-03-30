#!/bin/sh

HOME=$DEBUG_REAL_HOME steam steam://install/234140
tar -xjvf madmax-prefs-2.tar.bz2
mkdir -p $DEBUG_REAL_HOME/.local/share/feral-interactive/Mad\ Max
cp -f prefs-* $DEBUG_REAL_HOME/.local/share/feral-interactive/Mad\ Max


echo "#!/bin/bash
ORIG_HOME=\$HOME
. steam-env-vars.sh
rm -f \$DEBUG_REAL_HOME/.local/share/feral-interactive/Mad Max/VFS/User/AppData/Roaming/WB Games/Mad\ Max/FeralBenchmark/*
cd \$DEBUG_REAL_HOME/.local/share/feral-interactive/Mad\ Max
cp -f \$3 preferences
sed -ie \"s/3840/\$1/g\" preferences
sed -ie \"s/2160/\$2/g\" preferences

if [ \"X\$4\" = \"XOPENGL\" ]
then
	sed -i  's/<value name=\"UseVulkan\" type=\"integer\">1<\/value>/<value name=\"UseVulkan\" type=\"integer\">0<\/value>/' preferences
	
fi

cd \$DEBUG_REAL_HOME/.steam/steam/steamapps/common/Mad\ Max/bin
./MadMax --feral-benchmark
\$PHP_BIN \$ORIG_HOME/mad-max-parser.php > \$LOG_FILE
rm -f \$DEBUG_REAL_HOME/.local/share/feral-interactive/Mad Max/VFS/User/AppData/Roaming/WB Games/Mad\ Max/FeralBenchmark/*" > madmax
chmod +x madmax
