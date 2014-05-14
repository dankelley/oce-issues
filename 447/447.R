library(oce)
# source('~/src/oce/R/colors.R')
data(adp)
t <- adp[['time']]
p <- adp[['pressure']]
par(mfrow=c(2,1), mar=c(3, 3, 1, 1))
cm <- colormap(p, breaks=seq(39, 40, 0.1), zclip=TRUE)
stopifnot(!any(is.na(cm$zcol)))
drawPalette(colormap=cm)
oce.plot.ts(t, p, type='p', pch=21, cex=1.5, bg=cm$zcol, mar=c(3, 3, 1, 4)) 
abline(h=c(39, 40))

## change the missingColor to pink
cm <- colormap(p, breaks=seq(39, 40, 0.1), zclip=FALSE, missingColor='pink')
drawPalette(colormap=cm)
oce.plot.ts(t, p, type='p', pch=21, cex=1.5, bg=cm$zcol, mar=c(3, 3, 1, 4)) 
abline(h=c(39, 40))
