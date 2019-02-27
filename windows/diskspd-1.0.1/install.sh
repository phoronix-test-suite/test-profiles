#!/bin/sh

unzip -o Diskspd-v2.0.21a.zip

echo "#!/bin/sh
cd amd64fre
./diskspd.exe \$@ > \$LOG_FILE" > diskspd
chmod +x diskspd
