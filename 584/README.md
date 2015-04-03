Manual
======

ftp://ftp.remotesensing.org/proj/OF90-284.pdf


# 2015-04-03

I coded proj 4.9.0 into oce. The early work is done but I imagine there will be
some problems cropping up. I only put projections that have inverses into oce;
there seems little point in the others, and they cause problems in oce because
the crude approximation of inverses is error prone. (Recall that the lack of
inverses in the mapproj package was a big motivation for switching to proj.)

I added ``projection_test_suite.R``. This work was done quite fast by cutting
and pasting code, and I am quite sure that some of the examples should be
tweaked in terms of projection parameters or map limits. Note that a handful of
projection caused problems. I will look into those later, working first on
projections that seem most valuable. My guess is that oceanographers will
select from only a half-dozen projections, i.e. those used commonly in atlases
and charts, and therefore these are of highest priority.

