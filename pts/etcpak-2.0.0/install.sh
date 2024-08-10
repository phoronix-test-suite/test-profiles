#!/bin/sh
tar -xf game_textures_1.tar.xz
rm -rf etcpak-2.0
tar -xf etcpak-2.0.tar.gz
cd etcpak-2.0/
sed -i 's/NumTasks = 9/NumTasks = 200/g' Application.cpp 
meson setup build
cd build
meson compile
echo $? > ~/install-exit-status
cd ~
echo "#!/bin/sh
cd etcpak-2.0/build
./etcpak \$@ ~/8k_game_textures.png > \$LOG_FILE 2>&1
echo \$? > ~/test-exit-status" > etcpak
chmod +x etcpak

