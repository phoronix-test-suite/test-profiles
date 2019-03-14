#!/bin/bash
unzip -o AppTimer.zip
mv -f AppTimer.exe AppTimer_Run.exe

unzip -o blender-2.79a-windows64.zip

/cygdrive/c/Windows/system32/cmd.exe /c LibreOffice_6.2.1_Win_x64.msi

/cygdrive/c/Windows/system32/cmd.exe /c vlc-3.0.6-win64.exe

echo "#!/bin/sh
rm -f benchmark.txt

echo \"\$1

benchmark.txt
\$2
1
1000
1 1 0 0
1 1 0
0
1
1\" > config.txt
./AppTimer_Run.exe
tail -n +1 benchmark.txt | awk '{s+=\$1}END{print \"AVG:\",s/NR}' RS=\"\\n\" > \$LOG_FILE
" > apptimer
chmod +x apptimer
