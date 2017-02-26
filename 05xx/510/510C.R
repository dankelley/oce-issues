library(oce)
d <- read.oce("6901067_prof.nc")
g <- drifterGrid(d, p=seq(0, 100, 1))
par(mfrow=c(2,1))
t <- g[["time"]]
z <- -g[["pressure"]][,1]
imagep(t, z, t(g[['temperature']]), ylim=c(-100,0), zlim=c(0,20))
imagep(t, z, t(g[['salinity']]), ylim=c(-100,0))


