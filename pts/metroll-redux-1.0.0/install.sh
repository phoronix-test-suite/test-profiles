#!/bin/sh

HOME=$DEBUG_REAL_HOME steam steam://install/287390
echo $? > ~/install-exit-status

echo '#!/bin/sh
cd $DEBUG_REAL_HOME/.steam/steam/steamapps/common/Metro\ Last\ Light\ Redux

HOME=$DEBUG_REAL_HOME LIBFRAMETIME_FILE=$LOG_FILE LD_PRELOAD=$TEST_EXTENDS/libframetime/libframetime.so ./metro  -benchmark benchmarks\\\\benchmark -bench_runs 1 -close_on_finish' > metroll-redux
chmod +x metroll-redux
