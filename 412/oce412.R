## https://github.com/dankelley/oce/issues/412

## axis10exp from CR
axis10exp <- function(side, constantExp=TRUE, at=NULL, labels=TRUE, tick=TRUE, line=NA,
                      pos=NA, outer=FALSE, font=NA, lty='solid',
                      lwd=1, lwd.ticks=lwd, col=NULL, col.ticks=NULL,
                      hadj=NA, padj=NA, ...)
{
    if (is.null(at)) at <- axTicks(side)
    atexp <- round(log10(abs(at)))
    zero <- is.infinite(atexp)
    atexp[zero] <- 0
    if (constantExp) { # find the smallest non-zero exponent
        zeroExp <- atexp == 0
        newexp <- min(atexp[!zeroExp])
        atexp[!zeroExp] <- newexp
    }
    atbase <- at/10^atexp
    atlabel <- NULL
    for (ilab in seq_along(at)) {
        if (zero[ilab]) {
            lab <- expression(0)
        } else if (atexp[ilab]==0) {
            lab <- substitute(b, list(b=atbase[ilab]))
        } else {
            lab <- substitute(b%*%10^e, list(b=atbase[ilab], e=atexp[ilab]))
        }
        atlabel <- c(atlabel, lab)
    }
    atlabel <- as.expression(atlabel)
    axis(side, at=at, labels=atlabel, tick, line,
                      pos, outer, font, lty,
                      lwd, lwd.ticks, col, col.ticks,
                      hadj, padj, ...)
}
if (!interactive()) png("412.png", width=5,height=5,unit="in",res=150,pointsize=10)
par(mfrow=c(1,2))
library(oce)
data(adp)
v <- adp[['v']][,,1] / 1e5
imagep(v)
imagep(v, axisPalette=axis10exp)
if (!interactive()) dev.off()

