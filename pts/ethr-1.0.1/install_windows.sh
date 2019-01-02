#!/bin/sh

unzip -o ethr-windows-20190102.zip

echo "#!/bin/sh
cmd /c ethr.exe \$@ > \$LOG_FILE" > ethr
chmod +x ethr
