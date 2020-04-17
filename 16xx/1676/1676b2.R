library(oce)
file <- "ad2cp_02.ad2cp"
d <- read.adp.ad2cp(file, debug=5)
if (!interactive()) png("1676b2_velocity.png")
plot(d, zlim=c(-1.5, 1.5))
summary(d)
if (!interactive()) dev.off()

if (!interactive()) png("1676b2_backscatter.png")
par(mfrow=c(4,1), mar=c(3,3,2,1), mgp=c(2,0.7,0))
plot(d, which="a1")
plot(d, which="a2")
plot(d, which="a3")
plot(d, which="a4")
if (!interactive()) dev.off()

if (!interactive()) png("1676b2_hist.png")
par(mfrow=c(3,1), mar=c(3,3,2,1), mgp=c(2,0.7,0))
v <- d[["v"]]
hist(v[,,1], xlab="u [m/s]", main="")
hist(v[,,2], xlab="v [m/s]", main="")
hist(v[,,3], xlab="z [m/s]", main="")
if (!interactive()) dev.off()

## NOTE: look in 1676d.R for testing that might go into a test suite,
## NOTE: but ONLY if the issue reporter chooses to donate the first 100k
## NOTE: of the file to the oce project.

