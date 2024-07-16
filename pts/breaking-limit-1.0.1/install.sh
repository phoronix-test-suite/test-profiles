#!/bin/sh
tar -xf amd64_ubuntu20_amd64_launcher_breakinglimit_corporate_1.0.0.tar.gz
echo "<?php
\$result = file_get_contents(\$argv[1]);
\$json = json_decode(\$result, TRUE);
echo 'AVERAGE FPS: ' . \$json['result']['averageFPS'] . PHP_EOL;
echo 'MINIMUM FPS: ' . \$json['result']['minFPS'] . PHP_EOL;
echo 'MAXIMUM FPS: ' . \$json['result']['maxFPS'] . PHP_EOL;
echo '---- GPU FRAMES ----' . PHP_EOL;
//echo implode(' ', \$json['frames']['frameTimes']);" > linux-unpacked/resources/binaries/parser.php
echo "#!/bin/bash
cd linux-unpacked/resources/binaries
./GPUScoreVulkan TestType custom BenchmarkMode true Fullscreen true ReportPath output.json \$@ > \$LOG_FILE 2>&1
echo \$? > ~/test-exit-status
\$PHP_BIN parser.php output.json > \$LOG_FILE" > breaking-limit
chmod +x breaking-limit
