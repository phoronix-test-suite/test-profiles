#!/bin/sh

tar -xf ncnn-20200916.tar.gz
cd ncnn-20200916

mkdir build
cd build

# Vulkan build currently not enabled due to hitting seg fault...
cmake -DNCNN_BUILD_TOOLS=OFF -DNCNN_BUILD_EXAMPLES=OFF ..
make -j $NUM_CPU_CORES
# sometimes parallel build seems to fail, so do another make in case
make
echo $? > ~/install-exit-status

cp ../benchmark/*.param benchmark/

cd ~/
cat>ncnn<<EOT
#!/bin/sh
cd ncnn-20200916/build/benchmark
./benchncnn 200 \$NUM_CPU_CORES 0 \$@ 0  > \$LOG_FILE 2>&1
echo \$? > ~/test-exit-status
EOT
chmod +x ncnn

