#!/bin/sh

HOME=$DEBUG_REAL_HOME steam steam://install/286690
echo $? > ~/install-exit-status

echo '#!/bin/sh
cd $DEBUG_REAL_HOME/.steam/steam/steamapps/common/Metro\ 2033\ Redux

HOME=$DEBUG_REAL_HOME LIBFRAMETIME_FILE=$LOG_FILE LD_PRELOAD=$TEST_EXTENDS/libframetime/libframetime.so ./metro  -benchmark benchmarks\\\\benchmark33 -bench_runs 1 -close_on_finish' > metro2033-redux
chmod +x metro2033-redux
