#!/bin/sh

tar -xvf numpy-benchmarks-20160218.tar.gz
cd numpy-benchmarks-master/
patch -p1 <<'EOT'
diff -Nur a/benchit.py b/benchit.py
--- a/benchit.py	2016-02-18 14:21:28.000000000 +0000
+++ b/benchit.py	2019-11-06 17:00:05.219973553 +0000
@@ -2,6 +2,7 @@
 An adaptation from timeit that outputs some extra statistical informations
 '''
 
+from __future__ import print_function
 from timeit import default_timer, default_repeat, Timer
 import numpy
 import sys
@@ -27,9 +28,9 @@
         opts, args = getopt.getopt(args, "n:s:r:tcvh",
                                    ["number=", "setup=", "repeat=",
                                     "time", "clock", "verbose", "help"])
-    except getopt.error, err:
-        print err
-        print "use -h/--help for command line help"
+    except getopt.error as err:
+        print(err)
+        print("use -h/--help for command line help")
         return 2
     timer = default_timer
     stmt = "\n".join(args) or "pass"
@@ -56,7 +57,7 @@
                 precision += 1
             verbose += 1
         if o in ("-h", "--help"):
-            print __doc__,
+            print(__doc__)
             return 0
     setup = "\n".join(setup) or "pass"
     # Include the current directory, so that local imports work (sys.path
@@ -75,7 +76,7 @@
                 t.print_exc()
                 return 1
             if verbose:
-                print "%d loops -> %.*g secs" % (number, precision, x)
+                print("%d loops -> %.*g secs" % (number, precision, x))
             if x >= 0.2:
                 break
     try:
@@ -84,13 +85,13 @@
         t.print_exc()
         return 1
     if verbose:
-        print "raw times:", " ".join(["%.*g" % (precision, x) for x in r])
+        print("raw times:", " ".join(["%.*g" % (precision, x) for x in r]))
     r = [int(x * 1e6 / number) for x in r]
     best = min(r)
     average = int(numpy.average(r))
     std = int(numpy.std(r))
 
-    print best, average, std
+    print(best, average, std)
 
 if __name__ == "__main__":
     sys.exit(main())
diff -Nur a/benchmarks/allpairs_distances_loops.py b/benchmarks/allpairs_distances_loops.py
--- a/benchmarks/allpairs_distances_loops.py	2016-02-18 14:21:28.000000000 +0000
+++ b/benchmarks/allpairs_distances_loops.py	2019-11-11 11:34:25.286128439 +0000
@@ -2,6 +2,7 @@
 #run: allpairs_distances_loops(X, Y)
 
 #pythran export allpairs_distances_loops(float64[][], float64[][])
+from compat import xrange
 import numpy as np
 
 def allpairs_distances_loops(X,Y):
diff -Nur a/benchmarks/conv.py b/benchmarks/conv.py
--- a/benchmarks/conv.py	2016-02-18 14:21:28.000000000 +0000
+++ b/benchmarks/conv.py	2019-11-11 11:34:41.333127161 +0000
@@ -2,6 +2,7 @@
 #run: conv(x,w)
 
 #pythran export conv(float[][], float[][])
+from compat import xrange
 import numpy as np
 
 def clamp(i, offset, maxval):
@@ -22,6 +23,6 @@
         for j in xrange(sx[1]):
             for ii in xrange(sw[0]):
                 for jj in xrange(sw[1]):
-                    idx = clamp(i,ii-sw[0]/2,sw[0]), clamp(j,jj-sw[0]/2,sw[0])
+                    idx = clamp(i,ii-int(sw[0]/2),sw[0]), clamp(j,jj-int(sw[0]/2),sw[0])
                     result[i,j] += x[idx] * weights[ii,jj]
     return result
diff -Nur a/benchmarks/diffusion.py b/benchmarks/diffusion.py
--- a/benchmarks/diffusion.py	2016-02-18 14:21:28.000000000 +0000
+++ b/benchmarks/diffusion.py	2019-11-06 17:00:05.219973553 +0000
@@ -1,4 +1,4 @@
-#setup: import numpy as np;lx,ly=(2**7,2**7);u=np.zeros([lx,ly],dtype=np.double);u[lx/2,ly/2]=1000.0;tempU=np.zeros([lx,ly],dtype=np.double)
+#setup: import numpy as np;lx,ly=(2**7,2**7);u=np.zeros([lx,ly],dtype=np.double);u[int(lx/2),int(ly/2)]=1000.0;tempU=np.zeros([lx,ly],dtype=np.double)
 #run: diffusion(u,tempU,100)
 
 #pythran export diffusion(float [][], float [][], int)
diff -Nur a/benchmarks/fft.py b/benchmarks/fft.py
--- a/benchmarks/fft.py	2016-02-18 14:21:28.000000000 +0000
+++ b/benchmarks/fft.py	2019-11-11 11:34:58.235125815 +0000
@@ -2,7 +2,7 @@
 #run: fft(a)
 
 #pythran export fft(complex [])
-
+from compat import xrange
 import math, numpy as np
 
 def fft(x):
diff -Nur a/benchmarks/grayscott.py b/benchmarks/grayscott.py
--- a/benchmarks/grayscott.py	2016-02-18 14:21:28.000000000 +0000
+++ b/benchmarks/grayscott.py	2019-11-06 17:00:05.219973553 +0000
@@ -12,8 +12,8 @@
 
     r = 20
     u[:] = 1.0
-    U[n/2-r:n/2+r,n/2-r:n/2+r] = 0.50
-    V[n/2-r:n/2+r,n/2-r:n/2+r] = 0.25
+    U[int(n/2)-r:int(n/2)+r,int(n/2)-r:int(n/2)+r] = 0.50
+    V[int(n/2)-r:int(n/2)+r,int(n/2)-r:int(n/2)+r] = 0.25
     u += 0.15*np.random.random((n,n))
     v += 0.15*np.random.random((n,n))
 
diff -Nur a/benchmarks/growcut.py b/benchmarks/growcut.py
--- a/benchmarks/growcut.py	2016-02-18 14:21:28.000000000 +0000
+++ b/benchmarks/growcut.py	2019-11-11 11:35:17.283124298 +0000
@@ -3,6 +3,7 @@
 #run: growcut(image, state, state_next, 10)
 
 #pythran export growcut(float[][][], float[][][], float[][][], int)
+from compat import xrange
 import math
 import numpy as np
 def window_floor(idx, radius):
diff -Nur a/benchmarks/hyantes.py b/benchmarks/hyantes.py
--- a/benchmarks/hyantes.py	2016-02-18 14:21:28.000000000 +0000
+++ b/benchmarks/hyantes.py	2019-11-11 11:35:28.881123374 +0000
@@ -1,4 +1,4 @@
-#setup: import numpy ; a = numpy.array([ [i/10., i/10., i/20.] for i in xrange(80)], dtype=numpy.double)
+#setup: import numpy ; from compat import xrange ; a = numpy.array([ [i/10., i/10., i/20.] for i in xrange(80)], dtype=numpy.double)
 #run: hyantes(0, 0, 90, 90, 1, 100, 80, 80, a)
 
 #pythran export hyantes(float, float, float, float, float, float, int, int, float[][])
diff -Nur a/benchmarks/local_maxima.py b/benchmarks/local_maxima.py
--- a/benchmarks/local_maxima.py	2016-02-18 14:21:28.000000000 +0000
+++ b/benchmarks/local_maxima.py	2019-11-06 17:00:05.219973553 +0000
@@ -22,6 +22,6 @@
   for pos in np.ndindex(data.shape):
     myval = data[pos]
     for offset in np.ndindex(wsize):
-      neighbor_idx = tuple(mode(p, o-w/2, w) for (p, o, w) in zip(pos, offset, wsize))
+      neighbor_idx = tuple(mode(p, o-int(w/2), w) for (p, o, w) in zip(pos, offset, wsize))
       result[pos] &= (data[neighbor_idx] <= myval)
   return result
diff -Nur a/benchmarks/pairwise.py b/benchmarks/pairwise.py
--- a/benchmarks/pairwise.py	2016-02-18 14:21:28.000000000 +0000
+++ b/benchmarks/pairwise.py	2019-11-11 11:35:39.809122504 +0000
@@ -3,6 +3,7 @@
 #run: pairwise(X)
 
 #pythran export pairwise(float [][])
+from compat import xrange
 
 import numpy as np
 def pairwise(X):
diff -Nur a/benchmarks/smoothing.py b/benchmarks/smoothing.py
--- a/benchmarks/smoothing.py	2016-02-18 14:21:28.000000000 +0000
+++ b/benchmarks/smoothing.py	2019-11-11 11:35:55.039121291 +0000
@@ -3,6 +3,7 @@
 #from: http://www.parakeetpython.com/
 
 #pythran export smoothing(float[], float)
+from compat import xrange
 
 def smoothing(x, alpha):
   """
diff -Nur a/benchmarks/wdist.py b/benchmarks/wdist.py
--- a/benchmarks/wdist.py	2016-02-18 14:21:28.000000000 +0000
+++ b/benchmarks/wdist.py	2019-11-11 11:36:04.495120538 +0000
@@ -3,6 +3,7 @@
 #run: wdist(A,B,W)
 
 #pythran export wdist(float64 [][], float64 [][], float64[][])
+from compat import xrange
 
 import numpy as np
 def wdist(A, B, W):
diff -Nur a/compat.py b/compat.py
--- a/compat.py	1970-01-01 00:00:00.000000000 +0000
+++ b/compat.py	2019-11-11 11:58:36.626012865 +0000
@@ -0,0 +1,6 @@
+import sys
+
+if sys.version_info[0] >= 3:
+    from builtins import range as xrange
+else:
+    from __builtin__ import xrange
Binary files a/compat.pyc and b/compat.pyc differ
diff -Nur a/run.py b/run.py
--- a/run.py	2016-02-18 14:21:28.000000000 +0000
+++ b/run.py	2019-11-11 11:42:37.642089231 +0000
@@ -96,7 +96,7 @@
         self.decorator = '@hope.jit\n'
 
 
-def run(filenames, extractors):
+def run(filenames, extractors, python):
     location = tempfile.mkdtemp(prefix='rundir_', dir='.')
     shelllines = []
     for extractor in extractors:
@@ -111,7 +111,7 @@
                 setup, run, content = e(filename)
                 open(where, 'w').write(content)
                 e.compile(where)
-                shelllines.append('printf "{function} {extractor} " && PYTHONPATH=..:$PYTHONPATH python -m benchit -r 11 -n 40 -s "{setup}; from {module} import {function} ; {run}" "{run}" 2>/dev/null || echo unsupported'.format(setup=setup, module=tmpmodule, function=function, run=run, extractor=extractor.name))
+                shelllines.append('printf "{function} {extractor} " && PYTHONPATH=..:$PYTHONPATH {python} -m benchit -r 11 -n 40 -s "{setup}; from {module} import {function} ; {run}" "{run}" 2>/dev/null || echo unsupported'.format(setup=setup, module=tmpmodule, function=function, run=run, extractor=extractor.name, python=python))
             except:
                 shelllines.append('echo "{function} {extractor} unsupported"'.format(function=function, extractor=extractor.name))
 
@@ -136,6 +136,8 @@
     default_targets=['python', 'pythran', 'parakeet', 'numba', 'pypy', 'hope']
     parser.add_argument('-t', action='append', dest='targets', metavar='TARGET',
                         help='target compilers to use, default is %s' % ', '.join(default_targets))
+    parser.add_argument('-p', dest='python', default='python2',
+                        help='Python Interperter, like python2, python3')
     args = parser.parse_args(sys.argv[1:])
 
     if args.targets is None:
@@ -144,5 +146,5 @@
     conv = lambda t: globals()[t.capitalize() + 'Extractor']
     args.targets = [conv(t) for t in args.targets]
 
-    script = run(args.benchmarks, args.targets)
+    script = run(args.benchmarks, args.targets, args.python)
     os.execl(script, script)
EOT
cd ~

echo $? > ~/install-exit-status
echo "#!/bin/sh
cd numpy-benchmarks-master/
python2 run.py -t python -p \$1 > numpy_log
echo 'Test name :   Avg time ( nanoseconds )'
cat numpy_log | awk 'BEGIN{total_avg_time=0} {print \$1\":\"\$4;total_avg_time+=\$4;} END{printf(\"\n\n-------------------\nTotal avg time (nanoseconds): %.02f\n\", total_avg_time);}' \$@ > \$LOG_FILE
echo \$? > ~/test-exit-status " > numpy
chmod +x numpy
