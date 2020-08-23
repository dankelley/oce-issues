library(oce)
data(section)
data(coastlineWorld)
data(topoWorld)

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
par(mfrow=c(1,1))
# Example 1
year <- 2020
month <- 8
day <- 9:11
d1 <- read.amsr(download.amsr(year, month, day[1], "~/data/amsr"))
d2 <- read.amsr(download.amsr(year, month, day[2], "~/data/amsr"))
d3 <- read.amsr(download.amsr(year, month, day[3], "~/data/amsr"))
d <- composite(d1, d2, d3)

## North Atlantic, default, with col and with colormap
plot(d, "SST", xlim=c(-80, -10), ylim=c(20,65))
lines(coastlineWorld[['longitude']], coastlineWorld[['latitude']])
contour(topoWorld[["longitude"]], topoWorld[["latitude"]], topoWorld[["z"]],
        levels=-1000, drawlabels=FALSE, lwd=1, add=TRUE)
mtext("default")

plot(d, "SST", col=oceColorsTurbo, xlim=c(-80, -10), ylim=c(20,65))
lines(coastlineWorld[['longitude']], coastlineWorld[['latitude']])
contour(topoWorld[["longitude"]], topoWorld[["latitude"]], topoWorld[["z"]],
        levels=-1000, drawlabels=FALSE, lwd=1, add=TRUE)
mtext("col=oceColorsTurbo")

plot(d, "SST", col=oceColorsJet, xlim=c(-80, -10), ylim=c(20,65))
lines(coastlineWorld[['longitude']], coastlineWorld[['latitude']])
contour(topoWorld[["longitude"]], topoWorld[["latitude"]], topoWorld[["z"]],
        levels=-1000, drawlabels=FALSE, lwd=1, add=TRUE)
mtext("col=oceColorsJet")

## World, default, with col and with colormap
plot(d, "SST")
lines(coastlineWorld[['longitude']], coastlineWorld[['latitude']])
contour(topoWorld[["longitude"]], topoWorld[["latitude"]], topoWorld[["z"]],
        levels=-1000, drawlabels=FALSE, lwd=1, add=TRUE)
mtext("default")

plot(d, "SST", col=oceColorsJet)
lines(coastlineWorld[['longitude']], coastlineWorld[['latitude']])
contour(topoWorld[["longitude"]], topoWorld[["latitude"]], topoWorld[["z"]],
        levels=-1000, drawlabels=FALSE, lwd=1, add=TRUE)
mtext("colormap(..., col=oceColorsJet)")

cm <- colormap(zlim=range(d[["SST"]], na.rm=TRUE), col=oceColorsJet)
plot(d, "SST", colormap=cm)
lines(coastlineWorld[['longitude']], coastlineWorld[['latitude']])
contour(topoWorld[["longitude"]], topoWorld[["latitude"]], topoWorld[["z"]],
        levels=-1000, drawlabels=FALSE, lwd=1, add=TRUE)
mtext("colormap(..., colormap=(USER COMPUTED)")

if (!interactive()) dev.off()
