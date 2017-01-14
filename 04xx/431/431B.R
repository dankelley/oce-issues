## Create R-type breaks from one-to-one value-color mapping
rm(list=ls())
N <- 2 # number of subvisions in palette; set =1 for terraced
if (!interactive()) png("431B.png", width=600, height=500, pointsize=16)
par(mfrow=c(2,2), mar=c(2, 2, 2.5, 1), mgp=c(2, 0.7, 0))
ny <- 100                              # use for fake data
for (n in 2:5) {
    # Create fake data
    y <- seq(0, n+1, length.out=ny)
    centers <- 1:n # avoid word 'breaks', which is different
    lower <- 1:n
    upper <- 1:n # lower and upper need not match (e.g. GMT near coasts)

    ## below is more general, in terms of y, col, and centers.
    ncenters <- length(centers)
    if (length(lower) != ncenters)
        stop("length of lower and centers must match")
    if (length(upper) != ncenters)
        stop("length of upper and centers must match")
    breaks <- centers
    Breaks <- NULL
    Col <- NULL
    for (r in seq.int(1, -1+ncenters)) {
        BreaksNEW <- seq(breaks[r], breaks[r+1], length.out=N+1)
        cat("n=", n,
            "  breaks[", r, "]=", breaks[r],
            "  breaks[", r+1, "]=", breaks[r+1],
            "  upper[", r, "]=", upper[r],
            "  lower[", r+1, "]=", lower[r+1],
            "  range(BreaksNEW)=", paste(range(BreaksNEW), collapse=" to "),
            "\n", sep='')
        Breaks <- c(Breaks, BreaksNEW)
        Col <- c(Col, colorRampPalette(c(lower[r], upper[r+1]))(N+1))
    }
    nBreaks <- length(Breaks)
    ## extend a bit to the right
    delta <- mean(diff(centers[1:2])) / 100
    Breaks <- c(Breaks, Breaks[nBreaks] + delta/100)
    image(x=1, y=y, z=matrix(y, nrow=1),
          col=Col,
          breaks=Breaks,
          ylim=c(-1, 7), xlab="", ylab="")
    rug(breaks, side=4, tick=-0.03, lwd=2, col='magenta')
    rug(y, side=2, tick=-0.03, lwd=2, col='magenta')
    d <- 3/4
    mtext(paste("lower: ", paste(lower, collapse=" "), sep=""),
          line=0, side=3, cex=d, adj=1)
    mtext(paste("upper: ", paste(upper, collapse=" "), sep=""),
          line=d, side=3, cex=0.7, adj=1)
    mtext(paste("breaks: ", paste(breaks, collapse=" "), sep=""),
          line=2*d, side=3, cex=0.7, adj=1)
    mtext(paste("N: ", N, sep=""),
          line=0, side=3, cex=0.7, adj=0)
}

if (!interactive()) dev.off()

