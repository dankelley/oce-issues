if (!interactive()) png("635e.png")
p <- "+proj=gstmerc"
cmd <- paste("gzcat coastline.dat.gz|sed -e s/NA/-999/g|proj ", p, "|sed -e s/[*]/NA/g > xy.dat", sep="")
system(cmd)
xy <- read.table("xy.dat", header=FALSE, col.names=c("lon", "lat"))
par(mfrow=c(2,1), mar=c(3, 3, 1, 1), mgp=c(2, 0.7, 0))
plot(xy$lon, xy$lat, asp=1, type='l')
L <- 1e7
plot(xy$lon, xy$lat, asp=1, type='l', xlim=c(-L, L), ylim=c(-L,L))
if (!interactive()) dev.off()

