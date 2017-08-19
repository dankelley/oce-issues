library(oce)
data(topoWorld)
patchx <- 2 > abs(topoWorld[["longitude"]] - (-55))
topoWorld[["z"]][patchx, ] <- -100e3
patchx <- 2 > abs(topoWorld[["longitude"]] - (-65))
topoWorld[["z"]][patchx, ] <- 100e3
##patchy <- 0.25 < abs(topoWorld[["latitude"]] - 43)
##topoWorld[["z"]][, patchy] <- 50e3

data(coastlineWorld)
cm <- colormap(name="gmt_globe")
for (method in 1:3) {
    par(mar=rep(1,4))
    drawPalette(colormap=cm)
    if (!interactive())
        png(paste0("1284d_method_",method,".png"), type="cairo")
    par(mar=rep(2, 4))
    L <- 4000000
    mapPlot(coastlineWorld, type="l", proj="+proj=ortho +lon_0=-60 +lat_0=40",
            xlim=L*c(-1,1), ylim=L*c(-1,1))
    cm$missingColor <- "pink" # for fun
    options(mapPolygonMethod=method)
    mapImage(topoWorld, colormap=cm, missingColor="black")
    if (!interactive())
        dev.off()
}
