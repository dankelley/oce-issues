library(oce)
lat <- 44.8544
lon <- -63.1992

## Add 3 hours to get UTC
## rise 07:51AM local; 10:51 UTC
rise <- as.POSIXct("2014-04-01 10:51:00", tz="UTC")
mr <- moonAngle(rise, lon=lon, lat=lat)
cat("at moonrise, get alt=", mr$altitude, "(expect 0) and azimuth=", mr$azimuth, "(expect 73)\n")

## fall 10:06PM=22:06 local; 25:06 UTC or 01:06 on next day
fall <- as.POSIXct("2014-04-02 01:06:00", tz="UTC")
mf <- moonAngle(fall, lon=lon, lat=lat)
cat("at moonfall, get alt=", mf$altitude, "(expect 0) and azimuth=", mf$azimuth, "(expect 290)\n")

t <- seq(rise-3600, to=fall+3600, by="1 min")
plot(t, moonAngle(t, lon=lon, lat=lat)$altitude, type='l')
abline(h=0)
abline(v=rise)
abline(v=fall)
