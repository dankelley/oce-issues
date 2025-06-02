library(oce)
file <- "~/S102791A003_Barrow_2022_0001_sub.ad2cp"
if (file.exists(file)) {
    bar <- read.adp.ad2cp(file, dataType = "burstAltimeterRaw")
    start <- as.POSIXct("2022-08-16 17:16:00", tz = "UTC")
    sub <- subset(bar, time >= start, debug = 1)
    str(bar@data)
    str(sub@data)
    stopifnot(415L == length(sub[["altimeterRawTime"]]))
    stopifnot(identical(dim(sub[["altimeterRawSamples"]]), c(length(sub[["altimeterRawTime"]]), sub[["altimeterRawNumberOfSamples"]])))
    stopifnot(identical(length(bar[["altimeterRawDistance"]]), length(sub[["altimeterRawDistance"]])))
    stopifnot(identical(1L, length(sub[["altimeterRawNumberOfSamples"]])))
    stopifnot(identical(1L, length(sub[["altimeterRawBlankingDistance"]])))
    stopifnot(identical(1L, length(sub[["altimeterRawSampleDistance"]])))
} else {
    message("This test is only for developers, because it relies on the existence of a particular file.")
}
