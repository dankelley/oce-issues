require(oce)

make_tdr <- function(start, end) {
    start <- as.POSIXct('2015-01-15 12:00:00', tz='UTC')
    end <- as.POSIXct('2015-01-15 15:00:00', tz='UTC')
    t <- as.POSIXct("2015-01-15 00:00:00", tz="UTC") + 3600 * seq(0, 24, 1)
    tt <- as.numeric(t)
    p <- sin(tt * pi / 180 / 24)
    T <- cos(tt * pi / 180 / 24)^2
    d <- as.tdr(time=t, temperature=T, pressure=p)
    d <- subset(d, start <= time & time <= end)
}

focus <- as.POSIXct(c('2015-01-15 00:00:00', '2015-01-15 20:00:00'), tz='UTC')
d <- make_tdr(focus[1], focus[2])
str(d)

