## Find world coastline islands

if (!interactive()) pdf("388I.pdf", width=7, height=3.5, pointsize=8)
library(oce)
data(coastlineWorld)
lon <- coastlineWorld[['longitude']]
lat <- coastlineWorld[['latitude']]
system("R CMD SHLIB find_islands.c")
dyn.load("find_islands.so")
i <- .Call("find_islands", lon, lat, 120)
# lon[i$begin[1]:i$end[1]]
# lon[i$begin[2]:i$end[2]]
i
par(mar=c(2, 2, 1, 1), mgp=c(2, 0.7, 0))
plot(c(-180, 180), c(-90, 90), type='n', asp=1, xlab="", ylab="")
for (is in seq_along(i$begin)) {
   span <- seq.int(i$begin[is], i$end[is])
   polygon(lon[span], lat[span], col=1+is%%10, lwd=1/4)
}

if (!interactive()) dev.off()

