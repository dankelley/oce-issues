library(oce)
data(topoWorld)

## colormapGMT works from elements of GMT list as returend from colormap()
colormapGMT <- function(x0, x1, col0, col1, breaksPerLevel=1)
{
    n <- length(x0)
    if (length(x1) != n) stop("mismatched lengths of x0 and x1 (", n, " and ", length(x1), ")")
    if (length(col0) != n) stop("mismatched lengths of x0 and col0 (", n, " and ", length(col0), ")")
    if (length(col1) != n) stop("mismatched lengths of x0 and col1 (", n, " and ", length(col1), ")")
    breaks <- NULL
    col <- NULL
    ## Could preallocate but colormaps are small so do not bother
    for (i in seq.int(1, n-1)) {
        breaks <- c(breaks, seq(x0[i], x1[i], length.out=1+breaksPerLevel))
        col <- c(col, colorRampPalette(c(col0[i], col1[i]))(1+breaksPerLevel))
    }
    nbreaks <- length(breaks)
    ## extend a bit to the right
    delta <- mean(diff(breaks[1:2])) / 1000
    breaks <- c(breaks, breaks[nbreaks] + delta)
    rval <- list(breaks=breaks, col=col)
    rval
}
cm <- oce:::colormap(file='http://www.beamreach.org/maps/gmt/share/cpt/GMT_globe.cpt')
bc <- colormapGMT(cm$l, cm$u, rgb(cm$lr, cm$lg, cm$lb, max=255), rgb(cm$ur, cm$ug, cm$ub, max=255))

if (!interactive()) png("431C.png")
par(mar=c(3, 3, 1, 1))
imagep(topoWorld, breaks=bc$breaks, col=bc$col)
if (!interactive()) dev.off()

