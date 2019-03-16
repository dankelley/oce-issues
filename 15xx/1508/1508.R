library(oceanglider)
if (!exists("g")) {
    file <- "~/Dropbox/sea021m49/netcdf/GLI2018_SEA021_049DM_L1.nc"
    ## file <- "/data/archive/glider/2019/sx/sea021m49/netcdf/GLI2018_SEA021_049DM_L1.nc"
    g <- read.glider(file)
    head(g[["time"]], 10)
    ## The above shows that we have a few (4) points from 2018-07-12 at the start,
    ## followed by data on 2019-02-22, so we subset for just the later data.
    start <- as.POSIXct("2019-02-21")
    g <- subset(g, time > start)
    g  <- subset(g, salinity < 40)
}

par(mfrow=c(2,1))
focus <- as.POSIXct(c('2019-02-27', '2019-03-05'), tz='UTC')
oce.plot.ts(g[['time']], g[['pressure']], xlim=focus)
focus <- as.POSIXct(c('2019-02-27', '2019-02-28'), tz='UTC')
oce.plot.ts(g[['time']], g[['pressure']], xlim=focus)

