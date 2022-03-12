#!/bin/sh

tar -xf ospray_studio-0.10.0.tar.gz
cd ospray_studio-0.10.0
mkdir build
cd build
cmake .. -DUSE_BENCHMARK=ON -DCMAKE_BUILD_TYPE=Release
make -j $NUM_CPU_CORES
echo $? > ~/install-exit-status

cd ~
unzip -o OSPRayStudio-Room-Scene.zip

echo "#!/bin/sh
export PATH=\$HOME/ospray_studio-0.10.0/build/:\$PATH

cd OSPRayStudio-Room-Scene/
ospStudio benchmark --denoiser --format jpg --forceRewrite \$@ RoomScene.sg > \$LOG_FILE 2>&1
echo \$? > ~/test-exit-status" > ospray-studio
chmod +x ospray-studio
