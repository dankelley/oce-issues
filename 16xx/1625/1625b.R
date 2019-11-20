## Test new functionality for issue 1625
library(oce)
data(coastlineWorld)

if (!interactive()) png("1625b.png")
par(mfrow=c(2, 2))
par(mar=c(3,3,2,1))
col <- "lightgray"
lonlim <- c(-20, 20)
latlim <- c(20, 50)
proj <- "+proj=lcc +lat_1=30 +lat_2=40"

mapPlot(coastlineWorld, col=col,
        longitudelim=lonlim, latitudelim=latlim, projection=proj)
mtext("Expect ticks & labels on bottom & left", pch=0.4)

mapPlot(coastlineWorld, col=col,
        longitudelim=lonlim, latitudelim=latlim, projection=proj,
        lonlabels=c(-5,5))
mtext("Expect tick & label at 5W and 5E", pch=0.4)

mapPlot(coastlineWorld, ,col=col,
        longitudelim=lonlim, latitudelim=latlim, projection=proj,
        lonlabels=FALSE)
mtext("Expect ticks but no numbers at bottom", pch=0.4)

mapPlot(coastlineWorld, col=col,
        longitudelim=lonlim, latitudelim=latlim, projection=proj,
        lonlabels=NULL)
mtext("Expect no ticks or numbers at bottom", pch=0.4)

if (!interactive()) dev.off()

