#!/bin/sh

SA=`which systemd-analyze`
echo $? > ~/install-exit-status

cat > systemd-boot-total << EOT
#!/bin/sh

# This assumes total is always last
${SA} | \
  sed -e 's/in /\\n/' -e 's/[+|=] /\\n/g' -e 's/ms//g' | \
  tail -n 1 > \$LOG_FILE 2>&1
EOT

chmod +x systemd-boot-total
