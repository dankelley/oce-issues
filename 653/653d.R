library(oce)
data(coastlineWorld)
lon <- coastlineWorld[["longitude"]]
lat <- coastlineWorld[["latitude"]]

n <- length(lon)-1

library(rgdal)
## NOTE: need to cast 'n'; this is not hinted at in the (sparse) docs
xy <- rawTransform(projfrom="+proj=longlat", projto="+proj=moll",
                   n=as.integer(n), x=lon[1:n], y=lat[1:n])
par(mfrow=c(2,1))
plot(xy[[1]], xy[[2]], asp=1, type='l')
ll <- rawTransform(projfrom="+proj=moll", projto="+proj=longlat",
                   n=as.integer(n), x=lon[1:n], y=lat[1:n])
plot(ll[[1]], ll[[2]], asp=1, type='l')
