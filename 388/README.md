---
title: issue388 UHL
---

Ugly horizontal lines (UHL) exist in some map projections.  This seems to occur
for spots on coastline paths that cross the plot limits (i.e. beyond the edge
of the projected earth).  The problem is worse when the prime merdian is
shifted, but it also occurs without shifting.

It happens with both mapproj or proj4 notations, using world coastlines from
Oce.  The problem occurs with the coastline from the maps package also.

This directory contains some tests of possible approaches.  This is an old
issue and lots of things have been tried.  The age of the issue indicates that
those things didn't really work out, and although Oce has some kludges to help
with the UHL, these kludges are not a real solution.

## 388D.R

**Idea** examine ratio of on-earth distance to on-plot distance.

**Summary** not terribly promising, since results are sensitive to parameters.

![388D.pdf](388D.pdf)

## 388E.R

**Idea** Perturb longitude and see how much x changes.  If it doesn't change
much, the point is OK.  If it does change, it may be near an edge.  

**Results.** The tests look quite good, in the sense that red dots appear by
the UHL that appear for shifted prime merdian, and they even occur for some
other sots that are worth checking.  

![388E.pdf](388E.pdf)

## 388F.R

**Idea.** Trace the "edge of the map" empirically for the active projection, so
it can be used to fill in fake points where the coastline cuts the edge.  This
would yield clean edges in filled diagrams.

**Results.** So far, 388F.R only draws the globe and this computed world edge.
But it looks good.

![388F.pdf](388F.pdf)

## 388G.R

**Idea.** Isolate australian coastline (``ca`` in ``coastlineAustralia.rda``)

**Results.** there seems to be a break in the coastline but I'll ignore that
for a while


## 388H.R

**Idea.** chop, reindex, etc the Australian continent with cut point at 120.

**Results.** works well.  I don't know how this will work on coastlines that
cross and recross the cut point, however.

![388H.  left: chop wrt cut.  middle: start trace at cut, then chop.  Right: amend near cut then fill](388H.pdf)

## 388I.R

**Idea.** find islands in world coastline

**Results.** works.

![388I. world islands, colour-coded (modulo 10)](388I.pdf)

## 388J.R

**Idea.** combine H and I to plot world coastline

**Results.** works.

![388J. colour-cut at 120E](388J.pdf)


