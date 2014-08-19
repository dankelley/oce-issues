# Issue summary

Ugly horizontal lines (UHL) exist in some map projections.  This seems to occur
for spots on coastline paths that cross the plot limits (i.e. beyond the edge
of the projected earth).  The problem is worse when the prime merdian is
shifted, but it also occurs without shifting.

It happens with both mapproj or proj4 notations, using world coastlines from
Oce.  I tried the maps package with ``map('world', proj='mollweide')`` and the
problem occurs there also.

This directory contains some tests of possible approaches.  This is an old
issue and lots of things have been tried.  The age of the issue indicates that
those things didn't really work out, and although Oce has some kludges to help
with the UHL, these kludges are not a real solution.

As of Aug 2014, the best approach seems to be that tested in 388E.R


# Files

There are some old files in this directory that I've not documented here.

## 388D.R

**Idea** examine ratio of on-earth distance to on-plot distance.

**Summary** not terribly promising, since results are sensitive to parameters.

## 388E.R

**Idea** Perturb longitude and see how much x changes.  If it doesn't change
much, the point is OK.  If it does change, it may be near an edge.  

**Summary.** The tests look pretty good to me, in the sense that red dots
appear by the UHL that appear for shifted prime merdian, and they even occur
for some other sots that are worth checking.  
