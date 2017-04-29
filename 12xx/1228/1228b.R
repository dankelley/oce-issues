DP <- 0.128 # inferred pressure change in matlab
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

poce <- d[["pressure"]]
pmat <- as.numeric(m$AnDepthmm) / 1000.0
ndata <- length(poce) # matlab has 1 more data point
vectorShow(poce, n=4)
vectorShow(pmat, n=4)

toce <- d[["time"]]
tmat <- ISOdatetime(as.vector(2000+m$SerYear), 
                    as.vector(m$SerMon),
                    as.vector(m$SerDay),
                    as.vector(m$SerHour),
                    as.vector(m$SerMin),
                    as.vector(m$SerSec)+as.vector(m$SerHund)/100, tz="UTC")
tdf <- data.frame(toce=toce, tmat=tmat[-1])
message("check that we are reading times right. Below is head:")
print(head(tdf))
message("check that we are reading times right. Below is tail:")
print(tail(tdf))
message("fivenum on t diff")
print(fivenum(tdf$toce-tdf$tmat))
expect_equal(tdf$toce, tdf$tmat)


## demo that we are missing one time.
i <- 1:5
message("below shows that oce is missing 1 ensemble at the start")
start <- data.frame(ocetime=d[["time"]][i], mday=m$SerDay[i], mhour=m$SerHour[i],
                    mmin=m$SerMin[i], msec=m$SerSec[i], msec100=m$SerHund[i])
print(start)

## look at pressure timeseries (after dropping first mat)
df <- data.frame(poce=poce, pmat=pmat[-1], pmatCorrected=pmat[-1]+DP)
message("here's the start pressures compared:")
print(head(df, 50))
message("here's the end pressures compared:")
print(tail(df, 50))


for (look in ndata-c(20:0)) {
    message("matE, matN, v[,,1], v[,,2] @ ensemble", look, " (NOTE: 2^15=32768 is NA?)")
    print(cbind(m$SerEmmpersec[look,]/1000.0, m$SerNmmpersec[look,]/1000.0,
                d[["v"]][look,,1],  d[["v"]][look,,2]))
}

## Panels show matlab on left, oce on right
n <- 100
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
