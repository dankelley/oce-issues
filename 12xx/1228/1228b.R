DP <- 0.128 # inferred pressure change in matlab
icutoff <- 8281 # at end, where matlab and oce disagree (by eye on graph)
o <- 1 # the offset we need to compare (since oce is losing first ensemble)
library(R.matlab)
library(oce)
library(testthat)
options(digits=10)
options(digits.secs=4)

if (!length(objects(pattern="^m$"))) {
    message("rereading data")
    m <- readMat("adcp.mat")
    d <- read.oce("adcp.000")
} else {
    message("using cached data")
}

toce <- d[["time"]]
tmat <- ISOdatetime(as.vector(2000+m$SerYear), 
                    as.vector(m$SerMon),
                    as.vector(m$SerDay),
                    as.vector(m$SerHour),
                    as.vector(m$SerMin),
                    as.vector(m$SerSec)+as.vector(m$SerHund)/100, tz="UTC")
tdf <- data.frame(toce=toce, tmat=tmat[-1])
cat("check that we are reading times right. Below is head:\n")
print(head(tdf))
cat("check that we are reading times right. Below is tail:\n")
print(tail(tdf))
cat("fivenum on t diff\n")
print(fivenum(tdf$toce-tdf$tmat))
expect_equal(tdf$toce, tdf$tmat)


## Panels show matlab on left, oce on right
n <- 100
tudf <- data.frame(toce=toce, uoceTOP=d[["v"]][,1,1], umatTOP=m$SerEmmpersec[-1,1]/1000.0)
cat("head of surface velocities compared\n")
print(head(tudf))
cat("tail of surface velocities compared\n")
print(tail(tudf))
cat("surface velocities compared at indices ", icutoff, "+seq(-5,5)\n")
print(tudf[icutoff+seq.int(-5, 5), ])

ylim <- c(-1, 1)
if (!interactive()) png("1228b.png", unit="in", width=7, height=7, res=150, pointsize=11)
par(mfcol=c(3, 2), mar=c(3, 3, 1, 1), mgp=c(2, 0.7, 0))
oce.plot.ts(tdf$tmat, m$SerEmmpersec[-1,1]/1000.0, ylim=ylim, ylab="mat E")
oce.plot.ts(head(tdf$tmat,n), head(m$SerEmmpersec[-1,1]/1000.0,n), ylim=ylim, ylab="mat E")
oce.plot.ts(tail(tdf$tmat,n), tail(m$SerEmmpersec[-1,1]/1000.0,n), ylim=ylim, ylab="mat E")
icutoff <- 8281 # by eye
cutoff <- toce[icutoff]
abline(v=cutoff, col=2, lty='dotted')
mtext(paste(format(cutoff), " (", icutoff, ") ", sep=""),
      side=3, adj=1, cex=0.9, line=-1.1, col=2)

oce.plot.ts(tdf$toce, d[["v"]][,1,1], ylim=ylim, ylab="oce 1")
oce.plot.ts(head(tdf$toce,n), head(d[["v"]][,1,1],n), ylim=ylim, ylab="oce 1")
oce.plot.ts(tail(tdf$toce,n), tail(d[["v"]][,1,1],n), ylim=ylim, ylab="oce 1")
abline(v=cutoff, col=2, lty='dotted')
mtext(paste(format(cutoff), " (", icutoff, ") ", sep=""),
      side=3, adj=1, cex=0.8, line=-1.1, col=2)

if (!interactive()) dev.off()
