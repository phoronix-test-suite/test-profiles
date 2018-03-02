#!/bin/sh
unzip -o ParaView-5.4.1-Qt5-OpenGL2-MPI-Windows-64bit.zip
echo "#!/bin/sh

cd ParaView-5.4.1-Qt5-OpenGL2-MPI-Windows-64bit/bin

./pvpython Lib/site-packages/paraview/benchmark/\$@ > \$LOG_FILE" > paraview
chmod +x paraview
