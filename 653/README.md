The tests in this directory are designed to explore whether rgdal::project()
can be used to replace the present schemes in oce::lonlat2map() and
oce::map2lonlat().

So far, the answer seems to be yes.

* 635a.R shows that a world coastline is the same in both methods (+proj=moll)
* 635b.R shows that an unprojectable point (lat>90) is handled the same in each
* 635c.R shows that a world coastline is the same in both methods (+proj=ortho)

These are just with a particular projection. More tests are needed.

Things to do:

1. Decide whether to tack on a default ellipse, as we are doing now. Or it may
   be better to let users get what rgdal provides.

2. Tests with lon0 ... don't want to forget that!!

3. We will have 4 months before the next oce, so that gives time for even
   radical changes, e.g. maybe use rgdal to do the mapping...
