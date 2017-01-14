## try C code to insert NA between far-distant points
if (!interactive()) pdf("388C.pdf", pointsize=9)
library(oce)
library(mapproj)
data(coastlineWorld)
lon <- coastlineWorld[['longitude']]
lat <- coastlineWorld[['latitude']]

par(mfrow=c(2,2), mar=c(3, 3, 1, 1), mgp=c(2, 0.7, 0))
xy <- mapproject(coastlineWorld[['longitude']], coastlineWorld[['latitude']], proj="mollweide")
plot(xy$x, xy$y, type='l', asp=1)
mtext("EXPECT: spurious lines", side=3, font=2, col='purple', line=-1.5)
system("R CMD SHLIB fixcoast.c")
dyn.load('fixcoast.so')
xy2 <- .Call("fixcoast", xy$x, xy$y, 0.2)
print(length(lon))

xy$x[1:10]
xy2$x[1:10]
plot(xy2$x, xy2$y, type='l', asp=1)
mtext("EXPECT: no spurious lines", side=3, font=2, col='purple', line=-1.5)

plot(diff(xy$x), type='l')
mtext("EXPECT: a few big x shifts", side=3, font=2, col='purple', line=-1.5)
plot(diff(xy2$x), type='l')
mtext("EXPECT: no big x shifts", side=3, font=2, col='purple', line=-1.5)

if (!interactive()) dev.off()
