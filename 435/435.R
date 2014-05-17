rm(list=ls())
if (!interactive()) png("435.png", width=7, height=7, unit="in", res=150, pointsize=12)

# source("~/src/oce/R/imagep.R")
# source("~/src/oce/R/adp.R")

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
data(adp)
par(mfrow=c(3,1))
for (blend in c(0, 0.5, 1)) {
    for (n in 1) {
        cm <- colormap(x0=x0, x1=x1, col0=col0, col1=col1, blend=blend, debug=0)
        cat("x0", x0, "\n")
        cat("x1", x1, "\n")
        cat("cm$x0", cm$x0, "\n")
        cat("cm$x1", cm$x1, "\n")
        plot(adp, which=1, col=cm$col, breaks=cm$breaks, drawTimeRange=FALSE)
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
    mtext(paste("breaks=", paste(cm$breaks, collapse=","), "; blend=", blend),
          side=3, cex=3/4)
}
if (!interactive()) dev.off()

