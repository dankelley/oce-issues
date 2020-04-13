library(oce)
file <- "~/Dropbox/S101135A001_Ronald.ad2cp"
d <- read.oce(file, debug=5)
if (!interactive()) png("1676b_image.png")
plot(d, zlim=c(-1.5, 1.5))
summary(d)
if (!interactive()) dev.off()
if (!interactive()) png("1676b_hist.png")
par(mfrow=c(3,1), mar=c(3,3,2,1), mgp=c(2,0.7,0))
v <- d[["v"]]
hist(v[,,1], xlab="u [m/s]", main="")
hist(v[,,2], xlab="v [m/s]", main="")
hist(v[,,3], xlab="z [m/s]", main="")
if (!interactive()) dev.off()
## 
