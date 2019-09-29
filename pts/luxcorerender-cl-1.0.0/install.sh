#!/bin/sh

tar -xf luxcorerender-v2.1-linux64-opencl-sdk.tar.bz2
unzip -o DLSC.zip
unzip -o RainbowColorsAndPrism.zip
unzip -o LuxCore2.1Benchmark.zip
unzip -o Food.zip

echo "#!/bin/sh
LD_LIBRARY_PATH=\$HOME/luxcorerender-v2.1-linux64-opencl-sdk/lib:\$LD_LIBRARY_PATH ./luxcorerender-v2.1-linux64-opencl-sdk/bin/luxcoreconsole \$@  > \$LOG_FILE 2>&1
echo \$? > ~/test-exit-status" > luxcorerender-cl
chmod +x luxcorerender-cl
