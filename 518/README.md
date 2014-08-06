The code here is likely to be weird and whacky, and changeable from moment to
moment.  If CR wants to do stuff, it should be in files named e.g.  01cr.R, to
avoid filename collisions.  I don't want to use up too much time documenting
tests, so there are few comments in the code and not much here in this README.
To a large extent, I've created this entry mainly to get easy work-home
transistions, without using google-drive, which breaks for me, and Dropbox, to
which I have political objections. -- DK

* **01.R** mollweide tests.  Top-left shows that mapPoints, mapLines, mapText and mapPolygon? work.

* **02.R** stereopolar test. looks like you have to use ``+proj=sterea`` (note the "a" at end) or there is an error.  I want to track that error down -- may be just in drawing graticles or something internal to oce

* **03.R** ?

