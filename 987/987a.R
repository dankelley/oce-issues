rm(list=ls())
library(oce)
try(source('~/src/oce/R/ctd.R'))
try(source('~/src/R-richards/oce/R/ctd.R'))

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
    xf <- as.numeric(stats::filter(x, f, ...))
}

pr <- ctdFindProfiles(ctd)
print('smoother = smooth.spline')
print(paste0('Number of profiles found (of ', N, '): ', length(pr)))

pr <- ctdFindProfiles(ctd, smoother=smooth, cutoff=0.1)
print('smoother = smooth')
print(paste0('Number of profiles found (of ', N, '): ', length(pr)))

pr <- ctdFindProfiles(ctd, smoother=smoother)
print('smoother = custom moving average')
print(paste0('Number of profiles found (of ', N, '): ', length(pr)))
