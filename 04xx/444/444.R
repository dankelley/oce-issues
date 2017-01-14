## original posting at https://github.com/dankelley/oce/issues/444
if (!interactive()) png("444.png", width=5, height=5, unit="in", res=150, pointsize=9)
library(oce)
data(adp)
t <- adp[['time']]
p <- adp[['pressure']]
drawPalette(p, col=oceColorsJet)
## The next line used to have arg mai.palette=c(0, 0, 0, 0.5) but
## that is no longer used with oce.plot.ts(), after changes arising
## frm code simplification, as discussed at
##     https://github.com/dankelley/oce/issues/444
oce.plot.ts(t, p)

if (!interactive()) dev.off()

