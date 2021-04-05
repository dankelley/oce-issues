library(oce)
source("~/git/oce/R/adp.R")
source("~/git/oce/R/imagep.R")
source("~/git/oce/R/colors.R")
source("~/git/oce/R/misc.R")
library(RColorBrewer)
xmin <- -1
xmax <- 1
N <- 9
X <- seq(xmin, xmax, length.out=N)
X
dx <- X[2] - X[1]
x0 <- seq(xmin, xmax, dx) - 0.5*dx
x1 <- seq(xmin, xmax, dx) + 0.5*dx
n <- length(x0)
col0 <- brewer.pal(n, "RdBu")
col1 <- col0
data(adp)
cm <- colormap(x0=x0+0, x1=x1, col0=col0, col1=col1, debug=1)
if (!interactive()) png("1796b.png")
par(mfrow=c(1,1))
par(xpd=FALSE)
plot(adp, which=1, col=cm$col, breaks=cm$breaks, drawTimeRange=FALSE, mar=c(2,3,3,1), debug=2)
dy <- diff(par("usr")[3:4])/(n+1)
dt <- 3600
par(xpd=TRUE)
for (i in seq_along(col0))
    points(tail(adp[["time"]],1)+dt, 3+dy*i, pch=21, cex=2, bg=col0[i])
cm$breaks # last breaks are identical
mtext("Q1: are all dotted colors in colorbar?", line=2, adj=0, col="red", font=2)
mtext("Q2: is white centred?", line=1, adj=0, col="red", font=2)
mtext("Q3: are bands of equal length?", line=0, adj=0, col="red", font=2)
par(xpd=FALSE)
if (!interactive()) dev.off()
