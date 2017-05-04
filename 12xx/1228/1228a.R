DP <- 0.128 # inferred pressure change in matlab
library(R.matlab)
library(oce)
library(testthat)
options(digits=10)
options(digits.secs=4)

m <- readMat("adcp.mat")
d <- read.oce("adcp.000", debug=100)

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
tdf <- data.frame(toce=toce, tmat=tmat)
expect_equal(tdf$toce, tdf$tmat)

## look at pressure timeseries (after dropping first mat)
df <- data.frame(poce=poce, pmat=pmat, pmatCorrected=pmat+DP)
cat("here's the start pressures compared:\n")
print(head(df, 10))
cat("here's the end pressures compared:\n")
print(tail(df, 10))

if (!interactive()) png("1228a.png", unit="in", width=7, height=7, res=150, pointsize=11)
par(mfrow=c(1,1), mar=c(3, 3, 1, 1), mgp=c(2, 0.7, 0))
plot(df$poce - df$pmat, type='l', ylab="poce-pmat")
mtext(sprintf("for index>100, mean(diff) = %.5f and sd(diff) = %.5f",
              mean(df$poce[-(1:100)] -df$pmat[-(1:100)]),
              sd(df$poce[-(1:100)]-df$pmat[-(1:100)])), side=3)

if (!interactive()) dev.off()
