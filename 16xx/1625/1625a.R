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
    if (!interactive()) png(paste0("1625a_", geographical, ".png"))
    cex <- 0.85 * par("cex")
    par(mfrow=c(2, 2), mar=c(3,3,2,1))
    mapPlot(coastlineWorld, col=col, geographical=geographical,
            longitudelim=lonlim, latitudelim=latlim, projection=proj, debug=debug)
    mtext("a) default: expect ticks & labels", cex=cex)
    mtext(paste0("geographical=", geographical, ": examine LEFT axis"), side=3, line=1.2, col=2, font=2, cex=cex)

    mapPlot(coastlineWorld, col=col, geographical=geographical,
            longitudelim=lonlim, latitudelim=latlim, projection=proj,
            latlabels=c(25, 35))
    mtext("b) latlabels=#: expect ticks & labels at 25N,30N", cex=cex)

    mapPlot(coastlineWorld, ,col=col, geographical=geographical,
            longitudelim=lonlim, latitudelim=latlim, projection=proj,
            latlabels=FALSE)
    mtext("c) latlabels=FALSE: expect ticks without labels", cex=cex)

    mapPlot(coastlineWorld, col=col, geographical=geographical,
            longitudelim=lonlim, latitudelim=latlim, projection=proj,
            latlabels=NULL)
    mtext("d) latlabels=NULL: expect no ticks or labels", cex=cex)
    if (!interactive()) dev.off()
}

