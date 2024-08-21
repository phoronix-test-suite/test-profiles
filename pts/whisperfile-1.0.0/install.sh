#!/bin/bash
chmod +x whisper-tiny-20aug24.llamafile
chmod +x whisper-small-20aug24.llamafile
chmod +x whisper-medium-20aug24.llamafile
echo $? > ~/install-exit-status
echo "#!/bin/sh
./whisper-\$1-20aug24.llamafile -f barackobamasou2016ARXE.mp3 > \$LOG_FILE 2>&1
echo \$? > ~/test-exit-status" > ~/whisperfile
chmod +x ~/whisperfile
