library(oce)
data(coastlineWorld)
data(topoWorld)
if (!interactive()) png("721a_%d.png")
mapPlot(coastlineWorld, proj='+proj=stere +lat_0=-90', longitudelim=c(-180, 180), latitudelim=c(-90, -50))
mapImage(topoWorld, colormap=colormap(name='gmt_relief'))
mapImage(topoWorld, colormap=colormap(name='gmt_relief'), filledContour=TRUE)
if (!interactive()) dev.off()

