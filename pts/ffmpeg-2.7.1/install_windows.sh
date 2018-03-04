#!/bin/sh

unzip -o ffmpeg-3.4.1-win64-static.zip

echo "#!/bin/sh

./ffmpeg-3.4.1-win64-static/bin/ffmpeg.exe -i HD2-h264.ts -f rawvideo -threads \$NUM_CPU_CORES -y -target ntsc-dv output 2>&1
echo \$? > ~/test-exit-status" > ffmpeg
chmod +x ffmpeg
