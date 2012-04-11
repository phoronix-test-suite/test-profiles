#!/bin/sh

tar -xvjf JuliaGPU-v1.2pts-1.tar.bz2
cd JuliaGPU-v1.2pts/
./build.sh
echo $? > ~/install-exit-status
cd ~/

echo "#!/bin/sh
cd JuliaGPU-v1.2pts/
./juliaGPU \$@ > \$LOG_FILE 2>&1
echo \$? > ~/test-exit-status" > juliagpu
chmod +x juliagpu
