#!/bin/sh

unzip -o mini-nbody-20151110.zip
cd mini-nbody-master/cuda

#cc -std=c99 -O3 -fopenmp -DSHMOO -o test-nbody nbody-orig.cu -lm
#echo $? > ~/install-exit-status

cd ~/
echo "#!/bin/sh
cd mini-nbody-master/cuda
bash \$@ > \$LOG_FILE
echo \$? > ~/test-exit-status" > cuda-mini-nbody
chmod +x cuda-mini-nbody
