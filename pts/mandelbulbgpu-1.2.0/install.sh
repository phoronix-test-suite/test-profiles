#!/bin/sh

tar -xvjf mandelbulbGPU-v1.0pts-1.tar.bz2
cd mandelbulbGPU-v1.0pts/
./build.sh
echo $? > ~/install-exit-status
cd ~/

echo "#!/bin/sh
cd mandelbulbGPU-v1.0pts/
./mandelbulbGPU \$@ > \$LOG_FILE 2>&1
echo \$? > ~/test-exit-status" > mandelbulbgpu
chmod +x mandelbulbgpu
