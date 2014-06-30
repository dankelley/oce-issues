if (!interactive()) png("477a.png")
library(oce)
data(ctd)
ctd[['latitude']] <- 80
ctd[['longitude']] <- 0
try({
    source('~/src/oce/R/ctd.R')
    source('~/src/oce/R/coastline.R')
    source('~/src/oce/R/map.R')
})
plot(ctd, which='map', span=2000)
if (!interactive()) dev.off()

