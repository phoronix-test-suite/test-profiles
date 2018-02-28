#!/bin/sh

unzip -o

echo "#!/bin/sh
cd iozone-windows
./iozone.exe \$@ > \$LOG_FILE" > ~/iozone
chmod +x ~/iozone
