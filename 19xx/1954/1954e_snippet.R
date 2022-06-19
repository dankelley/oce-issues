# Ideas for formal tests
options(digits=15) # for making tests
library(oce)
library(testthat)
f <- "barrow_snippet.ad2cp"
d <- read.adp.ad2cp(f, debug=1)
A <- d@data$burstAltimeterRaw
str(A,1)
expect_equal(1833L, A$altimeterRawNumberOfSamples)
expect_equal(c(2L, 1833L), dim(A$altimeterRawSamples))
expect_equal(c(2313,2560,2313,3743), A$altimeterRawSamples[1,1:4])
expect_equal(rep(0.024,2L), A$altimeterRawSampleDistance)
expect_equal(c(42.0308685302734,42.1037330627441), A$altimeterDistance)
expect_equal(as.POSIXct("2022-05-25 11:54:45.000",tz="UTC"), A$time[1])
expect_equal(as.POSIXct(c("2022-05-25 11:54:45.000","2022-05-25 11:55:45.001 UTC"),tz="UTC"), A$time)
expect_equal(30L, length(d@data$burst))
str(d@data$burst)
expect_equal(c(42.0308685302734, 42.1036720275879, 42.1037139892578,
        42.1036949157715, 42.1040992736816, 42.1037445068359),
    d@data$burst$altimeterDistance)

# burst
expect_equal(c(0.807, 0.788, 0.791, 0.801, 0.796, 0.809), d@data$burst$pressure)

# average
expect_equal(c(30,87,4), dim(d@data$average$v))

# bottom track
expect_equal(30, length(d@data$bottomTrack$pressure))
# altimeterDistance values are wild. FIXME: error in reading?
expect_equal(c(30,4), dim(d@data$bottomTrack$altimeterDistance))

