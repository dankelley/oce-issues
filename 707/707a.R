rm(list=ls())
library(oce)

load('coastline.rda')
file <- '/data/archive/landsat/LC80100112013172LGN00'
l <- read.landsat(file, band=1)
ll <- list(longitude=-50.44143, latitude=68.86987)
ur <- list(longitude=-50.15551, latitude=68.97754)
lt <- landsatTrim(l, ll, ur)

if (!interactive()) png('707a-%03d.png')

plot(l, col=grey.colors)
points(ll$longitude, ll$latitude, pch=19, col=2)
points(ur$longitude, ur$latitude, pch=19, col=2)
points(clon, clat, pch='.')

plot(lt, col=grey.colors)
points(ll$longitude, ll$latitude, pch=19)
points(ur$longitude, ur$latitude, pch=19)
points(clon, clat)
mtext('EXPECT: Coastline aligned with coast', col='purple', font=2)

if (!interactive()) dev.off()

