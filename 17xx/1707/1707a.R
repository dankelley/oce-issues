library(oce)
data("coastlineWorld")
proj <- "+proj=merc"
lonlim <- c(-20, 20)
latlim <- c(-20, 20)
if (!interactive()) png("1707a.png")
par(mfrow=c(2, 2), mar=c(2,2,1,1))
for (axisStyle in 1:4) {
    mapPlot(coastlineWorld, longitudelim=lonlim, latitudelim=latlim,
            col="tan", proj=proj, axisStyle=axisStyle, grid=c(5,5))
    mtext(paste0("axisStyle=", axisStyle), cex=par("cex"))
}
if (!interactive()) dev.off()

