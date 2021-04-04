# https://github.com/dankelley/oce/issues/435
if (!interactive()) png("435a.png", width=7, height=7, unit="in", res=150, pointsize=11)

library(oce)
source("~/git/oce/R/colors.R")
library(RColorBrewer)
N <- 10
pal <- brewer.pal(N, 'RdBu')
xlim <- 1.0
dx <- 2 * xlim / (N - 1)
x <- seq(from=-xlim, by=dx, length.out=length(pal))
x0 <- head(x, -1)
x1 <- tail(x, -1)
col0 <- head(pal, -1)
col1 <- tail(pal, -1)
data(adp)
par(mfrow=c(2,2))
cm <- colormap(zlim=c(-1.0, 1.0), breaks=10, col=oceColorsTwo, debug=3)
mar <- c(3,3,2,1)
plot(adp, which=1, col=cm$col, breaks=cm$breaks, drawTimeRange=FALSE, mar=mar)

for (blend in c(0, 0.5, 1)) {
    for (n in 1) {
        cm <- colormap(x0=x0, x1=x1, col0=col0, col1=col1, blend=blend, debug=0)
        cat("x0", x0, "\n")
        cat("x1", x1, "\n")
        cat("cm$x0", cm$x0, "\n")
        cat("cm$x1", cm$x1, "\n")
        plot(adp, which=1, col=cm$col, breaks=cm$breaks, drawTimeRange=FALSE, mar=mar)
        for (i in seq_along(cm$col)) {
            points(adp[["time"]][10], 4+6*i, pch=21, cex=2.5, bg=cm$col[i])
        }
        for (i in seq_along(cm$col0)) {
            points(adp[["time"]][20], 4+6*i, pch=21, cex=2.5, bg=cm$col0[i])
            points(adp[["time"]][30], 4+6*i, pch=21, cex=2.5, bg=cm$col1[i])
        }
        text(adp[["time"]][10], 5, "col", font=2)
        text(adp[["time"]][20], 5, "col0", font=2)
        text(adp[["time"]][30], 5, "col1", font=2)
    }
    # mtext(paste("breaks=", paste(round(cm$breaks,2), collapse=","), "; blend=", blend, sep=""), side=3, cex=3/4, line=1)
    mtext(paste("blend=", blend), side=3, cex=3/4)
}
if (!interactive()) dev.off()

