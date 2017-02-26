library(oce)
data(adp)
if (!interactive()) png("542.png", pointsize=12)
par(mfrow=c(2,2))

## options(oceDebug=1)

imagep(adp[['v']][,,1], breaks=seq(-0.5, 0.5, 0.1), zclip=FALSE)
mtext('EXPECT a: out-of-range coloured', adj=0, font=2, col="purple", cex=3/4)
imagep(adp[['v']][,,1], breaks=seq(-0.5, 0.5, 0.1), zclip=FALSE, drawPalette=FALSE)
mtext('EXPECT b: as (a) with no palette', adj=0, font=2, col="purple", cex=3/4)

imagep(adp[['v']][,,1], breaks=seq(-0.5, 0.5, 0.1), zclip=TRUE)
mtext('EXPECT c: out-of-range white', adj=0, font=2, col="purple", cex=3/4)
imagep(adp[['v']][,,1], breaks=seq(-0.5, 0.5, 0.1), zclip=TRUE, drawPalette=FALSE)
mtext('EXPECT d: as (a) with no palette', adj=0, font=2, col="purple", cex=3/4)

if (!interactive()) dev.off()

