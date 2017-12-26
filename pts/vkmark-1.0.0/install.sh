#!/bin/sh

unzip -o vkmark-20171226.zip
cd vkmark

cd GL_vs_VK-git-20170605/
git submodule update --init
mkdir build
meson build
ninja -C build
echo $? > ~/install-exit-status

cd ~
echo "#!/bin/sh
cd vkmark
./build/src/vkmark --winsys-dir=build/src --data-dir=data \$@ > \$LOG_FILE" > vkmark-run
chmod +x vkmark-run
