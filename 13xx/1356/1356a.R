rm(list=ls())
library(oce)
source("~/git/oce/R/tides.R")

foreman <- read.table("../1351/foreman.dat", header=TRUE, stringsAsFactors=FALSE)

data(sealevelTuktoyaktuk)
m <- tidem(sealevelTuktoyaktuk,
           constituents=c("standard", "M10"),
           greenwich=TRUE,
           infer=list(name=c("P1", "K2"), # 0.0415525871 0.0835614924
                      from=c("K1", "S2"), # 0.0417807462 0.0833333333
                      amp=c(0.33093, 0.27215),
                      phase=c(-7.07, -22.40)), debug=0)

if (!interactive()) png("1356a.png", height=5, width=5, unit="in", res=100, pointsize=10)
par(mar=c(2, 2, 2, 2), mgp=c(2, 0.7, 0))
rpd <- pi / 180
Soce <- sin(m[["phase"]] * rpd)
Coce <- cos(m[["phase"]] * rpd)
Sforeman <- sin(foreman$G * rpd)
Cforeman <- cos(foreman$G * rpd)
plot(c(-1.1, 1.1), c(-1.1, 1.1), asp=1, xlab="", ylab="", type="n", axes=FALSE)
theta <- seq(0, 2*pi, pi/32)
lines(cos(theta), sin(theta), col='gray')
for (deg in seq(0, 360, 5)) {
    lines(c(0.8,1)*cos(deg*rpd), c(0.8,1)*sin(deg*rpd), col="gray", lty=3)
}
for (deg in seq(0, 360, 15)) {
    text(0.75*cos(deg*rpd), 0.75*sin(deg*rpd), deg, col="gray")
}
look <- 1:9
delta <- 0.02
Delta <- 5 * delta
points((1+delta)*Cforeman[look], (1+delta)*Sforeman[look], pch=20)
text((1+Delta)*Cforeman[look], (1+Delta)*Sforeman[look], look)
points((1-delta)*Coce[look], (1-delta)*Soce[look], col=2, pch=20)
text((1-Delta)*Coce[look], (1-Delta)*Soce[look], look, col=2)
legend("topright", col=1:2, pch=20, legend=c("Foreman", "tidem"))
if (!interactive()) dev.off()

