#!/bin/sh

tar -xf luxcorerender-v2.1-linux64-sdk.tar.bz2
unzip -o DLSC.zip
unzip -o RainbowColorsAndPrism.zip

echo "#!/bin/sh
LD_LIBRARY_PATH=\$HOME/luxcorerender-v2.1-linux64-sdk/lib:\$LD_LIBRARY_PATH ./luxcorerender-v2.1-linux64-sdk/bin/luxcoreconsole \$@  > \$LOG_FILE 2>&1
echo \$? > ~/test-exit-status" > luxcorerender
chmod +x luxcorerender
