library(oce)
library(testthat)
try(source("~/src/oce/R/adp.R"))
try(source("~/src/oce/R/adp.rdi.R"))
file <- "ADCP064_000000.ENX"
if (1 == length(list.files(pattern="*.ENX"))) {
    d <- read.adp.rdi(file)#, debug=3)
    expect_true('br' %in% names(d@data), info="This file should have bottom range, br")
    expect_true('bv' %in% names(d@data), info="This file should have bottom velocity, bv")
    expect_true('firstLongitude' %in% names(d@data), info="This file should have firstLongitude")
    expect_true('firstLatitude' %in% names(d@data), info="This file should have firstLatitude")
    expect_true('lastLongitude' %in% names(d@data), info="This file should have lastLongitude")
    expect_true('lastLatitude' %in% names(d@data), info="This file should have lastLatitude")
} else {
    message("cannot run the test in 782a.R because it needs a file named ", file)
}
