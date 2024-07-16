#!/bin/sh
unzip -o x64_windows_x64_launcher_breakinglimit_corporate_1.0.0.zip 
echo "<?php
\$result = file_get_contents(\$argv[1]);
\$json = json_decode(\$result, TRUE);
echo 'AVERAGE FPS: ' . \$json['result']['averageFPS'] . PHP_EOL;
echo 'MINIMUM FPS: ' . \$json['result']['minFPS'] . PHP_EOL;
echo 'MAXIMUM FPS: ' . \$json['result']['maxFPS'] . PHP_EOL;
echo '---- GPU FRAMES ----' . PHP_EOL;
//echo implode(' ', \$json['frames']['frameTimes']);" > win-unpacked/resources/binaries/parser.php
echo "#!/bin/bash
cd win-unpacked/resources/binaries/
./GPUScoreVulkan.exe TestType custom BenchmarkMode true Fullscreen true ReportPath output.json \$@ > \$LOG_FILE 2>&1
\$PHP_BIN parser.php output.json > \$LOG_FILE" > breaking-limit
chmod +x breaking-limit
