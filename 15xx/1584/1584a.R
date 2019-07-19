library(oce)
data(section)
gs <- subset(section, 115<=stationId&stationId<=125)

if (!interactive()) png("1584a.png")
par(mfrow=c(3, 1))

##> gs[["longitude","byStation"]]
## [1] -70.6077 -70.8197 -71.0247 -71.2227 -71.3707 -71.5228 -71.7373 -71.9333
## [9] -72.1187 -72.2883 -72.4540

## > gs[["latitude","byStation"]]
## [1] 36.8930 36.9893 37.0843 37.1833 37.2697 37.3583 37.4080 37.4757 37.5530
##[10] 37.6227 37.7000

plot(gs, eos='unesco', which="temperature", xtype="distance", xlim=c(0, 400))
mtext(sprintf("distance from %.3fW %.3fN",
              -gs[["longitude"]][1], gs[["latitude"]][1]), cex=3/4, line=0.5)

lon0 <- -70.0
lat0 <- 36.5
plot(gs, eos='unesco', which="temperature", xtype="distance",
     longitude0=lon0, latitude0=lat0, xlim=c(0, 400))
mtext(sprintf("distance from %.3fW %.3fN",
              -lon0, lat0), cex=3/4, line=0.5)

plot(gs, which="map", span=800)
points(lon0, lat0, pch=20)
mtext(sprintf("filled symbol is %.3fW %.3fN", -lon0, lat0), cex=3/4, line=0.5)

if (!interactive()) dev.off()
