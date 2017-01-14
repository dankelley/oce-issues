library(oce)
data(coastlineWorld)
if (!interactive()) png("qsc.png")
par(mar=rep(2, 4))
line <- 0.25
pcol <- "blue"
ecol <- "red"
font <- 2

p <- "+proj=qsc +lon_0=-100"
mapPlot(coastlineWorld, projection=p, grid=15, fill='lightgray')
mtext(p, line=line, adj=1, col=pcol, font=font)

if (!interactive()) dev.off()
