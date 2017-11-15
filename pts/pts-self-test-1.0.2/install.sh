#!/bin/sh

echo "#!/bin/sh
PHP_BIN=\$PHP_BIN phoronix-test-suite debug-self-test > \$LOG_FILE 2>&1" > pts-self-test
chmod +x pts-self-test
