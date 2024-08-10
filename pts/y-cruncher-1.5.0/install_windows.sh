#!/bin/sh
unzip -o y-cruncher-v0.8.5.9543.zip
echo "#!/bin/sh
cd y-cruncher\ v0.8.5.9543
rm -f Pi*
./y-cruncher.exe \$@
cat Pi\ -\ 2* > \$LOG_FILE" > y-cruncher
chmod +x y-cruncher
