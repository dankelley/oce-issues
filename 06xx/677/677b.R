## Test that high-latitude plotted and actual spans agree to 10%
errorPermitted <- 5 # percent error in corner-to-corner span
library(testthat)
library(oce)
data(ctd)
## Move CTD profile to Barrow Strait
ctd[["longitude"]] <- -92
ctd[["latitude"]] <- 74.5
if (!interactive()) png("677b.png")
par(mfrow=c(2,2))
for (span in c(50, 100, 500, 1000)) {
    plot(ctd, which="map", span=span)
    usr <- par('usr')
    spanPlotted <- geodDist(usr[1], usr[3], usr[2], usr[4])
    mtext(sprintf(" diag span %.0fkm (%.0f%% error)", spanPlotted, 100*abs(span-spanPlotted)/span),
          col='magenta', font=2, cex=3/4, side=3, line=1/4, adj=0)
    expect_less_than(abs(span-spanPlotted)/span, errorPermitted)
}
if (!interactive()) dev.off()


