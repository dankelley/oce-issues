library(oce)
## try(source("~/src/oce/R/tidem.R"))
data(sealevel)
lat <- sealevel[["latitude"]]
lon <- sealevel[["longitude"]]
t <- sealevel[["time"]][1:72]
eta <- sealevel[["elevation"]][1:72]
eta <- eta - mean(eta)
if (!interactive()) png("872a.png")
par(mfrow=c(2,1))
oce.plot.ts(t, eta, type='p', pch=20)
tr <- range(t)
tw <- seq(tr[1], tr[2], by="15 min")
e <- webtide("predict",lat=lat,lon=lon,time=tw,plot=FALSE)
lines(e$time, e$elevation)

try({
    ## Below may fail on other machines ... it checks to ensure that
    ## the ordering of data in the WebTide files is not changed.
    d <- read.table("/usr/local/WebTide/data/nwatl/nwatl_ll.nod",head=FALSE)
    plot(range(d$V2), range(d$V3), asp=1/cos(mean(range(d$V3)*pi/180)),
         xlab="", ylab="", type='n')
    rect(min(d$V2), min(d$V3), max(d$V2), max(d$V3), border='red')
    data(coastlineWorld)
    lines(coastlineWorld[['longitude']],coastlineWorld[['latitude']])
    points(lon, lat, col='blue', pch='+', cex=3)
})

if (!interactive()) dev.off()
