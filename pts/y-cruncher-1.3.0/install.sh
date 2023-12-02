#!/bin/sh
tar -xf y-cruncher-v0.8.2.9524-static.tar.xz
echo "#!/bin/sh
cd y-cruncher\ v0.8.2.9524-static/
./y-cruncher \$@ | sed -r \"s/\x1B\[([0-9]{1,2}(;[0-9]{1,2})?)?[mGK]//g\" > \$LOG_FILE 2>&1
echo \$? > ~/test-exit-status" > y-cruncher
chmod +x y-cruncher
