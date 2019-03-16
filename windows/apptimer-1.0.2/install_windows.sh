#!/bin/bash
unzip -o AppTimer.zip
mv -f AppTimer.exe AppTimer_Run.exe

unzip -o blender-2.79a-windows64.zip
unzip -o vlc-3.0.6-win64.zip
unzip -o shotcut-win64-190228.zip
unzip -o VSCode-win32-x64-1.32.3.zip
unzip -o pencil2d-win64-0.6.2.zip
unzip -o FileZilla_3.41.1_win64.zip

7z x inkscape-0.92.4-x64.7z
/cygdrive/c/Windows/system32/cmd.exe /c LibreOffice_6.2.1_Win_x64.msi


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
