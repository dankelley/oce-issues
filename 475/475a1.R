if (!interactive()) png("475a1.png")
library(oce)
try({
    source('~/src/oce/R/ctd.R')
    source('~/src/oce/R/coastline.R')
    source('~/src/oce/R/map.R')
})
data(ctd)
##plot(ctd)
plot(ctd, which='map', span=2000, debug=3)
mapPoints(-60, 45)
mapScalebar("topleft", length=500)
if (!interactive()) dev.off()

