#!/bin/sh

unzip -o DiskSpd-2.0.21a.zip

echo "#!/bin/sh
cd amd64
./diskspd.exe \$@ > \$LOG_FILE" > diskspd
chmod +x diskspd
