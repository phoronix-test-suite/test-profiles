#!/bin/sh

unzip -o xonotic-0.1.0preview.zip
mv Xonotic Xonotic_

echo "#!/bin/sh
cd Xonotic_
xonotic.exe \$@ > \$LOG_FILE" > nexuiz

