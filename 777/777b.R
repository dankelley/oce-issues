library(oce)
library(testthat)
try(source("~/src/oce/R/adp.R"))
try(source("~/src/oce/R/adp.rdi.R"))
file <- "MS2015-150kHz002_000001.ENX"
if (1 == length(list.files(pattern="*.ENX"))) {
    ## easier to debug without skipping through the file
    d <- read.adp.rdi(file, from=1, to=4, debug=999) ## 999 browses read.adp.rdi()
    expect_true('br' %in% names(d@data), info="This file should have bottom range, br")
    expect_true('bv' %in% names(d@data), info="This file should have bottom velocity, bv")
} else {
    message("cannot run the test in 777a.R because it needs a file named ", file)
}
