#!/bin/sh

unzip -o unvanquished-0.24-universal.zip
mv unvanquished unvanquished-game

unzip -o unvanquished-17-1.zip
mkdir unvanquished-game/pkg/demos/
mv pts1.dm_86 unvanquished-game/pkg/demos/

echo "#!/bin/sh
cd unvanquished-game/
daemon.exe \$@ > \$LOG_FILE" > unvanquished

