library(oce)
source("~/git/oce/R/adp.R")
source("~/git/oce/R/imagep.R")
source("~/git/oce/R/colors.R")
library(RColorBrewer)
xmin <- -1
xmax <- 1
N <- 9
X <- seq(xmin, xmax, length.out=N)
X
x0 <- seq(xmin, xmax, dx) - 0.5*dx
x1 <- seq(xmin, xmax, dx) + 0.5*dx
n <- length(x0)
col0 <- brewer.pal(n, "RdBu")
col1 <- col0
data(adp)
cm <- colormap(x0=x0, x1=x1, col0=col0, col1=col1, debug=3)
par(mfrow=c(2,1))
par(xpd=FALSE)
plot(adp, which=1, col=cm$col, breaks=cm$breaks, drawTimeRange=FALSE)
dy <- diff(par("usr")[3:4])/(n+1)
dt <- 3600
par(xpd=TRUE)
for (i in seq_along(col0)) points(tail(adp[["time"]],1)+dt,
                                  3+dy*i, pch=21, cex=2, bg=col0[i])
mtext("col & breaks", adj=0, cex=0.8)
cm$breaks # last breaks are identical
mtext("Q: all cols? white centred? equal bands?", col="red", font=2, cex=0.9)

par(xpd=FALSE)
plot(adp, which=1, colormap=cm, drawTimeRange=FALSE, debug=5)
par(xpd=TRUE)
for (i in seq_along(col0)) points(tail(adp[["time"]],1)+dt,
                                  3+dy*i, pch=21, cex=2, bg=col0[i])
mtext("colormap", adj=0, cex=0.8)
mtext("Q: all cols? white centred? equal bands?", col="red", font=2, cex=0.9)

