rm(list=ls())
library(oce)
try({
    source('~/src/oce/R/imagep.R')
})


data(adp)
t <- adp[['time']]
d <- adp[['distance']]
spd <- sqrt(adp[['v']][,,1]^2 + adp[['v']][,,2]^2)
spd[10:40, 1:30] <- 0
spd[10:40, 60:84] <- 1.1

if (!interactive()) png('489A.png')

par(mfrow=c(2,1), mar=c(3, 3, 5, 1))

col <- colorRampPalette(c("white", "#ffe45e", "#FF7F00", "red", "#7F0000"))
breaks <- seq(0, 1.5, 0.2)
cm <- colormap(spd, breaks=breaks, col=col)
imagep(t, d, spd, colormap=cm, filledContour=TRUE,
       mar=c(2, 2, 2, 0.5), drawTimeRange=FALSE)
oceContour(t, d, spd, levels=breaks[2], add=TRUE)
mtext("EXPECT: v=0 box at bottom, v=1 at top", adj=0, col="purple", font=2)
mtext("(a) ", adj=1)

imagep(t, d, spd, col=col, filledContour=TRUE, breaks=breaks,
       mar=c(2, 2, 2, 0.5), drawTimeRange=FALSE, debug=4)
oceContour(t, d, spd, levels=breaks[2], add=TRUE)
mtext("EXPECT: as (a)", adj=0, col="purple", font=2)
mtext("(b) ", adj=1)

if (!interactive()) dev.off()
