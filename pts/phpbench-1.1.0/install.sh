#!/bin/sh

tar -zxvf phpbench-0.8.1.tar.gz

echo "#!/bin/sh

if [ ! \"X\$PHP_BIN\" = \"X\" ] && [ -x \$PHP_BIN ]
then
	PHP_CMD=\$PHP_BIN
else
	PHP_CMD=php
fi

cd phpbench-0.8.1/
php phpbench.php \$@ > \$LOG_FILE 2> /dev/null" > phpbench
chmod +x phpbench
