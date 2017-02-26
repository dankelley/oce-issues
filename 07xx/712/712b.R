rm(list=ls())
library(oce) # using commit fb5e45f120cabf35 from rsktxt branch

d <- read.oce('060130_20150720_1135.txt', debug=10)

## d <- read.oce('/data/archive/fjord/2013/CTD/ctd_boat/052918_20130729_2257.txt', debug=10) # from a Greenland 2013 Virtuoso


if (!interactive()) png('712a.png')

plot(d)

if (!interactive()) dev.off()
