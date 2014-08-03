rm(list=ls())
if (!interactive()) png("516A.png", width=700, height=700, pointsize=11, type="cairo", antialias="none")
library(oce)
try({
    source("~/src/oce/R/imagep.R")
})
library(oce)
data(adp)
par(mfrow=c(2,2))
zlim <- c(-0.5, 0.5)
breaks <- seq(-1, 1, 0.2)
u <- adp[['v']][,,1]

imagep(u, zlim=zlim, zclip=TRUE, missingColor='gray')
contour(1:dim(u)[1], 1:dim(u)[2], z=u, levels=0.5, lwd=4, col='yellow', add=TRUE)
contour(1:dim(u)[1], 1:dim(u)[2], z=u, levels=-0.5, lwd=4, col='yellow', add=TRUE)
mtext(paste('EXPECT: gray below -0.5 and above 0.5'), col=6, font=2, adj=0)
mtext("(a) ", line=0.3, adj=1)

imagep(u, zlim=zlim, zclip=FALSE, missingColor='gray')
contour(1:dim(u)[1], 1:dim(u)[2], z=u, levels=0.5, lwd=4, col='yellow', add=TRUE)
contour(1:dim(u)[1], 1:dim(u)[2], z=u, levels=-0.5, lwd=4, col='yellow', add=TRUE)
mtext(paste('EXPECT: solid blue below -0.5, red above 0.5'), col=6, font=2, adj=0)
mtext("(b) ", line=0.3, adj=1)

## Next two aren't clipped because zlim not provided
imagep(u, breaks=breaks, zclip=TRUE, missingColor='gray')
contour(1:dim(u)[1], 1:dim(u)[2], z=u, levels=0.5, lwd=4, col='yellow', add=TRUE)
contour(1:dim(u)[1], 1:dim(u)[2], z=u, levels=-0.5, lwd=4, col='yellow', add=TRUE)
mtext(paste('EXPECT: varying blue below -0.5, red above 0.5'), col=6, font=2, adj=0)
mtext("(c) ", line=0.3, adj=1)

imagep(u, breaks=breaks, zclip=FALSE, missingColor='gray')
contour(1:dim(u)[1], 1:dim(u)[2], z=u, levels=0.5, lwd=4, col='yellow', add=TRUE)
contour(1:dim(u)[1], 1:dim(u)[2], z=u, levels=-0.5, lwd=4, col='yellow', add=TRUE)
mtext(paste('EXPECT: same as (c)'), col=6, font=2, adj=0)
mtext("(d) ", line=0.3, adj=1)


if (!interactive()) dev.off()

