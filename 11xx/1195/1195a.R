library(oce)
library(testthat)

try(source("~/git/oce/R/oce.R"))
try(source("~/git/oce/R/ctd.R"))
try(source("~/git/oce/R/ctd.woce.R"))

woce <- read.oce("18HU20130507_00235_00001_ct1.csv")
summary(woce)

expect_equal(woce[["pressureUnit"]], list(unit=expression(dbar), scale=""))
expect_equal(woce[["temperatureUnit"]], list(unit=expression(degree*C), scale="IPTS-68"))
expect_equal(woce[["salinityUnit"]], list(unit=expression(), scale="PSS-78"))
expect_equal(woce[["oxygenUnit"]], list(unit=expression(mu*mol/kg), scale=""))

expect_gt(min(woce[["temperature"]], na.rm=TRUE), -2)
expect_gt(min(woce[["salinity"]], na.rm=TRUE), 0)
