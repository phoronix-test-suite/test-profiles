#!/bin/sh

tar -xjf libvpx-v1.3.0.tar.bz2

cd libvpx-v1.3.0/
./configure --disable-install-docs
make -j $NUM_CPU_JOBS
echo $? > ~/install-exit-status
cd ~

echo "#!/bin/sh
cd libvpx-v1.3.0/
./vpxenc --best --psnr -v -t \$NUM_CPU_CORES -o /dev/null ~/soccer_4cif.y4m 2> \$LOG_FILE 
echo \$? > ~/test-exit-status" > vpxenc
chmod +x vpxenc
