#!/bin/sh

echo "#!/bin/sh
/cygdrive/c/Windows/system32/cmd.exe /c C:\\\Windows\\\System32\\\WinSAT.exe \$@ -v -xml \$LOG_FILE" > winsat
chmod +x winsat
