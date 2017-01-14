library(oce)
par(mfrow=c(4,2))
d <- adp[['v']][,,1]
d[100:120, 40:60] <- -100

breaks <- seq(-2, 2, 0.2)
col <- oceColors9B(20)
zlim <- c(-2, 2)
line <- -1.25
side <- 3

## no zlim no breaks
imagep(d) 
legend("top", legend="(no args)", bg='white')

imagep(d, col=col)
legend("top", legend="col", bg='white')

imagep(d, breaks=breaks)
legend("top", legend="breaks", bg="white")

imagep(d, col=col, breaks=breaks)
legend("top", legend="col+breaks", bg="white")

imagep(d, zlim=zlim)
legend("top", legend="zlim", bg="white")

imagep(d, zlim=zlim, col=col)
legend("top", legend="zlim+col", bg="white")

imagep(d, breaks=breaks, , zlim=zlim)
legend("top", legend="zlim+breaks", bg="white")

imagep(d, zlim=zlim, col=col, breaks=breaks)
legend("top", legend="zlim+col+breaks", bg="white")

