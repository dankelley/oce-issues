rm(list=ls())
library(oce)
library(ocedata)
data(coastlineWorldFine)

load('coastline.rda')
file <- '/data/archive/landsat/LC80100112013172LGN00'
l <- read.landsat(file, band=1)
ll <- list(longitude=-50.44143, latitude=68.86987)
ur <- list(longitude=-50.15551, latitude=68.97754)
lt <- landsatTrim(l, ll, ur)

if (!interactive()) png('707b-%03d.png')

plot(l)
points(ll$longitude, ll$latitude, pch=19, col=2)
points(ur$longitude, ur$latitude, pch=19, col=2)
polygon(c(ll$longitude, ll$longitude, ur$longitude, ur$longitude),
        c(ll$latitude, ur$latitude, ur$latitude, ll$latitude),
        col='purple', lwd=2)
lines(coastlineWorldFine[['longitude']], coastlineWorldFine[['latitude']])
mtext('EXPECT: Coastline aligned with coast, box aligns with trimmed image', col='purple', font=2)

plot(lt, col=grey.colors)
points(ll$longitude, ll$latitude, pch=19)
points(ur$longitude, ur$latitude, pch=19)
lines(coastlineWorldFine[['longitude']], coastlineWorldFine[['latitude']])
points(clon, clat)
mtext('EXPECT: Coastline aligned with coast', col='purple', font=2)


if (!interactive()) dev.off()

