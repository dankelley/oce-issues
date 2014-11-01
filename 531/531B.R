if (!interactive()) png("531B.png")
library(oce)
## try({
##     source("~/src/oce/R/oce.R")
##     source("~/src/oce/R/imagep.R")
## })
t <- seq.POSIXt(ISOdate(2012, 1, 1, tz='UTC'), ISOdate(2012, 12, 31, tz='UTC'), 100)
x <- rnorm(t)
oce.plot.ts(t, x, xlim=as.POSIXct(c('2012-03-01', '2012-06-01'), tz='UTC'), drawTimeRange=FALSE,
            debug=3)
mtext("EXPECT: graph extending across plot box", font=2, col="purple", line=0, adj=0)
if (!interactive()) dev.off()
