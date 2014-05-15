if (!interactive()) pdf("449.pdf")
library(oce)
## source('~/src/oce/R/colors.R')
data(adp)
t <- adp[['time']]
p <- adp[['pressure']]
par(mfcol=c(2,2), mar=c(3, 3, 1, 1))

omar <- par('mar')
cm <- colormap(p, breaks=seq(39, 40, 0.1), debug=3)
stopifnot(!any(is.na(cm$zcol)))
drawPalette(colormap=cm)
plot(t, p, type='p', pch=21, cex=1.5, bg=cm$zcol) 
abline(h=c(39, 40))
mtext("TEST 1 (zclip=FALSE)", side=3)

par(mar=omar)
cm <- colormap(p, zlim=c(39, 40))
stopifnot(!any(is.na(cm$zcol)))
drawPalette(colormap=cm)
plot(t, p, type='p', pch=21, cex=1.5, bg=cm$zcol) 
abline(h=c(39, 40))
mtext("TEST 2 (zclip=FALSE)", side=3)

par(mar=omar)
cm <- colormap(p, breaks=seq(39, 40, 0.1), zclip=TRUE, debug=3)
stopifnot(!any(is.na(cm$zcol)))
drawPalette(colormap=cm)
plot(t, p, type='p', pch=21, cex=1.5, bg=cm$zcol) 
abline(h=c(39, 40))
mtext("TEST 3 (zclip=TRUE)", side=3)

par(mar=omar)
cm <- colormap(p, zlim=c(39, 40), zclip=TRUE, debug=3, missingColor='pink')
stopifnot(!any(is.na(cm$zcol)))
drawPalette(colormap=cm)
plot(t, p, type='p', pch=21, cex=1.5, bg=cm$zcol) 
abline(h=c(39, 40))
mtext("TEST 4 (zclip=TRUE)", side=3)

if (!interactive()) dev.off()

