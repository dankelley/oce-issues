if (!interactive()) png("444c.png", width=5, height=5, unit="in", res=150, pointsize=9)

library(oce)
data(adp)
t <- adp[['time']]
p <- adp[['pressure']]
omar <- par('mar')
par(mfrow=c(2,1))
drawPalette(p, col=oceColorsJet)
oce.plot.ts(t, p, mar=par('mar'))
par(mar=omar)
drawPalette(p, col=oceColorsJet)
plot(t, p)
par(mar=omar)

if (!interactive()) dev.off()

