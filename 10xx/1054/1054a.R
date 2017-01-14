library(oce)
source("~/src/oce/R/section.R")
source("~/src/oce/R/sw.R")
library(testthat)
if (1 == length(list.files(pattern="^LADCPall.rda$"))) {
    load("LADCPall.rda")
    s <- as.section(ladcp)
    salinity <- s[["salinity"]]
    temperature <- s[["temperature"]]
    pressure <- s[["pressure"]]
    stManual <- swSigmaTheta(salinity, temperature, pressure)
    st <- s[["sigmaTheta"]]
    expect_equal(st, stManual)
} else {
    message("a private file is required to perform the tests in 10541.R")
}
