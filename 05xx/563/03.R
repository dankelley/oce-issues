require(oce)

start <- as.POSIXct('2015-01-15 12:00:00', tz='UTC')
end <- as.POSIXct('2015-01-15 15:00:00', tz='UTC')
t <- as.POSIXct("2015-01-15 00:00:00", tz="UTC") + 3600 * seq(0, 24, 1)
tt <- as.numeric(t)
p <- sin(tt * pi / 180 / 24)
T <- cos(tt * pi / 180 / 24)^2
d <- as.tdr(time=t, temperature=T, pressure=p)
str(d)
d <- subset(d, start <= time & time <= end)
str(d)

