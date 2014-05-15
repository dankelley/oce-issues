if (!interactive()) png("444d.png", width=5, height=5, unit="in", res=150, pointsize=9)

library(oce)
data(adp)
t <- adp[['time']]
p <- adp[['pressure']]
u <- adp[['v']][,,1]

## set the desired mar manually
omar <- c(3, 3, 1, 1)
par(mar=omar, mfrow=c(2,1))
## draw the palette
drawPalette(p, col=oceColorsJet)
## use the mar returned after the drawPalette call to set mar within oce.plot.ts
oce.plot.ts(t, p, mar=par('mar'))
oce.plot.ts(t, p, type='p', mar=par('mar'))

if (!interactive()) dev.off()

