#!/bin/sh
tar -xf ParaView-5.13.0-MPI-Linux-Python3.10-x86_64.tar.gz
echo "#!/bin/sh
cd ParaView-5.13.0-MPI-Linux-Python3.10-x86_64/bin/
./pvpython \$HOME/ParaView-5.13.0-MPI-Linux-Python3.10-x86_64/lib/python3.10/site-packages/paraview/benchmark/\$@ > \$LOG_FILE 2>&1
echo \$? > ~/test-exit-status" > paraview
chmod +x paraview
