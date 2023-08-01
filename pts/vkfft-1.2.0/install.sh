#!/bin/sh
unzip -o VkFFT-13005671b20956983128003d3747b0529f4ded9a.zip #glslang build fix
cd VkFFT-13005671b20956983128003d3747b0529f4ded9a/
mkdir build
cd build
cmake -DCMAKE_BUILD_TYPE=Release ..
make -j $NUM_CPU_CORES
echo $? > ~/install-exit-status
cd ~
echo "#!/bin/sh
cd VkFFT-13005671b20956983128003d3747b0529f4ded9a/build/
./Vulkan_FFT \$@ > \$LOG_FILE
echo \$? > ~/test-exit-status" > vkfft
chmod +x vkfft
