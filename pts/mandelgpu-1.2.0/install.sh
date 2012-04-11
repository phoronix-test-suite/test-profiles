#!/bin/sh

tar -xvjf MandelGPU-v1.3pts-1.tar.bz2
cd MandelGPU-v1.3pts/
./build.sh
echo $? > ~/install-exit-status
cd ~/

echo "#!/bin/sh
cd MandelGPU-v1.3pts/
./mandelGPU \$@ > \$LOG_FILE 2>&1
echo \$? > ~/test-exit-status" > mandelgpu
chmod +x mandelgpu
