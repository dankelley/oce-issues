library(oce)
library(testthat)
d <- read.oce("18HU2010014_00003_00001_ct1.csv")
expect_equal(d[["pressureUnit"]], list(unit=expression(dbar), scale=""))
expect_equal(d[["temperatureUnit"]], list(unit=expression(degree*C), scale="IPTS-68"))
expect_equal(d[["salinityUnit"]], list(unit=expression(), scale="PSS-78"))
expect_equal(d[["oxygenUnit"]], list(unit=expression(mu*mol/kg), scale=""))

