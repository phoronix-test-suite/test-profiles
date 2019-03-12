#!/bin/sh
unzip -o AppTimer.zip
mv -f AppTimer.exe AppTimer_Run.exe

unzip -o blender-2.79a-windows64.zip
msiexec.exe LibreOffice_6.2.1_Win_x64.msi

./vlc-3.0.6-win64.exe

echo "#!/bin/sh
rm -f benchmark.txt

echo \"\$1

benchmark.txt
\$2
6
2000
1 1 0 0
1 1 0
0
1
1\" > config.txt
./AppTimer_Run.exe
tail -n +2 benchmark.txt | awk '{s+=\$1}END{print \"AVG:\",s/NR}' RS=\"\\n\" > \$LOG_FILE
" > apptimer
chmod +x apptimer
