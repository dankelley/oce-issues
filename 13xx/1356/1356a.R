## rm(list=ls())
library(oce)

## below from t_demo.m
## >> datestr(tuk_time(1))
##
## ans =
##
##     '06-Jul-1975 01:00:00'

foreman <- read.table("../1351/foreman.dat", header=TRUE, stringsAsFactors=FALSE)
ttide <- read.table("../1351/ttide.dat", header=TRUE, stringsAsFactors=FALSE, skip=8)

data(sealevelTuktoyaktuk)

## Next block is fiddling around with something I just realized on 2017-01-06,
## namely that T_TIDE doesn't use the central time, but rather such a time
## rounded down to the nearest hour. That explained some problems in phase matching.
t <- sealevelTuktoyaktuk[["time"]]
expect_equal(t[1], as.POSIXct("1975-07-06 01:00:00", tz="UTC"))
expect_equal(t[2], as.POSIXct("1975-07-06 02:00:00", tz="UTC"))
tn <- as.numeric(t)
tnmean <- mean(tn)
tnmean
numberAsPOSIXct(tnmean, tz="UTC")
## get centre time, rounded to be on an hour mark
tnmean0 <- 3600 * round(tnmean / 3600)
numberAsPOSIXct(tnmean0, tz="UTC")
head((tn - tnmean) / 3600)
head((tn - tnmean0) / 3600)
tt <- tn - tnmean0
expect_equal(tt/3600, -791:792)

par(mar=rep(0, 4), mgp=c(2, 0.7, 0))
m <- tidem(sealevelTuktoyaktuk,
           constituents=c("standard", "M10"),
           infer=list(name=c("P1", "K2"), # 0.0415525871 0.0835614924
                      from=c("K1", "S2"), # 0.0417807462 0.0833333333
                      amp=c(0.33093, 0.27215),
                      phase=c(-7.07, -22.40)))

if (!interactive()) png("1356a.png", height=5, width=5, unit="in", res=100, pointsize=10)
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
look <- seq_along(m[["name"]])
delta <- 0.02
Delta <- 5 * delta
points((1+delta)*Cforeman[look], (1+delta)*Sforeman[look], pch=20)
text((1+Delta)*Cforeman[look], (1+Delta)*Sforeman[look], look)
points((1-delta)*Coce[look], (1-delta)*Soce[look], col=2, pch=20)
text((1-Delta)*Coce[look], (1-Delta)*Soce[look], look, col=2)
legend("topright", col=1:2, pch=20, legend=c("Foreman", "tidem"))


if (!interactive()) dev.off()

cat("Phase comparison:\n")
print(data.frame(name=m[["name"]],
                 phaseTidem=sprintf("%.2f", m[["phase"]]),
                 phaseTTIDE=sprintf("%.2f", ttide$phase),
                 phaseForeman=sprintf("%.2f", foreman$G),
                 phaseErrForeman=sprintf("%.2f", m[["phase"]] - foreman$G),
                 phaseErrTTIDE=sprintf("%.2f", m[["phase"]] - ttide$phase)))

cat("Amplitude comparison:\n")
print(data.frame(name=m[["name"]],
                 ampTidem=sprintf("%.4f", m[["amplitude"]]),
                 ampTTIDE=sprintf("%.4f", ttide$amplitude),
                 ampForeman=sprintf("%.4f", foreman$A),
                 ampErrForeman=sprintf("%.4f", m[["amplitude"]] - foreman$A),
                 ampErrTTIDE=sprintf("%.4f", m[["amplitude"]] - ttide$amplitude)))

max(abs(m[["amplitude"]] - foreman$A))
max(abs(m[["amplitude"]] - ttide$amplitude))
max(abs(m[["phase"]] - foreman$G))
max(abs(m[["phase"]] - ttide$phase))
