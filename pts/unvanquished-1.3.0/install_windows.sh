#!/bin/sh

unzip -o unvanquished-0.25.0-universal.zip
mv unvanquished unvanquished-game

unzip -o unvanquished-25-1.zip
mkdir ~/.unvanquished
mkdir ~/.unvanquished/demos
mv pts3.dm_86 ~/.unvanquished/demos

cd unvanquished-game
tar -xJf ../Unvanquished_0.25.0.tar.xz
cd ~

echo "#!/bin/sh
cd unvanquished-game/
daemon.exe \$@ > \$LOG_FILE" > unvanquished

