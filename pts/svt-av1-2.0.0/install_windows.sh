#!/bin/sh

7z x Bosphorus_1920x1080_120fps_420_8bit_YUV_RAW.7z
unzip -o SVT-AV1-0.6-Windows.zip

echo "#!/bin/sh
./SvtAv1EncApp.exe \$@ -i Bosphorus_1920x1080_120fps_420_8bit_YUV.yuv -w 1920 -h 1080 > \$LOG_FILE 2>&1" > svt-av1
chmod +x svt-av1
