library(oce)
data(coastlineWorld)
lon <- coastlineWorld[["longitude"]]
lat <- coastlineWorld[["latitude"]]
mapPlot(coastlineWorld, projection="+proj=wintri +lon_0=70")
look <- lat < -60
mapLines(lon[look], lat[look], col='red')
mapPoints(lon[look], lat[look], col='red', pch=20)
aalon <- lon[look]
aalat <- lat[look]
xy <- lonlat2map(aalon, aalat)
scale <- 1 / cos(mean(aalat, na.rm=TRUE) * pi / 180)
d <- geodDist(lon1=aalon,lat1=aalat,along=TRUE)
D <- sqrt(diff(xy$x)^2 + diff(xy$y)^2)
dx <- abs(diff(xy$x))
dx <- c(dx[1], dx) # FIXME: off by one?
D <- c(D, 0)
dD <- D/dx
## bad outliers
dD_sd <- sd(dD, na.rm=TRUE)
if (5 < max(dD,na.rm=TRUE)/dD_sd) {
    bad <- dD > 5*dD_sd
    i <- which.max(dD) + seq.int(-3,3)
    print(data.frame(dD=dD[i],aalon=aalon[i],aalat=aalat[i],x=xy$x[i],y=xy$y[i],bad=bad[i]))
    ibad <- seq_along(aalon)[bad]
    AAlon <- aalon
    AAlat <- aalat
    AAlon[bad] <- NA
    AAlat[bad] <- NA
}
mapLines(AAlon, AAlat, col='blue')

