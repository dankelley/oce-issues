library(oce)
data(topoWorld)
patchx <- 5 > abs(topoWorld[["longitude"]] - (-63))
topoWorld[["z"]][patchx, ] <- NA
##patchy <- 0.25 < abs(topoWorld[["latitude"]] - 43)
##topoWorld[["z"]][, patchy] <- 50e3

data(coastlineWorld)
for (method in 1:3) {
    if (!interactive())
        png(paste0("1284c_method_",method,".png"), type="cairo")
    par(mar=rep(2, 4))
    L <- 4000000
    mapPlot(coastlineWorld, type="l", proj="+proj=ortho +lon_0=-60 +lat_0=40",
            xlim=L*c(-1,1), ylim=L*c(-1,1))
    cm <- colormap(name="gmt_globe")
    cm$missingColor <- "pink" # for fun
    options(mapPolygonMethod=method)
    mapImage(topoWorld, colormap=cm, missingColor="black")
    if (!interactive())
        dev.off()
}
