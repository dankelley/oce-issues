## Q: does offsetting conductivity smooth S wiggles. A: no
tmp <- tempfile(fileext=".rsk")
R.utils::decompressFile("sample.rsk.gz", destname=tmp, ext="gz", FUN=gzfile, remove=FALSE)
library(oce)
rsk <- read.rsk(tmp)
ctd <- as.ctd(rsk)
if (!interactive()) png("694_2.png")
plot(ctd, which="salinity+temperature")
C <- ctd[["conductivity"]]
p <- ctd[["pressure"]]
t <- as.numeric(ctd[["time"]])
t <- t - t[1]
T <- ctd[["temperature"]]
dps <- 0.1 * c(-1, 0, 1)
par(mfrow=c(2,length(dps)))
for (dp in dps) {
    S <- swSCTp(approx(p, C, p+dp, rule=2)$y, T, p, conductivityUnit=ctd[["conductivityUnit"]])
    ctd[["salinity"]] <- S
    plot(ctd, which="salinity+temperature")
    mtext(paste(" dp=", dp), side=3, line=-1.5, adj=0.5)
}
taus <- 0.1 * c(-1, 0, 1)
for (tau in taus) {
    S <- swSCTp(approx(t, C, t+tau, rule=2)$y, T, p, conductivityUnit=ctd[["conductivityUnit"]])
    ctd[["salinity"]] <- S
    plot(ctd, which="salinity+temperature")
    mtext(paste(" dp=", dp), side=3, line=-1.5, adj=0.5)
}
t
if (!interactive()) dev.off()
