library(ncdf4)
library(oce)

file <- "h037a.nc" # Guam
url <- paste0("http://uhslc.soest.hawaii.edu/data/netcdf/rqds/pacific/hourly/", file)
if (!file.exists(file)) {
    message("downloading file")
    download.file(url, file)
} else {
    message("using cached file")
}
d <- nc_open(file)
stn <- ncvar_get(d, "station_name")[1]
lon <- ncvar_get(d, "lon")[1]
lat <- ncvar_get(d, "lat")[1]
# Guess that timezone is UTC, sealevel in mm (easy to check)
time <- 86400 * ncvar_get(d, "time") + as.POSIXct("1800-01-01 00:00:00", tz="UTC")
eta <- 0.001 * ncvar_get(d, "sea_level")
#Timing test> #png("guam_%2d.png")
#Timing test> t1 <- system.time(plot(time, eta, type="p"))[1]
#Timing test> t2 <- system.time(oce.plot.ts(time, eta, type="p"))[1]
#Timing test> t3 <- system.time(oce.plot.ts(time, eta, type="p", simplify=NA))[1]
#Timing test> t4 <- system.time(oce.plot.ts(time, eta, type="p", simplify=NA, axes=FALSE))[1]
#Timing test> t5 <- system.time(oce.plot.ts(time, eta, type="p", simplify=NA, drawTimeRange=FALSE))[1]
#Timing test> cat(sprintf("Elapsed times: R=%.1f oce=%.1f oceSimplify=%.1f oceSimplifyNoAxis=%.1f noTimeRange=%.1f\n", t1, t2, t3, t4, t5))
#Timing test> 

t <- as.POSIXlt(time)
oce.plot.ts(t, eta)

