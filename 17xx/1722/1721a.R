library(oce)
data(section)

if (!interactive()) png("1721a_%02d.png")

## imagep
par(mfrow=c(2,1))
imagep(volcano)
imagep(volcano, col=oce.colorsTurbo)

## drawPalette
par(mfrow=c(1,1))
breaks <- seq(0, 1, length.out=64)
zlim <- range(breaks)
drawPalette(zlim=zlim, breaks=breaks, pos=1)
drawPalette(zlim=zlim, breaks=breaks, col=oce.colorsTurbo, pos=3)
plot(0,0, xlab="", ylab="", type="n", axes=FALSE) # to avoid next plot going on top

## section
par(mfrow=c(2,1))
plot(section, which="temperature")
plot(section, which="temperature", ztype="image")

## amsr
data(coastlineWorld)
par(mfrow=c(2,1))
# Example 1
year <- 2020
month <- 8
day <- 6:8
d1 <- read.amsr(download.amsr(year, month, day[1], "~/data/amsr"))
d2 <- read.amsr(download.amsr(year, month, day[2], "~/data/amsr"))
d3 <- read.amsr(download.amsr(year, month, day[3], "~/data/amsr"))
d <- composite(d1, d2, d3)
asp <- 1/cos(pi*40/180)
plot(d, "SST", xlim=c(-80,0), ylim=c(20,60), asp=asp)
lines(coastlineWorld[['longitude']], coastlineWorld[['latitude']])

# Example 2: 'turbo' colour scheme
cm <- colormap(zlim=range(d[["SST"]], na.rm=TRUE), col=oceColorsTurbo)
plot(d, "SST", colormap=cm, xlim=c(-80,0), ylim=c(20,60), asp=asp)
lines(coastlineWorld[['longitude']], coastlineWorld[['latitude']])

if (!interactive()) dev.off()
