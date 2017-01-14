## Test that mid-latitude plotted and actual spans agree to 10%
errorPermitted <- 5 # percent error in corner-to-corner span
library(testthat)
library(oce)
source("~/src/oce/R/ctd.R")
data(ctd)
if (!interactive()) png("677a.png")
par(mfrow=c(2,2))
for (span in c(10, 50, 100, 500)) {
    plot(ctd, which="map", span=span)
    usr <- par('usr')
    spanPlotted <- geodDist(usr[1], usr[3], usr[2], usr[4])
    mtext(sprintf(" diag span %.0fkm (%.0f%% error)", spanPlotted, 100*abs(span-spanPlotted)/span),
          col='magenta', font=2, cex=3/4, side=3, line=1/4, adj=0)
    expect_less_than(abs(span-spanPlotted)/span, errorPermitted)
}
if (!interactive()) dev.off()


