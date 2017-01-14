482.R tests inference of surface temperature.

The other .R files are for the developer only -- others should ignore them, and
they are not included in the Makefile.  Below are developer notes: The idea is
to do the landsat transpose-then-flip operation in C.  Thus test 482B.R is as
482.R except doing that in C.  Similarly for 482C.R and 482d.R.  The timing
results are as follows on my laptop.

1. read.landsat() on the tirs1 band in 482.R takes 5.132s (user) and 482B.R
   takes 4.179s, a savings of 20%.  

2. For the 4X larger panchromatic band, 482C.R takes 36.559s and 482D.R takes
   25.193s, a savings of 37%.

In summary, it looks like maybe a 30% time savings.  The actual saving is not
huge but 10s of interactive time is noticeable.
