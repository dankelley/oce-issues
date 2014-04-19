## Create R-type breaks from one-to-one value-color mapping
rm(list=ls())
sublevels <- 50                        # need several to show breaks
if (!interactive()) png("431A.png", width=600, height=500, pointsize=16)
par(mfrow=c(2,2), mar=c(2, 2, 2.5, 1), mgp=c(2, 0.7, 0))
for (n in 2:5) {
    y <- seq(0, n+1, length.out=sublevels)
    breaks <- 1:n
    col <- 1:n
    dbreak <- diff(breaks[1:2])
    breaks2 <- dbreak/2 + c(breaks[1]-dbreak, breaks)
    image(x=1, y=y, z=matrix(y, nrow=1), col=col, breaks=breaks2,
          ylim=c(-1, 7), xlab="", ylab="")
    rug(breaks, side=4, tick=-0.03, lwd=2, col='magenta')
    rug(y, side=2, tick=-0.03, lwd=2, col='magenta')
    mtext(paste("col: ", paste(col, collapse=" "), sep=""),
          line=0, side=3, cex=0.7, adj=1)
    mtext(paste("breaks: ", paste(breaks, collapse=" "), sep=""),
          line=3/4, side=3, cex=0.7, adj=1)
    mtext(paste("breaks2: ", paste(breaks2, collapse=" "), sep=""),
          line=3/2, side=3, cex=0.7, adj=1)
}

if (!interactive()) dev.off()

