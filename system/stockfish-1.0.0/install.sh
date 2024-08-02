#!/bin/bash
if which stockfish >/dev/null 2>&1 ;
then
	echo 0 > ~/install-exit-status
else
	echo "ERROR: stockfish is not found on the system! This test profile needs a working Stockfish (stockfish) binary in the PATH."
	echo 2 > ~/install-exit-status
fi
echo "#!/bin/sh
stockfish bench 4096 \$NUM_CPU_CORES 26 default depth > \$LOG_FILE 2>&1
echo \$? > ~/test-exit-status
stockfish v 2>&1 | grep \"by the\" > ~/pts-footnote > ~/pts-footnote" > stockfish
chmod +x stockfish

