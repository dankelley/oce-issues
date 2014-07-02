if (!interactive()) png("475c.png")
library(oce)
data(ctd)
ctd[['latitude']] <- 80
ctd[['longitude']] <- 0
try({
    source('~/src/oce/R/ctd.R')
    source('~/src/oce/R/coastline.R')
    source('~/src/oce/R/map.R')
})
plot(ctd, lonlab=seq(-15, 15, 15), latlab=75, span=2000, sides=c(1,2,4))
if (!interactive()) dev.off()

