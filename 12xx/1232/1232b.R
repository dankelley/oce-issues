## 1232b.R: mesh developed by interpolating on distance
## FIXME: decide on the factor in line 29, defining "N".

resolution <- 4                        # grid resolution [minutes]

library(oce)
data(section)
lon <- section[["longitude", "byStation"]]
lat <- section[["latitude", "byStation"]]

distance <- geodDist(lon, lat, alongPath=TRUE)
resolutionKm <- resolution / 60 * 111  # km

lonRange <- range(lon, na.rm=TRUE)
latRange <- range(lat, na.rm=TRUE)

## get grid that's a few grid points larger than data range
d <- 4 * resolution / 60
W <- round(lonRange[1] - d, 4) # 4 digits means 0.0001deg or 10m.
E <- round(lonRange[2] + d, 4)
S <- round(latRange[1] - d, 4)
N <- round(latRange[2] + d, 4)
topoFile <- download.topo(west=W, east=E, south=S, north=N, resolution=resolution)
topo <- read.topo(topoFile)

span <- geodDist(W, S, E, N)
## n = for approx
N <- 2 * round(span / resolutionKm)
n <- length(lon)
LON <- approx(1:n, lon, seq(1, n, length.out=N))$y
LAT <- approx(1:n, lat, seq(1, n, length.out=N))$y

B <- topoInterpolate(LON, LAT, topo)

if (!interactive()) png("1232b.png", width=7, height=5, unit="in", res=150, pointsize=10)
plot(section, which="salinity", xtype="longitude", ztype="image")
lines(LON, -B, col='blue', lwd=1.4)
if (!interactive()) dev.off()

