library(oce)
library(ncdf4)
data(coastlineWorld)

nc <- nc_open('velpot.2200_2300.850.ensmean.nc')
lon <- ncvar_get(nc, 'lon')
lat <- ncvar_get(nc, 'lat')
vel <- ncvar_get(nc, 'velopot')

II <- lon > 180
velnew <- rbind(vel[II, ], vel[!II, ])
lonnew <- lon - 180

mapPlot(coastlineWorld, col='grey')
mapContour(lonnew, lat, velnew)
