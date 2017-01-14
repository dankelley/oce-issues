## Isolate Australia for testing.

if (!interactive()) pdf("388G.pdf", height=2)
library(oce)
data(coastlineWorld)
lon <- coastlineWorld[['longitude']]
lat <- coastlineWorld[['latitude']]

## Isolate Australia as a test case that might be scannable in an editor
lonlim <- c( 109, 157)
latlim <- c(-39, -10.3)
aus <- lonlim[1] < lon & lon < lonlim[2] & latlim[1] < lat & lat < latlim[2]
aus <- aus & !(lon > 149 & lat > -11)
message("Aus starts at index ", which(aus)[1])
par(mfrow=c(1,3))
plot(lon[aus], lat[aus], type='l', asp=1)
points(143.5, -13.6, col='red', cex=2)
text(143.5, -13.6, 'break?', col='red', pos=4)

plot(lon[aus], lat[aus], type='l', asp=1)
polygon(lon[aus], lat[aus], col='lightgray')

## Further hand edit to remove lots of NAs.
ca <- as.coastline(lon[aus][20:241], lat[aus][20:241], TRUE)
plot(ca)
## points(ca[['longitude']][1:2], ca[['latitude']][1:2],
##        cex=2, col=c("red","blue"))
points(ca[['longitude']][1], ca[['latitude']][1], cex=2, col="red")
mtext(" clockwise from red point", adj=0, line=-1.5)
save(ca, file="coastlineAustralia.rda")
if (!interactive()) dev.off()

