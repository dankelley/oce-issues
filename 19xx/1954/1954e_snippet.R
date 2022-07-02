# Ideas for formal tests
options(digits=15) # for making tests
library(oce)
library(testthat)
f <- "barrow_snippet.ad2cp"
d <- read.adp.ad2cp(f, debug=1)
A <- d@data$burstAltimeterRaw
str(A,1)
expect_equal(1833L, A$altimeterRawNumberOfSamples)
expect_equal(c(1L, 1833L), dim(A$altimeterRawSamples))
expect_equal(c(2313,2560,2313,3743), A$altimeterRawSamples[1,1:4])
expect_equal(0.024, A$altimeterRawSampleDistance)
expect_equal(42.0308685302734, A$altimeterDistance)
expect_equal(as.POSIXct("2022-05-25 11:54:45.000",tz="UTC"), A$time[1])
expect_equal(as.POSIXct("2022-05-25 11:54:45.000",tz="UTC"), A$time)
expect_equal(30L, length(d@data$burst))
str(d@data$burst)
expect_equal(42.0308685302734, d@data$burst$altimeterDistance)

# burst
expect_equal(0.807, d@data$burst$pressure)

# average
expect_equal(c(1,87,4), dim(d@data$average$v))

