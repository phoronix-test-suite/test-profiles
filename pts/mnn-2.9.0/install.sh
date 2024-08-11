#!/bin/bash
rm -rf MNN-b11b7037d5dcbe7ed2c48571cd5a769fbf5b2806
unzip -o MNN-b11b7037d5dcbe7ed2c48571cd5a769fbf5b2806.zip
cd MNN-b11b7037d5dcbe7ed2c48571cd5a769fbf5b2806
cd schema
./generate.sh
cd ..
mkdir build
cd build
EXTRA_CMAKE_FLAGS=""
if [ $OS_TYPE = "Linux" ]
then
    if grep avx512 /proc/cpuinfo > /dev/null
    then
	EXTRA_CMAKE_FLAGS="$EXTRA_CMAKE_FLAGS -DMNN_AVX512=ON"
    fi
    if grep avx512_vnni /proc/cpuinfo > /dev/null
    then
	EXTRA_CMAKE_FLAGS="$EXTRA_CMAKE_FLAGS -DMNN_AVX512_VNNI=ON"
    fi
fi
cmake .. -DMNN_BUILD_BENCHMARK=true -DCMAKE_BUILD_TYPE=Release -DMNN_OPENMP=ON $EXTRA_CMAKE_FLAGS
make -j $NUM_CPU_CORES
echo $? > ~/install-exit-status
cd ~/
cat>mnn<<EOT
#!/bin/sh
cd MNN-b11b7037d5dcbe7ed2c48571cd5a769fbf5b2806/build
./benchmark.out ../benchmark/models/ 2000 100 0 \$NUM_CPU_CORES > \$LOG_FILE
echo \$? > ~/test-exit-status
EOT
chmod +x mnn
