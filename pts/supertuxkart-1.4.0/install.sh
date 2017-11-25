#!/bin/sh

tar xvfJ supertuxkart-0.9.3-linux.tar.xz

echo "#!/bin/sh
cd supertuxkart-0.9.3-linux/
LD_LIBRARY_PATH=\"./lib-64:\$LD_LIBRARY_PATH\" ./bin-64/supertuxkart \$@ 2>&1
cat ~/.config/supertuxkart/0.8.2/stdout.log > \$LOG_FILE" > supertuxkart
chmod +x supertuxkart

rm supertuxkart-0.9.3-linux.tar.xz
