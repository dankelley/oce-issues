if (!interactive()) pdf("447b.pdf")
library(oce)
data(adp)
t <- adp[['time']]
p <- adp[['pressure']]
par(mfrow=c(2,1), mar=c(3, 3, 1, 1))
## pink missingColor
cm <- colormap(p, breaks=seq(39, 40, 0.1), zclip=FALSE, missingColor='pink')
stopifnot(!any(is.na(cm$zcol)))
drawPalette(colormap=cm)
oce.plot.ts(t, p, type='p', pch=21, cex=1.5, bg=cm$zcol, mar=c(3, 3, 1, 4)) 
abline(h=c(39, 40))

## default (gray) missingColor
cm <- colormap(p, breaks=seq(39, 40, 0.1), zclip=FALSE)
drawPalette(colormap=cm)
oce.plot.ts(t, p, type='p', pch=21, cex=1.5, bg=cm$zcol, mar=c(3, 3, 1, 4)) 
abline(h=c(39, 40))
if (!interactive()) dev.off()

