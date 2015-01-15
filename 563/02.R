require(oce)

make_tdr <- function() {
    start <- as.POSIXct('2015-01-15 12:00:00', tz='UTC')
    end <- as.POSIXct('2015-01-15 15:00:00', tz='UTC')
    t <- as.POSIXct("2015-01-15 00:00:00", tz="UTC") + 3600 * seq(0, 24, 1)
    tt <- as.numeric(t)
    p <- sin(tt * pi / 180 / 24)
    T <- cos(tt * pi / 180 / 24)^2
    d <- as.tdr(time=t, temperature=T, pressure=p)
    d0 <<- d
    d <- subset(d, start <= time & time <= end)
}

d <- make_tdr()
str(d0)
str(d)

