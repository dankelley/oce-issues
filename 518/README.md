## Introduction

The code here is likely to be weird and whacky, and changeable from moment to
moment.  If CR wants to do stuff, it should be in files named e.g.  01cr.R, to
avoid filename collisions.  I don't want to use up too much time documenting
tests, so there are few comments in the code and not much here in this README.
To a large extent, I've created this entry mainly to get easy work-home
transistions, without using google-drive, which breaks for me, and Dropbox, to
which I have political objections. -- DK

## Resources

* http://trac.osgeo.org/proj/ main proj.4 page
* http://trac.osgeo.org/proj/wiki/GenParms general parameters; note the "nadgrids" section
* http://stackoverflow.com/tags/proj4/hot stackoverflow tagged proj4 and hot
* http://trac.osgeo.org/proj/wiki/proj%3Dcalcofi good lord, they even have a calcofi proj
* http://cicero.azavea.com/docs/epsg_codes.html some pre-defined codes (cicero)
* http://proj.maptools.org/faq.html FAQ; note especially re datum shifting

## Datum shift issue

After installing proj.4 (see FAQ) I get

    $ echo "-117 30" | cs2cs +proj=latlong +datum=NAD27 +to +proj=latlong +datum=NAD83
    117d0'2.901"W 30d0'0.407"N 0.000

and I wonder if that may explain some differences we've sometimes seen on chart
overlays.  The 3 minute east-west shift is about 100m.


## Files

* **518A.R** mollweide tests.  Top-left shows that mapPoints, mapLines, mapText and mapPolygon? work.

* **518B.R** (once called 02.R) stereopolar test.  Using ``+proj=stere`` works
  as of oce commit c7b4a54564886ec58a0cfdea1d7bd20a18088628.

* **518C.R** more mollweide tests; top line shows that proj4 has weird lines,
  but second row shows that existing code removes them.  However, *both*
  mapproj and proj4 have problems with moving lon0 in mollweide, and I think the
  only solution for that is some surgery on the data (maybe actual insertion of
  fake data, which I've seen in some datafiles, or maybe postprocessing of some
  sort ... **need to do some detective work to understand the issue**).

* **518D.R** testing new scheme for latlim and lonlim; only doing it on the
  right-hand panel (+proj case).


NEXT -- work on 518D.R, putting this trace-box-side scheme into non-proj4 case also.


