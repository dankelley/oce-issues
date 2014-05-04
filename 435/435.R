if (!interactive()) png("435.png", width=7, height=7, unit="in", res=150, pointsize=12)
library(RColorBrewer)
pal <- brewer.pal(7, 'RdBu')
library(oce)
l <- 1.5
x0 <- seq(-l, l, length.out=-1+length(pal))
x1 <- x0 + diff(x0[1:2])
col0 <- head(pal, -1)
col1 <- tail(pal, -1)
## source("~/src/oce/R/colors.R')
data(adp)
par(mfrow=c(2,2))
for (n in 1:4) {
    cm <- Colormap(x0=x0, x1=x0, col0=col0, col1=col1, n=n, debug=3)
    plot(adp, zlim=c(-l, l), which=1, col=cm$col, breaks=cm$breaks, drawTimeRange=FALSE)
    for (i in seq_along(col0)) {
        points(adp[["time"]][20], 4+5*i, pch=21, cex=2.5, bg=col0[i])
        points(adp[["time"]][30], 4+5*i, pch=21, cex=2.5, bg=col1[i])
    }
    points(adp[["time"]][10], 4+5*1, pch=21, cex=2.5, bg=cm$col[1])
    points(adp[["time"]][40], 4+5*length(col0), pch=21, cex=2.5, bg=tail(cm$col,1))
}
if (!interactive()) dev.off()

