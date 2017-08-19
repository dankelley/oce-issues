library(oce)
data(topoWorld)
data(coastlineWorld)
for (method in 1:3) {
    if (!interactive())
        png(paste0("1284b_method_",method,"_globe.png"), type="cairo")
    par(mar=rep(2, 4))
    mapPlot(coastlineWorld, type="l", proj="+proj=ortho +lon_0=-60 +lat_0=40")
    cm <- colormap(name="gmt_globe")
    options(mapPolygonMethod=method)
    print(system.time({
        mapImage(topoWorld, colormap=cm)
    }))
    if (!interactive())
        dev.off()
}
