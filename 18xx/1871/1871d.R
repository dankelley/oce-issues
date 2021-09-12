library(oce)
data(coastlineWorld)
debug <- 1
# 1. show a proj that works
lon <- coastlineWorld[["longitude"]]
lat <- coastlineWorld[["latitude"]]
p1 <- "+proj=ortho +lat_0=0 +lon_0=0 +x_0=0 +y_0=0 +datum=WGS84 +units=m +no_defs +f=0 +a=6371"
p0 <- "+proj=longlat +datum=WGS84 +no_defs +f=0 +a=6371"
sf::sf_project(p0, p1, cbind(0,0))
LL <- sf::sf_project(p0, p1, cbind(lon,lat), keep=TRUE)
if (!interactive()) png("1871d.png")
par(mfrow=c(1,2))
plot(LL[,1], LL[,2], type="p", asp=1)

# 2. try this in oce
source("~/git/oce/R/map.R")
p0 <- "+proj=longlat +datum=WGS84 +no_defs +f=0" # drop +a to test
mapPlot(coastlineWorld, projection="+proj=ortho", debug=debug)

if (!interactive()) dev.off()

