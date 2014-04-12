## http://www.timeanddate.com/worldclock/astronomy.html?n=286&month=4&year=2014&obj=sun&afl=-1&day=1
library(oce)
source("~/src/oce/R/sun.R")
lat <- 44.8544
lon <- -63.1992

## Add 3 hours to get UTC
## rise 06:55AM local; 08:55 UTC
rise <- as.POSIXct("2014-04-01 09:55:00", tz="UTC")
sr <- sunAngle(rise, lon=lon, lat=lat)

## fall 7:42PM local; 10:42PM UTC = 22:42 UTC
fall <- as.POSIXct("2014-04-01 22:42:00", tz="UTC")
sf <- sunAngle(fall, lon=lon, lat=lat)

t <- seq(rise-3600, to=fall+3600, by="1 min")
plot(t, sunAngle(t, lon=lon, lat=lat)$altitude, type='l')
abline(h=0)
abline(v=rise)
abline(v=fall)

