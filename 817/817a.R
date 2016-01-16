library(oce)
library(testthat)
try(source("~/src/oce/R/ctd.R"))
try(source("~/src/oce/R/section.R"))
data(argo)
#summary(argo)
## fake some sigma-theta data
S2 <- argo[['salinity']] / 2
argo <- oceSetData(argo, "S2", S2, unit=list(unit=expression(), scale="PSS-78"))
expect_true("S2" %in% names(argo@data))
expect_equal(list(unit=expression(),scale="PSS-78"), argo[["S2Unit"]])
summary(argo)                          # visual check: are units ok?

s <- as.section(argo)
station1 <- s[["station", 1]]
summary(station1)                      # visual check: are units ok?

expect_true("S2" %in% names(station1@data))
expect_equal(list(unit=expression(),scale="PSS-78"), station1[["S2Unit"]])

