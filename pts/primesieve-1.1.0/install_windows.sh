#!/bin/sh

unzip -o primesieve-4.2-console-win64.zip

echo "#!/bin/sh
primesieve.exe \$@ > \$LOG_FILE" > primesieve
chmod +x primesieve
