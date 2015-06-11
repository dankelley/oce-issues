library(oce)
data(coastlineWorldFine, package="ocedata")
proj <- "mercator"
fill <- 'lightgray'
latlim <- c(43,54)
lonlim <- c(-67,-50)
if (!interactive()) png("663a.png", pointsize=11)
par(mar=c(2,2,1,1), mfrow=c(2,1))
mapPlot(coastlineWorldFine,latitudelim=latlim, longitudelim=lonlim,
        proj="mercator", fill=fill, grid=c(2,2))
mapPlot(coastlineWorldFine,latitudelim=latlim, longitudelim=lonlim,
        proj="+proj=merc", fill=fill, grid=c(2,2))
if (!interactive()) dev.off()
