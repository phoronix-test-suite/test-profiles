#!/bin/sh
/System/Library/CoreServices/DiskImageMounter.app/Contents/MacOS/DiskImageMounter ParaView-5.13.0-MPI-OSX10.15-Python3.10-x86_64.dmg
echo "#!/bin/sh
/Applications/ParaView-5.13.0.app/Contents/bin/pvpython /Applications/ParaView-5.13.0.app/Contents/Python/paraview/benchmark/\$@ > \$LOG_FILE 2>&1
echo \$? > ~/test-exit-status" > paraview
chmod +x paraview
