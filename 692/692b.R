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
ctd <- as.ctd(rsk)
ctdManual <- as.ctd(ctd[['salinity']], ctd[['temperature']], ctd[['pressure']])

expect_equal(ctd[['longitude']], ctdManual[['longitude']])
expect_equal(ctd[['latitude']], ctdManual[['latitude']])
