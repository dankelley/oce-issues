library(oce)
x <- 1:1000
y <- 1:800
nx <- length(x)
ny <- length(y)
d <- matrix(rnorm(nx*ny), nrow=nx)
xlim <- c(500, 550)
ylim <- c(500, 550)
debug <- 0
if (!interactive()) png("827a.png")
par(mfrow=c(1, 2))
imagep(x, y, d, xlim=xlim, ylim=ylim, debug=debug)
mtext("EXPECT: identical panels", font=2, col='magenta', line=0, adj=0)
imagep(x, y, d, xlim=xlim, ylim=ylim, decimate=FALSE, debug=debug)
if (!interactive()) dev.off()

