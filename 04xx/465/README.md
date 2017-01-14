# How to handle coordinates in landsat images?  

The analysis (and head scratching) is done through a sequence of R files.

# 465a.R

I think the image pixels are of a fixed geometrical size in UTM projection,
based on [465a.R](465a.R).  Two questions arise:

1) how to represent these in a map of different projection?

2) how to handle this in trimming an image?

Figure [465a.png](465a.png) suggests the differences will typically be visible
on a plot, although setting corners at midpoints (in middle of the boxes in the
diagrams) would reduce the error to about the typical size of a letter on a
graph.

# 465b.R

The two panels suggest that the problem is not in trimming, but rather in the
lat-lon coordinates overall.

# References
* [wikipedia](http://en.wikipedia.org/wiki/Universal_Transverse_Mercator_coordinate_system#From_UTM_coordinates_.28E.2C_N.2C_Zone.2C_Hemi.29_to_latitude.2C_longitude_.28.CF.86.2C_.CE.BB.29)
* http://earth-info.nga.mil/GandG/publications/tm8358.2/TM8358_2.pdf
* [Snyder](http://pubs.usgs.gov/pp/1395/report.pdf) has formulae and worked examples -- the latter should
be handy for issues like units
