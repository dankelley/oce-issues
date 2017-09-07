library(oce)
library(testthat)

x <- as.ctd(c(35,35.1), c(10,11), c(10,20), longitude=-30, latitude=30)

for (eos in c("unesco", "gsw")) {
    options(oceEOS=eos)
    st <- x[["sigmaTheta"]]
    expect_true(all(is.finite(st[1])))
}

