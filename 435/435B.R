rm(list=ls())
if (!interactive()) png("435B.png", width=7, height=7, unit="in", res=150, pointsize=12)

library(oce)
library(RColorBrewer)
N <- 7
pal <- brewer.pal(N, 'RdBu')
xlim <- 1.5
dx <- 2 * xlim / (N - 1)
x <- seq(from=-xlim, by=dx, length.out=length(pal))
x0 <- head(x, -1) ## -1.5 -1.0 -0.5  0.0  0.5  1.0
x1 <- tail(x, -1) ## -1.0 -0.5  0.0  0.5  1.0  1.5
col0 <- head(pal, -1)
col1 <- tail(pal, -1)
data(adp)
for (blend in 40) {
    cm <- colormap(x0=x0, x1=x1, col0=col0, col1=col1, blend=blend, debug=0)
    plot(adp, zlim=c(-xlim, xlim), which=1, col=cm$col, breaks=cm$breaks, drawTimeRange=FALSE)
}
if (!interactive()) dev.off()
## check for uniformity
stopifnot(1e-10 > max(abs(diff(diff(cm$x0)))))
stopifnot(1e-10 > max(abs(diff(diff(cm$x1)))))
stopifnot(1e-10 > max(abs(diff(diff(cm$breaks)))))
