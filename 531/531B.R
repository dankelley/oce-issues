if (!interactive()) png("531B.png")
library(oce)
try({
    source("~/src/oce/R/oce.R")
    source("~/src/oce/R/imagep.R")
})
options(oceDrawTimeRange=FALSE)

t <- seq.POSIXt(ISOdate(2012, 1, 1, tz='UTC'), ISOdate(2012, 12, 31, tz='UTC'), 7200)
x <- rnorm(t)
par(mfcol=c(2,2))
xlim <- as.POSIXct(c('2012-03-01', '2012-06-01'), tz='UTC')
oce.plot.ts(t, x, xlim=xlim, drawTimeRange=FALSE, col='gray')
abline(v=xlim, col='red', lwd=2)
mtext(paste('usr[1:2]=c(', paste(numberAsPOSIXct(par('usr')[1:2]), collapse=", "), ")"),
      side=1, line=1.75, col='red', cex=3/4)
mtext("oce.plot.ts ", side=3, adj=1, cex=0.9, col='blue')
mtext("EXPECT: same across column", font=2, col="purple", line=0.75, adj=0)

plot(t, x, xlim=xlim, type='l', xlab='', col='gray')
abline(v=xlim, col='red', lwd=2)
mtext("plot ", side=3, adj=1, cex=0.9, col='blue')
mtext(paste('usr[1:2]=c(', paste(numberAsPOSIXct(par('usr')[1:2]), collapse=", "), ")"),
      side=1, line=1.75, col='red', cex=3/4)

# Column 2
oce.plot.ts(t, x, xlim=xlim, type='l', xlab='', xaxs="i", col='gray')
abline(v=xlim, col='red', lwd=2)
mtext("oce.plot.ts(..., xaxs=\"i\")", side=3, adj=1, cex=0.9, col='blue')
mtext(paste('usr[1:2]=c(', paste(numberAsPOSIXct(par('usr')[1:2]), collapse=", "), ")"),
      side=1, line=1.75, col='red', cex=3/4)
plot(t, x, xlim=xlim, type='l', xlab='', xaxs="i", col='gray')
abline(v=xlim, col='red', lwd=2)
mtext("plot(..., xaxs=\"i\")", side=3, adj=1, cex=0.9, col='blue')
mtext(paste('usr[1:2]=c(', paste(numberAsPOSIXct(par('usr')[1:2]), collapse=", "), ")"),
      side=1, line=1.75, col='red', cex=3/4)

if (!interactive()) dev.off()
