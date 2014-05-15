## original posting at https://github.com/dankelley/oce/issues/444
if (!interactive()) png("444.png", width=5, height=5, unit="in", res=150, pointsize=9)
library(oce)
data(adp)
t <- adp[['time']]
p <- adp[['pressure']]
drawPalette(p, col=oceColorsJet)
oce.plot.ts(t, p, mai.palette=c(0, 0, 0, 0.5))

if (!interactive()) dev.off()

