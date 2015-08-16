library(oce)
source("~/src/oce/R/ctd.R")
data(ctd)
if (!interactive()) png("677.png")
par(mfrow=c(2,2))
for (span in c(10, 50, 100, 500)) {
    plot(ctd, which="map", span=span)
    usr <- par('usr')
    spanPlotted <- geodDist(usr[1], usr[3], usr[2], usr[4])
    mtext(sprintf(" span=%.0fkm (given %.0fkm)", spanPlotted, span),
          col='magenta', font=2, cex=3/4, side=3, line=1/4)
}
if (!interactive()) dev.off()


