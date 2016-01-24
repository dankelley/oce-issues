library(oce)
library(testthat)
if (!length(ls(pattern='^d$')))
    d <- read.amsr("f34_20160102v7.2.gz")
## Test accessors (sensible for temperature?)
median(d[["SSTDay"]], na.rm=TRUE)
median(d[["SSTNight"]], na.rm=TRUE)

## Visual test: units OK?
summary(d)

## Plot default and named channels
if (!interactive()) png("839a.png", pointsize=9)
par(mfrow=c(3,1))
plot(d, col=oceColorsJet) # default SSTDay
lon <- d[["longitude"]]
lat <- d[["latitude"]]
loni <- 1272
lati <- 580
points(lon[loni], lat[lati])
plot(d, 'SSTNight', col=oceColorsJet)
points(lon[loni], lat[lati])
plot(d, 'SST', col=oceColorsJet)
points(lon[loni], lat[lati])
if (!interactive()) dev.off()

## Check whether 'raw' access OK
expect_true(is.numeric(d[['SSTDay']][loni,lati]))
expect_true(is.raw(d[['SSTDay','raw']][loni,lati]))
d[['SSTDay']][loni,lati]
d[['SSTNight']][loni,lati]
d[['SST']][loni,lati]
plot(d, 'SST', col=oceColorsJet)
