library(oce)
set.seed(1678)
data(section)
s <- subset(section, longitude<=-60)
lon <- s[["longitude", "byStation"]]
lat <- s[["latitude", "byStation"]]
asp <- 1 / cos(pi/180*mean(range(lat)))
## spline <- locator(3)

if (!interactive()) png("1678a_%d.png", width=7, height=3, unit="in", res=150, pointsize=9)
par(mar=c(3,3,2,1), mgp=c(2,0.7,0))
plot(lon, lat, asp=asp, xlim=c(-5,5)+range(lon))
spine <- list(lon=c(-77, -69.2, -55), lat=c(39.7, 36.25, 36.25))
lines(spine$lon, spine$lat, col="blue")
mtext("Unpertubed data, with spine shown")

lon <- lon + rnorm(length(lon), sd=0.5)
lat <- lat + rnorm(length(lat), sd=0.5)

t <- seq(0, 1, length.out=length(spine$lon))
lonfun <- approxfun(spine$lon ~ t)
latfun <- approxfun(spine$lat ~ t)


D <- function(t) # uses global i
{
    lonSpine <- lonfun(t)
    latSpine <- latfun(t)
    geodDist(lonSpine, latSpine, lon[i], lat[i])

}
t <- seq(0, 1, length.out=1000)
closest <- rep(NA, length=length(lon))
for (i in seq_along(lon)) {
    closest[i] <- which.min(sapply(t, D))
}

df <- data.frame(lon=lon, lat=lat, lonClosest=lonfun(t[closest]), latClosest=latfun(t[closest]))
plot(df$lonClosest, df$latClosest, asp=asp, type="p", pch=20, cex=0.8, col=4)
lines(spine$lon, spine$lat, col=4)
segments(df$lon, df$lat, df$lonClosest, df$latClosest, col=2)
points(df$lon, df$lat, col=2, pch=20, cex=0.8)
mtext("demo, with lon and laat perturbed")

if (!interactive()) dev.off()

