#!/bin/sh

tar -xf libpng-1.6.37.tar.xz
tar -xjf GraphicsMagick-1.3.33.tar.bz2
unzip -o sample-photo-6000x4000-1.zip

mkdir $HOME/gm_

cd libpng-1.6.37
./configure --prefix=$HOME/gm_ > /dev/null
make -j $NUM_CPU_CORES
make install
cd ~

cd GraphicsMagick-1.3.33/
LDFLAGS="-L$HOME/gm_/lib" CPPFLAGS="-I$HOME/gm_/include" ./configure --without-perl --prefix=$HOME/gm_ --with-png=yes > /dev/null
make -j $NUM_CPU_CORES
echo $? > ~/install-exit-status
make install
cd ~
rm -rf GraphicsMagick-1.3.33/
rm -rf libpng-1.6.37
rm -rf gm_/share/doc/GraphicsMagick/
rm -rf gm_/share/man/
cd ~

./gm_/bin/gm convert sample-photo-6000x4000.JPG input.mpc

echo "#!/bin/sh
OMP_NUM_THREADS=\$NUM_CPU_CORES ./gm_/bin/gm benchmark -duration 60 convert input.mpc \$@ null: > \$LOG_FILE 2>&1
echo \$? > ~/test-exit-status" > graphics-magick
chmod +x graphics-magick
