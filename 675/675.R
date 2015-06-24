library(oce)
try(source("~/src/oce/R/map.R"))       # lets author test changes to the code
try(source("~/src/oce/R/landsat.R"))   # lets author test changes to the code

if (1 == length(list.files(pattern="^LC.*$"))) {
    low <- list(longitude=-39.5, latitude=-4.5)
    up <- list(longitude=-39, latitude=-4)
    if (1 != length(ls(pattern="^ns$"))) { # buffer for speed of interactive testing
        ns <- read.landsat("LC82170632015124LGN00", band="tirs1")
    }
    trim <- landsatTrim(ns, low, up, debug=3)
    if (!interactive()) png("675.png")
    plot(trim)
    if (!interactive()) dev.off()
} else {
    message("675.R needs a directory named LC82170632015124LGN00")
}
