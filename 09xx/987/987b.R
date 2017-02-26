## detailed check on ctdFindProfiles; plots reveal if OK
rm(list=ls())
library(oce)
library(testthat)

data(ctd)
N <- 4
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
    stats::filter(x, f, ...)
}

if (!interactive()) png("987b.png")
DEBUG <- 110 # if >100, ctdFindProfiles() plots debugging info (secret feature that may disappear)
par(mfrow=c(2,1))
pr <- ctdFindProfiles(ctd, debug=DEBUG)
expect_equal(length(pr), N)

pr <- ctdFindProfiles(ctd, direction='ascending', debug=DEBUG)
expect_equal(length(pr), N)

##> ## If salinities are equal, probably everything else is, also.
##> ## NOTE: the very first profile differs slightly from the others (it has 2 more points) so
##> ## NOTE: we do not insist that it be correct.
##> if (npr > 1) {
##>     for (i in 3:npr) {
##>         expect_equal(pr[[i-1]][["salinity"]], pr[[i]][["salinity"]], info=paste("salinities in profiles", i-1, "and", i, "do not match"))
##>     }
##> }


if (!interactive()) dev.off()
