library(oce)
par(mfcol=c(2,2))
data(adp)
imagep(adp[['time']], adp[['distance']], adp[['v']][,,1])
## turn off time range for rest of plots
options(oceDrawTimeRange=FALSE)
imagep(rev(adp[['time']]), rev(adp[['distance']]), adp[['v']][,,1])
oceContour(adp[['time']], adp[['distance']], adp[['v']][,,1])
oceContour(rev(adp[['time']]), rev(adp[['distance']]), adp[['v']][,,1])

