message("note 1: function name is poor (any advice?)")
message("note 2: true function could be called within drawPalette")
message("note 3:  latter should return also the orig par value")
library(oce)

calculatePalette <- function(z, breaks=pretty(z, n=20), colors=oceColorsJet)
{
    if (missing(z))
        stop("must supply z")
    col <- oceColorsJet(length(breaks) - 1)
    list(zlim=range(z, na.rm=TRUE),
         breaks=breaks, col=col, zcol=col[findInterval(z, breaks)])
}
omar <- par('mar')
x <- seq(0,  2*pi,  length.out=120)
y <- sin(x)
pc <- calculatePalette(y)
drawPalette(pc$zlim,  col=pc$col,  breaks=pc$breaks)
plot(x, y, pch=21, bg=pc$zcol, cex=1)

## some checks
abline(h=0.3) # yellow-orange transition
abline(h=-0.3) # turquoise-blue transition

par(mar=omar) # useful if rerunning interactively
