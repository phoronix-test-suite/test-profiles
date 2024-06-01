#!/bin/sh
if which openssl >/dev/null 2>&1 ;
then
	echo 0 > ~/install-exit-status
else
	echo "ERROR: OpenSSL is not found on the system! No openssl in PATH."
	echo 2 > ~/install-exit-status
fi

echo "#!/bin/bash
FOOTNOTE=\`openssl version 2>/dev/null\`
SSL_EXTRAS=\"\"
if [ -f /usr/lib/x86_64-linux-gnu/engines-3/qatengine.so ]; then
  SSL_EXTRAS=\"\$SSL_EXTRAS -engine qatengine -async_jobs 8\"
  export OPENSSL_ENGINES=\"/usr/lib/x86_64-linux-gnu/engines-3\"
  FOOTNOTE=\"\$FOOTNOTE - Additional Parameters: \$SSL_EXTRAS\"
fi
echo \$FOOTNOTE > ~/pts-footnote
openssl speed -multi \$NUM_CPU_CORES -seconds 30 \$@ \$SSL_EXTRAS > \$LOG_FILE 2>&1
echo \$? > ~/test-exit-status" > openssl
chmod +x openssl
