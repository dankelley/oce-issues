library(oce)
data(topoWorld)
data(coastlineWorld)
for (method in 1:3) {
    if (!interactive())
        png(paste0("1284a_method_",method,".png"), type="cairo")
    par(mar=rep(2, 4))
    L <- 3000000
    mapPlot(coastlineWorld, type="l", proj="+proj=ortho +lon_0=-60 +lat_0=40",
            xlim=L*c(-1,1), ylim=L*c(-1,1))
    cm <- colormap(name="gmt_globe")
    options(mapPolygonMethod=method)
    mapImage(topoWorld, colormap=cm)
    if (!interactive())
        dev.off()
}
