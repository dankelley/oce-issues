## Test new functionality for issue 1625
library(oce)
data(coastlineWorld)

source("~/git/oce/R/map.R")

col <- "lightgray"
lonlim <- c(-20, 20)
latlim <- c(20, 50)
proj <- "+proj=lcc +lat_1=30 +lat_2=40"
debug <- TRUE
for (geographical in 0:4) {
    if (!interactive()) png(paste0("1625b_", geographical, ".png"))
    par(mfrow=c(2, 2), mar=c(3,3,2,1))
    mapPlot(coastlineWorld, col=col, geographical=geographical,
            longitudelim=lonlim, latitudelim=latlim, projection=proj, debug=debug)
    mtext("Expect ticks & labels on bottom & left", cex=par("cex"))

    mapPlot(coastlineWorld, col=col, geographical=geographical,
            longitudelim=lonlim, latitudelim=latlim, projection=proj,
            lonlabels=c(-5,5), debug=debug)
    mtext("Expect tick & label at 5W and 5E", cex=par("cex"))

    mapPlot(coastlineWorld, ,col=col, geographical=geographical,
            longitudelim=lonlim, latitudelim=latlim, projection=proj,
            lonlabels=FALSE, debug=debug)
    mtext("Expect ticks but no numbers at bottom", cex=par("cex"))

    mapPlot(coastlineWorld, col=col, geographical=geographical,
            longitudelim=lonlim, latitudelim=latlim, projection=proj,
            lonlabels=NULL, debug=debug)
    mtext("Expect no ticks or numbers at bottom", cex=par("cex"))
    if (!interactive()) dev.off()
}


