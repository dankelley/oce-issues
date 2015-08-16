## https://github.com/dankelley/oce/issues/707
## https://github.com/dankelley/oce/commit/b3adc80e7725ddb28a864e07ddc627a373bc0c40
library(oce)
library(ocedata)

if (0 == length(ls(pattern="^l$"))) { # cache for speed
    data(coastlineWorldFine)
    message("reading data")
    load('coastline.rda')
    file <- '/data/archive/landsat/LC80100112013172LGN00'
    l <- read.landsat(file, band=1)
} else {
    message("using cached data for speed")
}
ll <- list(longitude=-50.44143, latitude=68.86987)
ur <- list(longitude=-50.15551, latitude=68.97754)
lt <- landsatTrim(l, ll, ur)

if (!interactive()) png('707a.png')

par(mfrow=c(2,1))
plot(l, col=grey.colors)
lines(coastlineWorldFine[['longitude']], coastlineWorldFine[['latitude']])
lines(c(ll$longitude, ll$longitude, ur$longitude, ur$longitude, ll$longitude),
      c(ll$latitude, ur$latitude, ur$latitude, ll$latitude, ll$latitude), col=2)
## points(clon, clat, pch='.', cex=1/3, col=3) # DK deleted; redundant with panel b
mtext('(a) EXPECT: red box half dark, half bright (as panel b)', col='purple',
      cex=0.8, font=2, adj=0)
mtext('Any more telltales, CR?', col='purple',
      cex=0.8, font=2, adj=1, line=-1)

plot(lt, col=grey.colors)
lines(c(ll$longitude, ll$longitude, ur$longitude, ur$longitude, ll$longitude),
      c(ll$latitude, ur$latitude, ur$latitude, ll$latitude, ll$latitude), col=2)
points(clon, clat, pch='.', cex=1/3, col=3)
## lines(coastlineWorldFine[['longitude']], coastlineWorldFine[['latitude']])
mtext('(b) EXPECT: Green (hi-res coastline) traces gray transition', col='purple',
      cex=0.8, font=2, adj=0)

if (!interactive()) dev.off()

