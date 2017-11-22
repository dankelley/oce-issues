library(oce)
data(coastlineWorld)

## generate a vector for a grid of points on the Earth
lo <- seq(-180, 180, 1)
la <- seq(-90, 90, 1)
lon <- expand.grid(lo, la)[,1]
lat <- expand.grid(lo, la)[,2]

SA <- array(gsw_SA_from_SP(rep(35, length(lon)),
                           rep(100, length(lon)), lon, lat),
            dim=c(length(lo), length(la)))

if (!interactive()) png('1340a_%d.png', width=5.5, height=3, unit="in", res=150, type='cairo')

par(mar=c(2, 2, 4, 1))


for (mc in c(NA, "lightgray")) {
    for (proj in c("+proj=moll", "+proj=lonlat")) {

        mapPlot(coastlineWorld, projection=proj)
        mapImage(lo, la, SA, missingColor=mc)
        mtext("(lo, la, SA, missingColor=mc)", side=3)
        mapLines(coastlineWorld, col='gray')
        mtext(proj, side=3, line=2)
        mtext(paste("mc=", mc), side=3, line=3)

        mapPlot(coastlineWorld, projection=proj)
        mapImage(lo, la, SA, missingColor=mc, col=oceColorsJet)
        mtext("(lo, la, SA, missingColor=mc, col=oceColorsJet)", side=3)
        mapLines(coastlineWorld, col='gray')
        mtext(proj, side=3, line=2)
        mtext(paste("mc=", mc), side=3, line=3)

        mapPlot(coastlineWorld, projection=proj)
        mapImage(lo, la, SA, missingColor=mc, col=oceColorsJet)
        mtext("(lo, la, SA, missingColor=mc, col=oceColorsJet)", side=3)
        mapLines(coastlineWorld, col='gray')
        mtext(proj, side=3, line=2)
        mtext(paste("mc=", mc), side=3, line=3)

        mapPlot(coastlineWorld, projection=proj)
        mapImage(lo, la, SA, missingColor=mc, breaks=128, col=oceColorsJet)
        mtext("(lo, la, SA, missingColor=mc, breaks=128, col=oceColorsJet)", side=3)
        mapLines(coastlineWorld, col='gray')
        mtext(proj, side=3, line=2)
        mtext(paste("mc=", mc), side=3, line=3)

    }
}

if (!interactive()) dev.off()
