rm(list=ls())
library(oce)
#try({
    source('~/src/oce/R/imagep.R')
#})


data(adp)
t <- adp[['time']]
d <- adp[['distance']]
spd <- sqrt(adp[['v']][,,1]^2 + adp[['v']][,,2]^2)

if (!interactive()) png('489A.png')

col <- colorRampPalette(c("white", "#ffe45e", "#FF7F00", "red", "#7F0000"))
breaks <- seq(0, 1.5, 0.25)
par(mfrow=c(2,1))
imagep(t, d, spd, col=col, filledContour = TRUE, breaks=breaks, debug =1)
oceContour(t, d, spd, levels=breaks[2], add=TRUE)

cm <- colormap(spd, breaks=breaks, col=col)
imagep(t, d, spd, colormap=cm, filledContour = TRUE, debug =1)
oceContour(t, d, spd, levels=breaks[2], add=TRUE)

if (!interactive()) dev.off()
