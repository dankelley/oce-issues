rm(list=ls())
inc <- 2 # 0.5
pch <- 20
cex <- 1/4
grid <- expand.grid(lon=seq(-180, 180, inc), lat=seq(-90, 90, inc), KEEP.OUT.ATTRS=FALSE)
write.table(grid, file="lonlat.dat", row.names=FALSE, col.names=FALSE)
system("cat lonlat.dat | proj +proj=ortho +ellps=WGS84 | sed -e 's/*/NA/g' > xy.dat")
xy <- read.table("xy.dat", col.names=c("x", "y"), header=FALSE)
d <- data.frame(lon=grid$lon, lat=grid$lat, x=xy$x, y=xy$y)
write.table(d, file="616d_results.dat", row.names=FALSE)
if (!interactive()) png("616d.png", unit="in", width=6, height=3, res=150, pointsize=7)
par(mfrow=c(1,2), mar=c(3, 3, 1, 1), mgp=c(2, 0.7, 0))
plot(d$x, d$y, asp=1, pch=pch, cex=cex, col='red')
## using 'o' avoids overpainting, which made it look like the N pole
## had several non-NA cases out of scene.
set.seed(123)
o <- sample(length(d$lon))
plot(d$lon[o], d$lat[o], col=ifelse(!is.finite(d$x[o]), "gray", "red"), pch=pch, cex=cex)
mtext("gray: projected point is NA", side=3, line=0, adj=1)
if (!interactive()) dev.off()
