library(oce)
# try(source("~/src/oce/R/map.R"))       # lets author test changes to the code
# try(source("~/src/oce/R/landsat.R"))   # lets author test changes to the code
if (1 == length(list.files(pattern="^LC.*$"))) {
    low <- list(longitude=-39.5, latitude=-4.5)
    up <- list(longitude=-39, latitude=-4)
    if (1 != length(ls(pattern="^ns$"))) { # buffer for speed of interactive testing
        ns <- read.landsat("LC82170632015124LGN00", band="tirs1")
    }
    trim <- landsatTrim(ns, low, up)
    if (!interactive()) png("675.png", width=7, height=3, unit="in", res=100, pointsize=9)
    par(mfrow=c(1,2))
    plot(ns, band="temperature", col=oceColorsJet)
    abline(h=c(up$latitude, low$latitude))
    abline(v=c(up$longitude, low$longitude))
    plot(trim, band="temperature", col=oceColorsJet)
    if (!interactive()) dev.off()
} else {
    message("675.R needs a directory named LC82170632015124LGN00")
}
