library(oce)
library(ocedata)
data('coastlineWorldFine')
if (!interactive()) png("1348a.png")
par(mar=c(3,3,1,1))
mapPlot(coastlineWorldFine, 
        longitudelim = c(-60, -58), 
        latitudelim = c(45.5, 46.5),
        proj = '+proj=merc',
        col = 'grey')
mtext("Expect: lat labels by the grid lines", font=2, col="magenta", side=3)
if (!interactive()) dev.off()

