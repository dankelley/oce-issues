## Demonstrate how to detect various NA types in amsr data
library(oce)
earth <- read.amsr("../839/f34_20160102v7.2.gz")
save(earth, file="earth.rda")
fclat <- subset(earth , 35 <= latitude & latitude <= 55)
fc <- subset(fclat , -65 <= longitude & longitude <= -35)
if (!interactive()) png("2014b.png", width=600, height=600)
par(mfrow=c(2,2))
plot(fc)
d <- fc[["SSTDay", "raw"]]
n <- fc[["SSTNight", "raw"]]
lon <- fc[["longitude"]]
lat <- fc[["latitude"]]
asp <- 1 / cos(pi*mean(lat)/180)
## as.raw(0xff)| # land mass
## as.raw(0xfe)| # no observations
## as.raw(0xfd)| # bad observations
## as.raw(0xfc)| # sea ice
## as.raw(0xfb) # missing SST or wind due to rain, or missing water vapour due to heavy rain
imagep(lon, lat, d==as.raw(0xfb), asp=asp, main='day is rainy')
imagep(lon, lat, n==as.raw(0xfb), asp=asp, main='night is rainy')
imagep(lon, lat, n==as.raw(0xfb)&d==as.raw(0xfb), asp=asp, main='day AND night are rainy')

if (!interactive()) dev.off()

