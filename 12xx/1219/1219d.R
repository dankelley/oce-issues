library(oce)
library(testthat)
## Note the use of a hard-wired name for a file available only to
## the developers. Also, we check that the returned object is of
## the oce class, which means that the tests only get done for
## either the "ad2cp" branch of oce, or branches into which
## that has been merged.
f <- "~/Dropbox/oce_ad2cp/labtestsig3.ad2cp" # DK only tests
if (file.exists(f)) {
    d <- read.ad2cp(f, 1, 100, 1)
    if (!interactive()) png("1219d_1.png")
    ## 2x3 plot matrix for sampling of first 6 velo sequences
    par(mfrow=c(2,3), mar=c(2.5,2.5,1,1), mgp=c(1.5,0.5,0))
    firstVelo <- which(d[["id"]] == 22)[1]
    v <- d[["v"]]
    dist <- d[["distance"]]
    for (l in 1:6) {
        plot(v[l,,1], dist, xlim=c(min(v), max(v)), type='l',
             xlab="velo beams", ylab="Distance [m] ???")
        mtext(sprintf("d$v[[%d]]", l), side=3, cex=0.6)
        for (i in 2:4) {
            lines(v[l,,i], dist, type='l', col=i)
        }
    }
    if (!interactive()) dev.off()
    ## Plot as images, one panel per component
    if (!interactive()) png("1219d_2.png")
    zlim <- max(abs(v)) * c(-1, 1)
    par(mfrow=c(dim(v)[3], 2))
    ntime <- dim(v)[1]
    nbeam <- dim(v)[3]
    time <- d[["time"]][d[["id"]]==22]
    for (i in seq_len(nbeam)) {
        plot(d, which=i)
        hist(v[,,i])
    }
    if (!interactive()) dev.off()
    ## Plot crude u and v-like quantities to check if hist() peaks near 0
    if (!interactive()) png("1219d_3.png")
    v13 <- v[,,1] - v[,,3]
    v24 <- v[,,2] - v[,,4]
    zlim <- max(abs(c(v13, v24))) * c(-1, 1)
    par(mfrow=c(2, 2))
    imagep(d[["time"]], dist, v13, zlim=zlim, ylab="Distance [m] ???")
    hist(v13)
    imagep(d[["time"]], dist, v24, zlim=zlim, ylab="Distance [m] ???")
    hist(v24)
    if (!interactive()) dev.off()
}

