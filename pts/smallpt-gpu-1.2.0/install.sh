#!/bin/sh

tar -xvjf SmallptGPU-v1.6pts-1.tar.bz2
cd SmallptGPU-v1.6pts/
./build.sh
echo $? > ~/install-exit-status
cd ~/

echo "#!/bin/sh
cd SmallptGPU-v1.6pts/
./smallptGPU \$@ > \$LOG_FILE 2>&1
echo \$? > ~/test-exit-status" > smallpt-gpu
chmod +x smallpt-gpu
