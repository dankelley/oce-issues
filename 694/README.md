1. This directory holds an attempt by DK and CR to 'thin out' an rsk file,
   using subsample.py in conjunction with Makefile.  Subsampling both the
"data" and "thumbnailData" tables by a factor of 100 only achieves about a
factor of 2.5 reduction in file size. But blanking out the BLOB helps a lot
more. And gzipping, well jeeze Louise, that's the ticket, so my next step is to
figure out how to read it into R (trials in *.R files).

2. DK tried subsample.py for decimation, but then woke up and noticed that the
   data contain pre-cast recordings. So he plotted pressure vs time in the rsk
object, and used locator() to find times, then wrote subsample2.py to subsample
to get just the downcast. (Importantly, the subsampling is done by time, not
file location ... this lets the .rsk file retain its funky non-ordered time.)


