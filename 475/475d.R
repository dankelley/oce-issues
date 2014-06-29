if (!interactive()) png("475d.png")
library(oce)
data(ctd)
ctd[['latitude']] <- 80
ctd[['longitude']] <- 0
try({
    source('~/src/oce/R/ctd.R')
    source('~/src/oce/R/coastline.R')
    source('~/src/oce/R/map.R')
})
plot(ctd, which='map', lonlab=seq(-90,90,30), latlab=c(60,75), span=2000, sides=c(1,2,4))
if (!interactive()) dev.off()

