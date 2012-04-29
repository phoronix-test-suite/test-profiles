#!/bin/sh

unzip -o luxmark-linux64-v2.1beta1.zip

echo "#!/bin/sh
cd luxmark-linux64-v2.1beta1/
./luxmark-linux64 \$@ > \$LOG_FILE 2> /dev/null
echo \$? > ~/test-exit-status" > luxmark
chmod +x luxmark
