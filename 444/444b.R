if (!interactive()) png("444b.png", width=5, height=5, unit="in", res=150, pointsize=9)

library(oce)
data(adp)
t <- adp[['time']]
p <- adp[['pressure']]
# ORIG oce.plot.ts(t, p, mai.palette=c(0, 0, 0, 0.5))
par(mfrow=c(2,1))
omar <- par('mar')
drawPalette(p, col=oceColorsJet)
plot(t, p)

par(mar=omar)
drawPalette(p, col=oceColorsJet)
## The next line used to have arg mai.palette=c(0, 0, 0, 0.5) but
## that is no longer used with oce.plot.ts(), after changes arising
## frm code simplification, as discussed at
##     https://github.com/dankelley/oce/issues/444
oce.plot.ts(t, p, marginsAsImage=TRUE)

if (!interactive()) dev.off()

