#!/bin/sh

unzip -o OctaneBench_2_17_linux.zip

echo "#!/bin/sh
cd OctaneBench_3_06_2_win/
./octane-cli.exe  --benchmark --no-gui -g 0 -a \$LOG_FILE" > octanebench
chmod +x octanebench
