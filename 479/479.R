if (!interactive()) png("479.png")
library(oce)
try({
    source('~/src/oce/R/imagep.R')
})
data(adp)
par(mfrow=c(2,1))
imagep(adp[['v']][,,1])
imagep(adp[['v']][,,1], drawPalette='space')
if (!interactive()) dev.off()

