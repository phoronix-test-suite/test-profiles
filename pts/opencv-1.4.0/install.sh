#!/bin/sh
tar -xf opencv-4.7.0.tar.gz
tar -xf opencv_extra-4.7.0.tar.gz
cd opencv-4.7.0
mkdir build
cd build
cmake -DCMAKE_BUILD_TYPE=Release -DWITH_OPENCL=OFF ..
make -j $NUM_CPU_CORES
echo $? > ~/install-exit-status
cd ~

# Get the geomean of all the tests 
echo "import math
file = open('data_for_all', 'r')
data = []
for line in file:
    line = line.strip() 
    data.append(float(line))
value = math.exp(math.fsum(math.log(x) for x in data) / len(data))
print (\"The geomean time is \", value/1000, \" ms\")" > get_geomean.py

echo "#!/bin/sh
cd opencv-4.7.0/modules/ts/misc
export OPENCV_TEST_DATA_PATH=\$HOME/opencv_extra-4.7.0/testdata/
python ./run.py \$HOME/opencv-4.7.0/build -t \$@ -w \$HOME
python ./summary.py \$HOME/\$@*.xml -o txt -u mks -m mean &>\$HOME/\$@.result
cd \$HOME
rm \$HOME/\$@*.xml
cat \$@.result | awk 'NR>=6{print \$NF}' > data_for_all
python get_geomean.py > \$LOG_FILE 2>&1
echo \$? > ~/test-exit-status" > opencv
chmod +x opencv
