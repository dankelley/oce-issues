library(oce)
source('~/src/oce/R/colors.R')
data(adp)
t <- adp[['time']]
p <- adp[['pressure']]
par(mfrow=c(2,1))
cm <- colormap(p, breaks=seq(39, 40, 0.1), zclip=TRUE)
drawPalette(colormap=cm)
oce.plot.ts(t, p, type='p', pch=21, bg=cm$zcol, mar=c(3, 3, 1, 4)) 
## note the white circles above the breaks

## change the missingColor to pink
cm <- colormap(p, breaks=seq(39, 40, 0.1), zclip=TRUE, missingColor='pink')
drawPalette(colormap=cm)
oce.plot.ts(t, p, type='p', pch=21, bg=cm$zcol, mar=c(3, 3, 1, 4)) 
