if (!interactive()) png("531.png")
library(oce)
try({source("~/src/oce/R/imagep.R")})
try({source("~/src/oce/R/oce.R")})
data(adp)
par(mfrow=c(2,1))
oce.plot.ts(adp[['time']], adp[['temperature']],
            xlim=c(adp[['time']][5], adp[['time']][30]),
            col='grey', lwd=10, type='l',
            drawTimeRange=FALSE)
mtext('Expect: similar lines on graphs', adj=0, font=2, col="purple")
mtext('oce.plot.ts', adj=1)
lines(adp[['time']], adp[['temperature']])
plot(adp[['time']], adp[['temperature']], xlim=c(adp[['time']][5], adp[['time']][30]), col='grey', lwd=10, type='l')
lines(adp[['time']], adp[['temperature']])
mtext('plot', adj=1)
if (!interactive()) dev.off()

