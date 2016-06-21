## detailed check on ctdFindProfiles; plots reveal if OK
rm(list=ls())
library(oce)
library(testthat)
try(source('~/src/oce/R/ctd.R'))
## try(source('~/src/R-richards/oce/R/ctd.R'))

data(ctd)
N <- 3
ctd <- oceSetData(ctd, 'pressure', rep(c(ctd[['pressure']], rev(ctd[['pressure']])), N))
ctd <- oceDeleteData(ctd, 'depth')
ctd <- oceSetData(ctd, 'temperature', rep(c(ctd[['temperature']], rev(ctd[['temperature']])), N))
ctd <- oceSetData(ctd, 'salinity', rep(c(ctd[['salinity']], rev(ctd[['salinity']])), N))
ctd <- oceSetData(ctd, 'scan', seq_along(ctd[['pressure']]))
ctd <- oceDeleteData(ctd, 'flag')
ctd <- oceSetData(ctd, 'time', seq_along(ctd[['pressure']]))

smoother <- function (x, n = 11, ...) 
{
    f <- rep(1/n, n)
    xf <- as.numeric(stats::filter(x, f, ...))
}

DEBUG <- 110 # if >100, ctdFindProfiles() plots debugging info (secret feature that may disappear)
par(mfrow=c(2,1))
pr <- ctdFindProfiles(ctd)

## If salinities are equal, probably everything else is, also.
npr <- length(pr)
for (i in 2:npr) {
  expect_equal(pr[[i-1]][["salinity"]], pr[[i]][["salinity"]])
}

pr <- ctdFindProfiles(ctd, direction='ascending')
## If salinities are equal, probably everything else is, also.
## NOTE: the very first profile differs slightly from the others (it has 2 more points) so
## NOTE: we do not insist that it be correct.
if (npr > 1) {
    npr <- length(pr)
    for (i in 3:npr) {
        expect_equal(pr[[i-1]][["salinity"]], pr[[i]][["salinity"]], info=paste("salinities in profiles", i-1, "and", i, "do not match"))
    }
}


