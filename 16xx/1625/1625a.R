## Test new functionality for issue 1625
library(oce)
data(coastlineWorld)

## source("~/git/oce/R/map.R")

if (!interactive()) png("1625a.png")
par(mfrow=c(2, 2), mar=c(3,3,2,1))
col <- "lightgray"
lonlim <- c(-20, 20)
latlim <- c(20, 50)
proj <- "+proj=lcc +lat_1=30 +lat_2=40"

mapPlot(coastlineWorld, col=col,
        longitudelim=lonlim, latitudelim=latlim, projection=proj)
mtext("Expect ticks & labels on bottom & left", pch=0.4)

mapPlot(coastlineWorld, col=col,
        longitudelim=lonlim, latitudelim=latlim, projection=proj,
        latlabels=c(25, 35))
mtext("Expect tick & label at 25N and 30N", pch=0.4)

mapPlot(coastlineWorld, ,col=col,
        longitudelim=lonlim, latitudelim=latlim, projection=proj,
        latlabels=FALSE)
mtext("Expect ticks but no numbers at left", pch=0.4)

mapPlot(coastlineWorld, col=col,
        longitudelim=lonlim, latitudelim=latlim, projection=proj,
        latlabels=NULL)
mtext("Expect no ticks or numbers at left", pch=0.4)

if (!interactive()) dev.off()

