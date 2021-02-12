#!/bin/sh

tar -xf jpeg-xl-v0.3.1.tar.gz
unzip -o sample-photo-6000x4000-1.zip

cd jpeg-xl-v0.3.1/
./deps.sh
mkdir build
cd build
cmake .. -DCMAKE_BUILD_TYPE=Release -DBUILD_TESTING=OFF
make -j $NUM_CPU_CORES
echo $? > ~/install-exit-status

cd ~

# produce a test jxl file
./jpeg-xl-v0.3.1/build/tools/cjxl -j sample-photo-6000x4000.JPG -d 2 decode_test.jxl

echo "#!/bin/sh
if [[ $1 == "decode" ]]; then
  shift
  ./jpeg-xl-v0.3.1/build/tools/djxl decode_test.jxl \$@ > \$LOG_FILE 2>&1
else
  ./jpeg-xl-v0.3.1/build/tools/cjxl sample-photo-6000x4000.JPG out.jxl \$@ > \$LOG_FILE 2>&1
fi
echo \$? > ~/test-exit-status" > jpegxl
chmod +x jpegxl
