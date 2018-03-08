#!/bin/sh

unzip -o bm2.zip

echo "#!/bin/sh
./e3dbm.exe > \$LOG_FILE" > euler3d
chmod +x euler3d
