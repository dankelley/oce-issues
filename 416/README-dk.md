# DK notes

(Also see ../blog-dk.md.)

* 416C.R uses d=0.5, which produces nice results; contrasting 416C.out with
416A.out may help to show what is wrong in the internal calculations.

* 415layout.R is an attempt to learn how layout() controls par("fin") etc.

* 415layout2.R has a trick using frame() and then par(new=TRUE), I am able to
get par("fin") values that make sense.  Possibly this is going to lead the way
to some success.
