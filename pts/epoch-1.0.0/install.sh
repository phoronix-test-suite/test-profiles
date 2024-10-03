#!/bin/sh
tar -xf epoch-4.19.4.tar.gz
cd epoch-4.19.4

echo "diff -Naur epoch3d/src/io/diagnostics.F90.orig epoch3d/src/io/diagnostics.F90
--- epoch3d/src/io/diagnostics.F90.orig	2024-09-10 05:08:07.000000000 -0500
+++ epoch3d/src/io/diagnostics.F90	2024-10-03 11:53:39.832889971 -0500
@@ -3178,57 +3178,12 @@
     CHARACTER(LEN=4) :: intstring, fracstring
     LOGICAL :: string_started
 
-    days = INT(time) / 60 / 60  / 24
-    hours = INT(time) / 60 / 60 - days * 24
-    minutes = INT(time) / 60 - (days * 24 + hours) * 60
-    seconds = INT(time) - ((days * 24 + hours) * 60 + minutes) * 60
+    seconds = INT(time)
     frac_seconds = FLOOR((time - INT(time)) * 100)
 
     timestring = ''
     string_started = .FALSE.
 
-    var = days
-    varstring = ' day'
-    IF (var > 0) THEN
-      CALL integer_as_string(var, intstring)
-      IF (string_started) THEN
-        timestring = TRIM(timestring) // ', ' // TRIM(intstring) &
-            // TRIM(varstring)
-      ELSE
-        timestring = TRIM(timestring) // TRIM(intstring) // TRIM(varstring)
-      END IF
-      IF (var > 1) timestring = TRIM(timestring) // 's'
-      string_started = .TRUE.
-    END IF
-
-    var = hours
-    varstring = ' hour'
-    IF (var > 0) THEN
-      CALL integer_as_string(var, intstring)
-      IF (string_started) THEN
-        timestring = TRIM(timestring) // ', ' // TRIM(intstring) &
-            // TRIM(varstring)
-      ELSE
-        timestring = TRIM(timestring) // TRIM(intstring) // TRIM(varstring)
-      END IF
-      IF (var > 1) timestring = TRIM(timestring) // 's'
-      string_started = .TRUE.
-    END IF
-
-    var = minutes
-    varstring = ' minute'
-    IF (var > 0) THEN
-      CALL integer_as_string(var, intstring)
-      IF (string_started) THEN
-        timestring = TRIM(timestring) // ', ' // TRIM(intstring) &
-            // TRIM(varstring)
-      ELSE
-        timestring = TRIM(timestring) // TRIM(intstring) // TRIM(varstring)
-      END IF
-      IF (var > 1) timestring = TRIM(timestring) // 's'
-      string_started = .TRUE.
-    END IF
-
     var = seconds
     varstring = ' seconds'
     IF (var > 0 .OR. frac_seconds > 0 .OR. .NOT.string_started) THEN
" > only-seconds.patch
patch -p0 < only-seconds.patch

cd epoch3d
make COMPILER=auto
echo $? > ~/install-exit-status
cd ~
cat>epoch<<EOT
#!/bin/sh
cd epoch-4.19.4/epoch3d/
mkdir Data
cp example_decks/\$1.deck Data/input.deck
echo Data | mpirun --allow-run-as-root -np \$NUM_CPU_PHYSICAL_CORES ./bin/epoch3d > \$LOG_FILE 2>&1
echo \$? > ~/test-exit-status
rm -rf Data
EOT
chmod +x epoch
