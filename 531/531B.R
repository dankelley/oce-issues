if (!interactive()) png("531B.png", width=5, height=5, unit="in", res=150, pointsize=9)
library(oce)
try({
    source("~/src/oce/R/oce.R")
    source("~/src/oce/R/imagep.R")
})
options(oceDrawTimeRange=FALSE)

t <- seq.POSIXt(ISOdate(2012, 1, 1, tz='UTC'), ISOdate(2012, 12, 31, tz='UTC'), 7200)
y <- cos(seq_along(t)/240)*sin(seq_along(t)/20)
par(mfcol=c(2,2))
xlim <- as.POSIXct(c('2012-03-01', '2012-06-01'), tz='UTC')
oce.plot.ts(t, y, xlim=xlim, drawTimeRange=FALSE, type='o')
abline(v=xlim, col='red', lwd=2)
mtext(paste('usr[1:2]=c(', paste(numberAsPOSIXct(par('usr')[1:2]), collapse=", "), ")"),
      side=1, line=1.75, col='red', cex=3/4)
mtext("oce.plot.ts ", side=3, adj=1, cex=0.9, col='blue')
mtext("EXPECT: similar in col (FAIL)", font=2, col="purple", line=0.75, adj=0)

plot(t, y, xlim=xlim, type='o', xlab='')
abline(v=xlim, col='red', lwd=2)
mtext("plot ", side=3, adj=1, cex=0.9, col='blue')
mtext(paste('usr[1:2]=c(', paste(numberAsPOSIXct(par('usr')[1:2]), collapse=", "), ")"),
      side=1, line=1.75, col='red', cex=3/4)

# Column 2
oce.plot.ts(t, y, xlim=xlim, type='o', xlab='', xaxs="i")
abline(v=xlim, col='red', lwd=2)
mtext("oce.plot.ts(..., xaxs=\"i\")", side=3, adj=1, cex=0.9, col='blue')
mtext(paste('usr[1:2]=c(', paste(numberAsPOSIXct(par('usr')[1:2]), collapse=", "), ")"),
      side=1, line=1.75, col='red', cex=3/4)
mtext("EXPECT: similar in col", font=2, col="purple", line=0.75, adj=0)
plot(t, y, xlim=xlim, type='o', xlab='', xaxs="i")
abline(v=xlim, col='red', lwd=2)
mtext("plot(..., xaxs=\"i\")", side=3, adj=1, cex=0.9, col='blue')
mtext(paste('usr[1:2]=c(', paste(numberAsPOSIXct(par('usr')[1:2]), collapse=", "), ")"),
      side=1, line=1.75, col='red', cex=3/4)

if (!interactive()) dev.off()
