library(oce)
# DK to CR: looks like our file structure differs.
data(ctd)
set.seed(669)
n <- length(ctd[["salinity"]])
lon <- ctd[["longitude"]] + rnorm(n, sd=0.05)
lat <- ctd[["latitude"]] + rnorm(n, sd=0.05)
## ctdnew <- as.ctd(ctd[['salinity']], ctd[['temperature']], ctd[['pressure']],
##                  longitude = lon, latitude = lat)
ctdnew <- ctd
## DK to CR: I have moved longitude to data, so I've altered next 2 lines.
ctdnew@data$longitude <- lon
ctdnew@data$latitude <- lat
ctdnewSubset <- subset(ctdnew, 200 <= scan & scan <= 300)
ctdnewTrim <- ctdTrim(ctdnew, method='scan', parameters = c(200, 300))
if (!interactive()) png("669b_1.png")
plot(ctd)
if (!interactive()) dev.off()
if (!interactive()) png("669b_2.png")
plot(ctdnew)
if (!interactive()) png("669b_3.png")
plot(ctdnewSubset, main='Trimmed with subset')
if (!interactive()) png("669b_4.png")
plot(ctdnewTrim, main='Trimmed with ctdTrim')
if (!interactive()) dev.off()

## DK to CR: I added a strong test (better than looking at graphs)
stopifnot(all.equal(length(ctdnewSubset[['scan']]), length(ctdnewSubset[['longitude']])))
