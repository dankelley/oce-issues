library(oce)
data(section)
lon <- section[["longitude", "byStation"]]
lat <- section[["latitude", "byStation"]]
lonRange <- range(lon, na.rm=TRUE)
latRange <- range(lat, na.rm=TRUE)
resolution <- 4 # minutes

## get grid that's a few grid points larger than data range
d <- 4 * resolution / 60
W <- round(lonRange[1] - d, 4) # 4 digits means 0.0001deg or 10m.
E <- round(lonRange[2] + d, 4)
S <- round(latRange[1] - d, 4)
N <- round(latRange[2] + d, 4)
topoFile <- download.topo(west=W, east=E, south=S, north=N, resolution=resolution)
topo <- read.topo(topoFile)

## double-sample lon and lat (awkward -- must be a cleaner way that
## will generalize better)
n <- length(lon)
m <- rbind(lon[-n], lon[-n]+diff(lon)/2)
LON <- c(as.vector(m), lon[n])

m <- rbind(lat[-1], lat[-1]+diff(lat)/2)
m <- rbind(lat[-n], lat[-n]+diff(lat)/2)
LAT <- c(as.vector(m), lat[n])

b <- topoInterpolate(lon, lat, topo)
B <- topoInterpolate(LON, LAT, topo)

if (!interactive()) png("1232a.png", width=7, height=5, unit="in", res=150, pointsize=10)
plot(section, which="salinity", xtype="longitude")
lines(lon, -b, col='red')
lines(LON, -B, col='blue')
if (!interactive()) dev.off()

