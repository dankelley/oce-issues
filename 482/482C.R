if (!interactive()) png("482C.png")
library(oce)
try({
    source('~/src/oce/R/landsat.R')
})
system.time(l <- read.landsat("~/Downloads/LC80150282014178LGN00", band="panchromatic"))
plot(l, col=oceColorsJet)
mtext(l[["time"]])
if (!interactive()) dev.off()
