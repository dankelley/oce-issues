The tests in this directory are designed to explore whether rgdal::project()
can be used to replace the present schemes in oce::lonlat2map() and
oce::map2lonlat().

So far, the answer seems to be yes.

* 635a.R shows that a world coastline is the same in both methods
* 635b.R shows that an unprojectable point (lat>90) is handled the same in each

These are just with a particular projection. More tests are needed.

Things to do:

1. Decide whether to tack on a default ellipse, as we are doing now. Or it may
   be better to let users get what rgdal provides.

2. Tests with other projections.

3. Tests with lon0 ... don't want to forget that!!

