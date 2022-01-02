library(oce)
library(testthat)
data(section)
expect_silent(plot(section, which="Rrho"))

