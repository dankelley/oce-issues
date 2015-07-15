## https://github.com/dankelley/oce/issues/692

library(oce)
library(testthat)
try(source("~/src/oce/R/ctd.R")) # DK uses for faster code-test cycle

## PART 1: rsk conversion
file <- system.file("extdata", "sample.rsk.gz", package="oce")
tmp <- tempfile(fileext=".rsk")
requireNamespace("R.utils")
R.utils::decompressFile(file, destname=tmp, ext="gz", FUN=gzfile, remove=FALSE)
rsk <- read.rsk(tmp)
rsk[["filename"]] <- "sample.rsk" # trick it ... otherwise a tmp file
ctd1 <- as.ctd(rsk)

expect_equal(ctd1[["filename"]], rsk[["filename"]])
expect_equal(ctd1[["serialNumber"]], rsk[["serialNumber"]])
expect_null(ctd1[["waterDepth"]])

mnames <- sort(c("pressure", "temperature", "salinity", "conductivity", "sigmaTheta"))
##, "temperatureUnit", "conductivityUnit"))
expect_equal(mnames, sort(ctd1[["names"]]))
mlabels <- sort(c("Pressure", "Temperature", "Salinity", "Conductivity", "Sigma Theta"))
expect_equal(mlabels, sort(ctd1[["labels"]]))
expect_equal(rsk[["temperatureUnit"]], ctd1[["temperatureUnit"]])
expect_equal("ITS-90", ctd1[["temperatureUnit"]])
expect_equal("mS/cm", ctd1[["conductivityUnit"]])

## PART 2: with columnar data
ctd2 <- as.ctd(1:10, 1:10, 1:10)
expect_equal(sort(c("labels", "latitude", "longitude", "names" , "temperatureUnit", "conductivityUnit")),
             sort(names(ctd2@metadata)))
expect_null(ctd2[["waterDepth"]])
expect_equal("ITS-90", ctd2[["temperatureUnit"]])
expect_equal("ratio", ctd2[["conductivityUnit"]])

