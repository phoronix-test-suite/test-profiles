#!/bin/sh
if which nginx>/dev/null 2>&1 ;
then
        echo 0 > ~/install-exit-status
else
        echo "ERROR: nginx is not found on the system!"
        echo 2 > ~/install-exit-status
fi

mkdir $HOME/nginx_
mkdir $HOME/nginx_/logs
mkdir $HOME/nginx_/html
tar -zxvf apache-ab-test-files-1.tar.gz
mv -f test.html nginx_/html/
mv -f pts.png nginx_/html/
echo "
    error_log $HOME/nginx_/error.log;
    pid       $HOME/nginx_/nginx.pid;
    worker_processes  $NUM_CPU_CORES;    

    events {
      # No special events for this simple setup
    }
    http {
      server {
        listen       8089;
        server_name  localhost;

        # Set a number of log, temp and cache file options that will otherwise
        # default to restricted locations accessible only to root.
        access_log $HOME/nginx_/logs/nginx_host.access.log;
        client_body_temp_path $HOME/nginx_/client_body;
        fastcgi_temp_path $HOME/nginx_/fastcgi_temp;
        proxy_temp_path $HOME/nginx_/proxy_temp;
        scgi_temp_path $HOME/nginx_/scgi_temp;
        uwsgi_temp_path $HOME/nginx_/uwsgi_temp;

        # Serve local files
        location / {
          root $HOME/nginx_/html;
          index  index.html index.htm;
          try_files \$uri \$uri/ /index.html;
        }
      }
    }
" > nginx.conf

echo "diff --git a/Makefile b/Makefile
index 395b98a..01fdef6 100644
--- a/Makefile
+++ b/Makefile
@@ -75,7 +75,7 @@ \$(ODIR)/%.o : %.c
 LUAJIT  := \$(notdir \$(patsubst %.zip,%,\$(wildcard deps/LuaJIT*.zip)))
 OPENSSL := \$(notdir \$(patsubst %.tar.gz,%,\$(wildcard deps/openssl*.tar.gz)))

-OPENSSL_OPTS = no-shared no-psk no-srp no-dtls no-idea --prefix=\$(abspath \$(ODIR))
+OPENSSL_OPTS = no-asm --strict-warnings -D_DEFAULT_SOURCE no-shared no-psk no-srp no-dtls no-idea --prefix=\$(abspath \$(ODIR))

 \$(ODIR)/\$(LUAJIT): deps/\$(LUAJIT).zip | \$(ODIR)
        echo \$(LUAJIT)
" > fix_build_fail.patch

rm -rf wrk
git clone https://gitee.com/mirrors/wrk.git
cd wrk 
git checkout a211dd5a7050b1f9e8a9870b95513060e72ac4a0
patch -p1 < ../fix_build_fail.patch
make -j $NUM_CPU_CORES
cd $HOME

echo "#!/bin/sh
key=\"\$1\"
CORE_NUMS=\$[\$NUM_CPU_CORES - 6]
if [[ \"\$key\" == \"long\" ]]; then
    ./wrk/wrk -t \$CORE_NUMS -c 1000 -d 30 http://127.0.0.1:8089/test.html  > \$LOG_FILE 2>&1
else
    ./wrk/wrk -H \"Connection: Close\" -t \$CORE_NUMS -c 1000 -d 30 http://127.0.0.1:8089/test.html > \$LOG_FILE 2>&1
fi
echo \$? > ~/test-exit-status" > nginx

chmod +x nginx
