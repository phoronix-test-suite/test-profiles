#!/bin/sh

7z x Bosphorus_1920x1080_120fps_420_8bit_YUV_RAW.7z
7z x SvtAv1Enclib-0.8.5.zip
7z x SvtAv1EncApp-0.8.5.zip
chmod +x SvtAv1EncApp.exe

echo "#!/bin/sh
./SvtAv1EncApp.exe \$@ > \$LOG_FILE 2>&1" > svt-av1
chmod +x svt-av1
