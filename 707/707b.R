library(oce)
library(ocedata)
source("~/src/oce/R/landsat.R")

if (0 == length(ls(pattern="^l$"))) { # cache for speed
    data(coastlineWorldFine)
    message("reading data")
    load('coastline.rda')
    file <- '/data/archive/landsat/LC80100112013172LGN00'
    l <- read.landsat(file, band=c('aerosol', 'tirs1'))
}
ll <- list(longitude=-50.44143, latitude=68.86987)
ur <- list(longitude=-50.15551, latitude=68.97754)
lt <- landsatTrim(l, ll, ur, debug=10)

if (!interactive()) png('707b-%03d.png')

plot(l, band='tirs1')
points(ll$longitude, ll$latitude, pch=19, col=2)
points(ur$longitude, ur$latitude, pch=19, col=2)
polygon(c(ll$longitude, ll$longitude, ur$longitude, ur$longitude),
        c(ll$latitude, ur$latitude, ur$latitude, ll$latitude),
        col='purple', lwd=2)
lines(coastlineWorldFine[['longitude']], coastlineWorldFine[['latitude']], lwd=2)
mtext('EXPECT: Coastline aligned with coast, box aligns with trimmed image', col='purple', font=2)

plot(lt, band='aerosol', col=grey.colors)
points(ll$longitude, ll$latitude, pch=19)
points(ur$longitude, ur$latitude, pch=19)
lines(coastlineWorldFine[['longitude']], coastlineWorldFine[['latitude']])
points(clon, clat)
mtext('EXPECT: Coastline @ coast (misfit nearly 0.2lon 0.04lat)', col='purple', font=2, adj=0)


if (!interactive()) dev.off()

