rm(list=ls())
library(oce)
try({
    source('~/src/oce/R/imagep.R')
})


data(adp)
t <- adp[['time']]
d <- adp[['distance']]
spd <- sqrt(adp[['v']][,,1]^2 + adp[['v']][,,2]^2)

if (!interactive()) png('489A.png')

col <- colorRampPalette(c("white", "#ffe45e", "#FF7F00", "red", "#7F0000"))
breaks <- seq(0, 1.5, 0.25)
par(mfrow=c(2,1), mar=c(3, 3, 4, 1))
imagep(t, d, spd, col=col, filledContour = TRUE, breaks=breaks)
oceContour(t, d, spd, levels=breaks[2], add=TRUE)

cm <- colormap(spd, breaks=breaks, col=col)
imagep(t, d, spd, colormap=cm, filledContour = TRUE)
oceContour(t, d, spd, levels=breaks[2], add=TRUE)

mtext("EXPECT: colors in both panels should match; lower is correct", line=1,
      col="purple", font=2, cex=1.2)

if (!interactive()) dev.off()
