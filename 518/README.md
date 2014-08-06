The code here is likely to be weird and whacky, and changeable from moment to
moment.  If CR wants to do stuff, it should be in files named e.g.  01cr.R, to
avoid filename collisions.  I don't want to use up too much time documenting
tests, so there are few comments in the code and not much here in this README.
To a large extent, I've created this entry mainly to get easy work-home
transistions, without using google-drive, which breaks for me, and Dropbox, to
which I have political objections. -- DK

* **518A.R** mollweide tests.  Top-left shows that mapPoints, mapLines, mapText and mapPolygon? work.

* **518B.R** (once called 02.R) stereopolar test. looks like you have to use ``+proj=sterea`` (note the "a" at end) or there is an error.  I want to track that error down -- may be just in drawing graticles or something internal to oce

* **518C.R** more mollweide tests; top line shows that proj4 has weird lines, but second row shows that existing code removes them.  However, *both* mapproj and proj4 have problems with moving lon0 in mollweide, and I think the only solution for that is some surgery on the data (maybe actual insertion of fake data, which I've seen in some datafiles, or maybe postprocessing of some sort ... **need to do some detective work to understand the issue**).

