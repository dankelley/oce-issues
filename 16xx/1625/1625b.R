## Test new functionality for issue 1625
library(oce)
data(coastlineWorld)

## source("~/git/oce/R/map.R")

col <- "lightgray"
lonlim <- c(-20, 20)
latlim <- c(20, 50)
proj <- "+proj=lcc +lat_1=30 +lat_2=40"
debug <- 0
for (geographical in 0:4) {
    if (!interactive()) png(paste0("1625b_", geographical, ".png"))
    cex <- 0.85 * par("cex")
    par(mfrow=c(2, 2), mar=c(3,3,2,1))
    mapPlot(coastlineWorld, col=col, geographical=geographical,
            longitudelim=lonlim, latitudelim=latlim, projection=proj, debug=debug)
    mtext("a) default: expect ticks & labels", cex=par("cex"))
    mtext(paste0("geographical=", geographical, ": examine BOTTOM axis"), side=3, line=1.2, col=2, font=2, cex=cex)

    mapPlot(coastlineWorld, col=col, geographical=geographical,
            longitudelim=lonlim, latitudelim=latlim, projection=proj,
            lonlabels=c(-5,5), debug=debug)
    mtext("b) lonlabels=#: expect ticks & labels at 5W and 5E", cex=cex)

    mapPlot(coastlineWorld, ,col=col, geographical=geographical,
            longitudelim=lonlim, latitudelim=latlim, projection=proj,
            lonlabels=FALSE, debug=debug)
    mtext("c) lonlabels=FALSE: expect ticks but no labels", cex=cex)

    mapPlot(coastlineWorld, col=col, geographical=geographical,
            longitudelim=lonlim, latitudelim=latlim, projection=proj,
            lonlabels=NULL, debug=debug)
    mtext("d) lonlabels=NULL: expect no ticks or labels", cex=cex)
    if (!interactive()) dev.off()
}

