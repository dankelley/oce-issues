library(oce)
data(coastlineWorld)
if (!interactive()) png("774b.png", width=7, height=5, unit="in", res=100, pointsize=10)
par(mfrow=c(4,2), mar=c(0.5, 0.5, 1, 0.5))

cex <- 0.8

## NEW MODE
mapPlot(coastlineWorld)
mtext("1. EXPECT: gray fill, black border", side=3, font=2, col='magenta', adj=0, cex=cex)

mapPlot(coastlineWorld, col=NULL)
mtext("2. EXPECT: no fill, black borders", side=3, font=2, col='magenta', adj=0, cex=cex)

mapPlot(coastlineWorld, border='blue')
mtext("3. EXPECT: no fill, blue borders", side=3, font=2, col='magenta', adj=0, cex=cex)

mapPlot(coastlineWorld, col='pink')
mtext("4. EXPECT: pink fill, black borders", side=3, font=2, col='magenta', adj=0, cex=cex)


## COMPATIBILITY MODE
mapPlot(coastlineWorld, fill=TRUE)
mtext("5. EXPECT: gray fill, black border", side=3, font=2, col='magenta', adj=0, cex=cex)

mapPlot(coastlineWorld, fill=FALSE)
mtext("6. EXPECT: no fill, black border", side=3, font=2, col='magenta', adj=0, cex=cex)

mapPlot(coastlineWorld, fill='pink')
mtext("7. EXPECT: pink fill, black border", side=3, font=2, col='magenta', adj=0, cex=cex)

mapPlot(coastlineWorld, fill=TRUE, col='pink')
mtext("8. EXPECT: pink fill, black border", side=3, font=2, col='magenta', adj=0, cex=cex)


if (!interactive()) dev.off()
