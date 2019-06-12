#!/bin/sh

/cygdrive/c/Windows/system32/cmd.exe /c petst.exe

echo "This test profile requires a commercial license of PassMark PerformanceTEST for command-line automation. Before running this test make sure you activate your installation." > ~/install-message

echo "#!/bin/bash
TS=\`date +%s%N\`
echo \"

# Clear the results
CLEARRESULTS

RUN \$1

EXPORTTEXTF \\\"results\$TS.txt\\\"

EXIT
\" > pts.ptscript

cd \"C:\Program Files\PerformanceTest\"
rm -f results\$TS.txt

/cygdrive/c/Windows/system32/cmd.exe /c PerformanceTest64.exe /s \"\$DEBUG_HOME\pts.ptscript\" /i

cat results\$TS.txt > \$LOG_FILE" > ~/passmark
chmod +x ~/passmark
