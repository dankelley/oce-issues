rm(list=ls())
library(oce)
library(testthat)
## try(source('~/src/oce/R/ctd.R'))
## try(source('~/src/R-richards/oce/R/ctd.R'))

data(ctd)
N <- 200
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

pr <- ctdFindProfiles(ctd)
npr <- length(pr)
print('smoother = smooth.spline')
print(paste0('Number of profiles found (of ', N, '): ', npr, " (expect disagreement with smooth.spline)"))

pr <- ctdFindProfiles(ctd, smoother=smooth, cutoff=0.1)
npr <- length(pr)
print('smoother = smooth')
print(paste0('Number of profiles found (of ', N, '): ', npr))
expect_equal(N, npr)

pr <- ctdFindProfiles(ctd, smoother=smoother)
npr <- length(pr)
print('smoother = custom moving average')
print(paste0('Number of profiles found (of ', N, '): ', npr))
expect_equal(N, npr)

##> ## If salinities are equal, probably everything else is, also.
##> ## NOTE: the very first profile differs slightly from the others (it has 2 more points) so
##> ## NOTE: we do not insist that it be correct.
##> if (npr > 1) {
##>     for (i in 2:length(pr)) {
##>         expect_equal(pr[[i-1]][["salinity"]], pr[[i]][["salinity"]], info=paste("salinities in profiles", i-1, "and", i, "do not match"))
##>     }
##> }
