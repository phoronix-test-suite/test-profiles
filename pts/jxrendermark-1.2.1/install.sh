#!/bin/sh

unzip -o JXRenderMark-1.0.1.zip
cc JXRenderMark.c -o jxrend -lX11 -lXrender $CFLAGS

#chmod +x JXRenderMark-1.0.1

echo "#!/bin/sh
./JXRenderMark-1.0.1 \$@ > \$LOG_FILE 2>&1
echo \$? > ~/test-exit-status" > jxrender-run
chmod +x jxrender-run
