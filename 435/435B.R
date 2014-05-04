if (!interactive()) png("435B.png", width=7, height=7, unit="in", res=150, pointsize=12)
library(RColorBrewer)
col0 <- brewer.pal(7, 'RdBu')
library(oce)
l <- 1.5
x0 <- seq(-l, l, length.out=length(col0))
x1 <- x0 + diff(x0[1:2])
col1 <- col0
if ("kelley"==system('whoami',intern=TRUE)) source('~/src/oce/R/colors.R')
data(adp)
par(mfrow=c(2,2))
for (n in 1:4) {
    cm <- Colormap(x0=x0, x1=x0, col0=col0, col1=col1, n=n)
    plot(adp, zlim=c(-l, l), which=1, col=cm$col, breaks=cm$breaks, drawTimeRange=FALSE)
    for (i in seq_along(col0)) {
        points(adp[["time"]][25], 4+5*i, pch=21, cex=2.5, bg=col0[i])
    }
}
if (!interactive()) dev.off()

