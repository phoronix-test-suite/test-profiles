#!/bin/sh

tar -xf ncnn-20200916.tar.gz
cd ncnn-20200916

# Workaround for build issues with current release
echo "cmake_minimum_required(VERSION 3.1) # for CMAKE_CXX_STANDARD
set(CMAKE_CXX_STANDARD 11)

add_subdirectory(caffe)
add_subdirectory(mxnet)
add_subdirectory(onnx)
add_subdirectory(darknet)
add_subdirectory(quantize)
" > tools/CMakeLists.txt

echo "" > tools/caffe/CMakeLists.txt
echo "" > tools/onnx/CMakeLists.txt

mkdir build
cd build

# Vulkan build currently not enabled due to hitting seg fault...
cmake ..
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

