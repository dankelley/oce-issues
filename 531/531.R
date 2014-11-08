if (!interactive()) png("531.png")
library(oce)
try({source("~/src/oce/R/imagep.R")})
try({source("~/src/oce/R/oce.R")})
data(adp)
par(mfcol=c(2,3))

## column 1: trimming both ends of x axis
oce.plot.ts(adp[['time']], adp[['temperature']],
            xlim=c(adp[['time']][5], adp[['time']][30]),
            mar=c(3, 3, 3, 1),
            type='o', drawTimeRange=FALSE)
mtext('Trim @ both ends\nEXPECT: similar in col', adj=0, font=2, col="purple")
mtext('oce.plot.ts ', adj=1, line=-1)
#lines(adp[['time']], adp[['temperature']])
plot(adp[['time']], adp[['temperature']],
     xlim=c(adp[['time']][5], adp[['time']][30]), type='o')
lines(adp[['time']], adp[['temperature']])
mtext('plot ', adj=1, line=-1)

## column 2: trimming only right-hand end of x axis
offset <- 1800                         # half an hour
oce.plot.ts(adp[['time']], adp[['temperature']],
            xlim=c(adp[['time']][1]-offset, adp[['time']][30]),
            mar=c(3, 3, 3, 1),
            type='o', drawTimeRange=FALSE)
mtext('Trim @ left end\nEXPECT: similar in col', adj=0, font=2, col="purple")
mtext('oce.plot.ts ', adj=1, line=-1)
lines(adp[['time']], adp[['temperature']])
plot(adp[['time']], adp[['temperature']],
     xlim=c(adp[['time']][1]-offset, adp[['time']][30]), type='o')
lines(adp[['time']], adp[['temperature']])
mtext('plot ', adj=1, line=-1)

## column 3: trimming only right-hand end of x axis; xaxs='i'
offset <- 1800                         # half an hour
oce.plot.ts(adp[['time']], adp[['temperature']],
            xlim=c(adp[['time']][1]-offset, adp[['time']][30]),
            xaxs="i",
            mar=c(3, 3, 3, 1),
            type='o', drawTimeRange=FALSE)
mtext('Trim @ left end; xaxs="i"\nEXPECT: similar in col', adj=0, font=2, col="purple")
mtext('oce.plot.ts ', adj=1, line=-1)
lines(adp[['time']], adp[['temperature']])
plot(adp[['time']], adp[['temperature']],
     xaxs="i",
     xlim=c(adp[['time']][1]-offset, adp[['time']][30]), type='o')
lines(adp[['time']], adp[['temperature']])
mtext('plot ', adj=1, line=-1)



if (!interactive()) dev.off()

