library(oce)
data(sealevel)
lat <- sealevel[["latitude"]]
lon <- sealevel[["longitude"]]
t <- sealevel[["time"]][1:72]
eta <- sealevel[["elevation"]][1:72]
eta <- eta - mean(eta)
if (!interactive()) png("872a.png")
oce.plot.ts(t, eta, type='p', pch=20)
tr <- range(t)
tw <- seq(tr[1], tr[2], by="15 min")
e <- webtide("predict",lat=lat,lon=lon,time=tw,plot=FALSE)
lines(e$time, e$elevation)
if (!interactive()) dev.off()

