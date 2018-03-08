#!/bin/sh

unzip -o y-cruncher-v0.7.5.9481.zip

echo "#!/bin/sh
cd \"y-cruncher v0.7.5.9481\"
./y-cruncher.exe \$@ | sed -r \"s/\x1B\[([0-9]{1,2}(;[0-9]{1,2})?)?[mGK]//g\" > \$LOG_FILE" > y-cruncher
chmod +x y-cruncher
