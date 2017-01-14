## test creation of pressure [dbar] from pressure [PSI], using
## the constructed file ctd_with_psi.cnv (in which the pressure column
## was calculated and inserted into the file, and in which also the
## header line was changed to say that pressure is in English units.
library(oce)
library(testthat)
d1 <- read.oce("ctd.cnv")
d2 <- read.oce("ctd_with_psi.cnv")
## use 1e-5 to reflect the number of digits I was using in creating
## and then cut/pasting the fake data
expect_equal(d1[["pressure"]], d2[["pressure"]], tolerance=1e-5)


