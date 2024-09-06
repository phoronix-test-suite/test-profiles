#!/bin/sh
unzip -o ParaView-5.13.0-Windows-Python3.10-msvc2017-AMD64.zip
echo "#!/bin/sh
cd ParaView-5.13.0-Windows-Python3.10-msvc2017-AMD64/bin
./pvpython Lib/site-packages/paraview/benchmark/\$@ > \$LOG_FILE" > paraview
chmod +x paraview
