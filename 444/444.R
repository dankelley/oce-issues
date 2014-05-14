library(oce)
data(adp)
t <- adp[['time']]
p <- adp[['pressure']]
#source('~/src/oce/R/oce.R')
#source('~/src/oce/R/imagep.R')
omar <- par('mar')
par(mfrow=c(2,1))
drawPalette(p, col=oceColorsJet)
oce.plot.ts(t, p, mar=par('mar'))
par(mar=omar)
drawPalette(p, col=oceColorsJet)
plot(t, p)
par(mar=omar)
