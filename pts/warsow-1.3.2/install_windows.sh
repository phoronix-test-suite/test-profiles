#!/bin/sh

unzip -o pts-warsow-4.zip

unzip -o warsow_0.61_unified.zip
mkdir warsow_0.61_unified/basewsw/demos
cp pts-demo.wd12 warsow_0.61_unified/basewsw/demos

echo "#!/bin/sh
cd warsow_0.61_unified/
warsow_x64.exe \$@ +set fs_usehomedir 0
mv basewsw/pts-log.log \$LOG_FILE" > warsow
chmod +x warsow
