library(oce)
library(testthat)
## Note the use of a hard-wired name for a file available only to
## the developers. Also, we check that the returned object is of
## the oce class, which means that the tests only get done for
## either the "ad2cp" branch of oce, or branches into which
## that has been merged.
f <- "~/Dropbox/oce_ad2cp/labtestsig3.ad2cp" # DK only tests
if (file.exists(f)) {
    N <- 100
    d <- read.ad2cp(f, 1, N, 1)
    if (inherits(d, "oce") && "AD2CP" == d[["instrumentType"]]) {
        if (!interactive()) png("1219d_1.png")
        look <- which(d[["id"]] == 22)
        par(mfrow=c(2,3), mar=c(2.5,2.5,1,1), mgp=c(1.5,0.5,0)) # 2x3 enough for head()
        for (l in head(look)) {
            v <- d[["v"]][[l]]
            dist <- d[["blanking"]][l] + d[["cellSize"]][l][1] + 1:dim(v)[1]
            plot(v[,1], dist, xlim=c(min(v), max(v)), type='l', xlab="velo?", ylab="Distance [m] ???")
            mtext(sprintf("d$v[[%d]]", l), side=3, cex=0.6)
            for (i in 2:4) {
                lines(v[,i], dist, type='l', col=i)
            }
        }
        if (!interactive()) dev.off()
        ## test ideas for a velo image plot
        ## fill up an array for velocity
        ncell <- dim(d[["v"]][[look[1]]])[1]
        nbeam <- dim(d[["v"]][[look[1]]])[2]
        V <- array(double(), dim=c(length(look), ncell, nbeam))
        for (i in seq_along(look)) {
            V[i, ,] <- d[["v"]][[look[i]]]
        }
        ## Plot as images, one panel per component
        if (!interactive()) png("1219d_2.png")
        zlim <- max(abs(d[["v"]][[look[1]]])) * c(-1, 1)
        par(mfrow=c(nbeam, 2))
        ntime <- dim(V[,,1])[1]
        for (i in seq_len(nbeam)) {
            imagep(d[['time']][look], dist, V[,,i], zlim=zlim, ylab="Distance [m] ???")
            hist(V[,,i])
        }
        if (!interactive()) dev.off()
        ## Plot crude u and v-like quantities to check if hist() peaks near 0
        if (!interactive()) png("1219d_3.png")
        u13 <- V[,,1] - V[,,3]
        u24 <- V[,,2] - V[,,4]
        zlim <- max(abs(c(u13,u24))) * c(-1, 1)
        par(mfrow=c(2, 2))
        imagep(d[['time']][look], dist, u13, zlim=zlim, ylab="Distance [m] ???")
        hist(u13)
        imagep(d[['time']][look], dist, u24, zlim=zlim, ylab="Distance [m] ???")
        hist(u24)
        if (!interactive()) dev.off()
    }
}

