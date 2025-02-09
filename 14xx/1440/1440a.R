## test code for issue 1440 (https://github.com/dankelley/oce/issues/1440)
library(oce)
library(testthat)
for (n in c(1, 20)) {
    cat("n=", n, "\n")
    T <- seq(2,3, length.out=n)
    S <- seq(31.4, 31.6, length.out=n)
    p <- seq(0, n, length.out=n)
    lat <- rep(44.5, n)
    lon <- rep(-63, n)
    stn <- 'fake'
    time <- seq(from=as.POSIXct("2012-01-01 00:00", tz='UTC'), by='min', length.out=20)
    ctd <- as.ctd(salinity=S,
                  temperature=T,
                  pressure=p,
                  time=time,
                  longitude=lon,
                  latitude=lat,
                  station=stn,
                  startTime=min(time))
    if (n > 1) {
        expect_true("longitude" %in% names(ctd[["data"]]))
        expect_equal(length(ctd[["data"]][["longitude"]]), n)
        expect_equal(length(ctd[["longitude"]]), n)
        expect_true("latitude" %in% names(ctd[["data"]]))
        expect_equal(length(ctd[["data"]][["latitude"]]), n)
        expect_equal(length(ctd[["latitude"]]), n)
        expect_true("longitudeMean" %in% names(ctd[["metadata"]]))
        expect_equal(length(ctd[["longitude"]]), n)
        expect_equal(length(ctd[["longitudeMean"]]), 1)
        expect_true("latitudeMean" %in% names(ctd[["metadata"]]))
        expect_equal(length(ctd[["latitude"]]), n)
        expect_equal(length(ctd[["latitudeMean"]]), 1)
    } else {
        expect_equal(length(ctd[["longitude"]]), 1)
        expect_equal(length(ctd[["latitude"]]), 1)
        expect_false("longitude" %in% names(ctd[["data"]]))
        expect_false("latitude" %in% names(ctd[["data"]]))
        expect_true("longitude" %in% names(ctd[["metadata"]]))
        expect_true("latitude" %in% names(ctd[["metadata"]]))
    }
}

