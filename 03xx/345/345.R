library(oce)
data(RRprofile, package='ocedata')
if (!interactive()) png("345.png")
plot(RRprofile$temperature, RRprofile$depth, ylim=c(500,0), xlim=c(2,11), pch=20, cex=1/2)
zz <- seq(0, 500, 1)
a1 <- oceApprox(RRprofile$depth, RRprofile$temperature, zz)
a2 <- oceApprox(RRprofile$depth, RRprofile$temperature, zz, 'rr')
lines(a1, zz)
lines(a2, zz, col='red')
legend("bottomright", lwd=1, col=1:2,
       legend=c("reiniger-ross", "nodc"), cex=3/4)
if (!interactive()) dev.off()

