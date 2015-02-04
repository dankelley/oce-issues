rm(list=ls())
library(oce)

## create some fake data that spans the better part of a year
trange1 <- as.POSIXct(c("2010-07-02 16:00:32", "2010-07-31 00:00:48"), tz='UTC')
trange2 <- as.POSIXct(c("2010-07-02 16:00:32", "2010-10-16 00:00:48"), tz='UTC')
trange3 <- as.POSIXct(c("2010-07-02 16:00:32", "2011-05-16 00:00:48"), tz='UTC')
trange4 <- as.POSIXct(c("2010-07-02 16:00:32", "2012-05-16 00:00:48"), tz='UTC')
trange5 <- as.POSIXct(c("2010-07-02 16:00:32", "2022-05-16 00:00:48"), tz='UTC')

if (!interactive()) png('01-%03d.png', width=1000, height=400)

nt <- length(grep('trange', ls()))
for (i in 1:nt) {
    trange <- get(ls()[grep('trange', ls())[i]])
    ## create a time vec
    timeConst <- seq(trange[1], trange[2], length.out=100)

    ## create a data matrix
    p <- seq(50, 900)
    d <- matrix(rnorm(length(p)*length(timeConst)), nrow=length(timeConst))

    imagep(timeConst, p, d)
    grid(col=1)
    rm(trange)
}

if (!interactive()) dev.off()
