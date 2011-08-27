#!/bin/sh

unzip -o bullet-2.78.zip
cd bullet-2.78
cmake -DUSE_GRAPHICAL_BENCHMARK=OFF .
make
echo \$? > ~/test-exit-status
cd ..

echo "#!/bin/sh
cd bullet-2.78/Demos/Benchmarks
./AppBenchmarks > \$LOG_FILE 2>&1
echo \"\n\" >> \$LOG_FILE
echo \$? > ~/test-exit-status" > bullet
chmod +x bullet
