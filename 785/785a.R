## originally ../777/777a.R
library(oce)
library(testthat)
try(source("~/src/oce/R/adp.R"))
try(source("~/src/oce/R/adp.rdi.R"))
file <- "MS2015-150kHz002_000001.ENX"
if (1 == length(list.files(pattern="*.ENX"))) {
    d <- read.adp.rdi(file,
                      from=as.POSIXct("2015-09-19 14:00:00", tz="UTC"),
                      to=as.POSIXct("2015-09-19 14:30:00", tz="UTC"),
                      latitude =49.303950 ,longitude =-67.387133, debug=3)
    expect_true('br' %in% names(d@data), info="This file should have bottom range, br")
    expect_true('bv' %in% names(d@data), info="This file should have bottom velocity, bv")
} else {
    message("cannot run the test in 777a.R because it needs a file named ", file)
}
