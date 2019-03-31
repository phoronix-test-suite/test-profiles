#!/bin/sh
unzip -o PCMark10-*.zip
/cygdrive/c/Windows/system32/cmd.exe /c pcmark10-setup.exe /install

echo "This test profile requires a PCMark 10 Professional license for command-line automation. Before running this test make sure you activate your installation." > ~/install-message

echo "#!/bin/bash
cd \"C:\Program Files\UL\PCMark 10\"
/cygdrive/c/Windows/system32/cmd.exe /c PCMark10Cmd.exe \$@ --out=out.pcm10-result --export-xml=\$LOG_FILE" > pcmark10
chmod +x pcmark10

