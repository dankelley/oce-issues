## mapPlot() speedup factor by setting grid=FALSE
Code,    Person, Machine, User, System, Elapsed, Notes
1288a.R,     dk,    home, 12.5,    7.5,    12.1, 0.9-22,compiled
1288a.R,     dk,    home,  9.7,    7.3,     9.5, same as above, but with source("map.R")
1288a.R,     dk,    home, 12.7,    8.3,    12.0, compiled with grid trimming decided in xy space
1288b.R,     dk,    home, xx.x,    8.3,    12.0, compiled with grid trimming decided in xy space

