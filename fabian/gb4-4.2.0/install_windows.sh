#!/bin/sh

copy C:\Users\%USERNAME%\gb4_files\gb4-windows.zip .
unzip -o gb4-windows.zip
gb4-windows\activar.bat

echo "#!/bin/sh
cd gb4-windows
geekbench4.exe --section 2 > \$LOG_FILE" > gb4
chmod +x gb4