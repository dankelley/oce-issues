rm(list=ls())
if (!interactive()) png("435.png", width=7, height=7, unit="in", res=150, pointsize=12)

library(oce)
library(RColorBrewer)
N <- 7
pal <- brewer.pal(N, 'RdBu')
xlim <- 1.5
dx <- 2 * xlim / (N - 1)
x <- seq(from=-xlim, by=dx, length.out=length(pal))
x0 <- head(x, -1)
x1 <- tail(x, -1)
col0 <- head(pal, -1)
col1 <- tail(pal, -1)
try(source('~/src/oce/R/colors.R'), silent=TRUE)
data(adp)
par(mfrow=c(2,2))
par(mfrow=c(1,1))
for (n in 1) {#:4) {
    cm <- Colormap(x0=x0, x1=x1, col0=col0, col1=col1, debug=1, blend=1) # case D
    cat("x0", x0, "\n")
    cat("x1", x1, "\n")
    cat("cm$x0", cm$x0, "\n")
    cat("cm$x1", cm$x1, "\n")
    str(cm)
    plot(adp, zlim=c(-xlim, xlim), which=1, col=cm$col, breaks=cm$breaks, drawTimeRange=FALSE)
    for (i in seq_along(cm$col)) {
        points(adp[["time"]][10], 4+3*i, pch=21, cex=2.5, bg=cm$col[i])
    }
    for (i in seq_along(cm$col0)) {
        points(adp[["time"]][20], 4+3*i, pch=21, cex=2.5, bg=cm$col0[i])
        points(adp[["time"]][30], 4+3*i, pch=21, cex=2.5, bg=cm$col1[i])
    }
    text(adp[["time"]][10], 5, "col", font=2)
    text(adp[["time"]][20], 5, "col0", font=2)
    text(adp[["time"]][30], 5, "col1", font=2)
}
title(paste("breaks=", paste(cm$breaks, collapse=",")))
if (!interactive()) dev.off()
message("issue 435: seems fine now on blend=0, blend=1, blend=1/2 NOT CODED for blend>1")
message("issue 435: missing top break")

