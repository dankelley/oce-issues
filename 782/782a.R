library(oce)
library(testthat)
try(source("~/src/oce/R/adp.R"))
try(source("~/src/oce/R/adp.rdi.R"))
file <- "MS2015-150kHz002_000001.ENX"
if (1 == length(list.files(pattern="*.ENX"))) {
    d <- read.adp.rdi(file, from=1, to=3, debug=3)
    expect_true('firstLongitude' %in% names(d@data), info="This file should have longitude, firstLongitude")
    expect_true('firstLatitude' %in% names(d@data), info="This file should have latitude, firstLatitude")
} else {
    message("cannot run the test in 782a.R because it needs a file named ", file)
}
