library(oce)
data(coastlineWorld)

if (!interactive()) png("518D.png", width=8.5, height=7, unit="in", res=150, pointsize=9, type="cairo", antialias="none")

par(mfrow=c(2,1), mar=c(2, 2, 1, 1), mgp=c(2, 0.7, 0))
lon<-coastlineWorld[['longitude']]
lat<-coastlineWorld[['latitude']]

proj <- "stereographic"
mapPlot(coastlineWorld, longitudelim=c(-130,180-130), latitudelim=c(90-30,90+30), proj=proj)
mtext(proj, font=2, col="purple", adj=0)

## in next, can give +lon_0 if desired; giving +lat_ts has no effect
proj <- "+proj=stere +lat_0=90"
## in next, note what I'm doing with image points; this should go in docs
mapPlot(coastlineWorld, longitudelim=c(-130,180-130), latitudelim=c(90-30,90+30), proj=proj)
mtext(proj, font=2, col="purple", adj=0)

#mapPlot(coastlineWorld, longitudelim=c(-130,-50), latitudelim=c(70,110), proj=proj)
#mtext(proj, font=2, col="purple", adj=0)
#mapPlot(coastlineWorld, longitudelim=c(-130,-50), latitudelim=c(70,110), proj=proj)
#mtext(proj, font=2, col="purple", adj=0)


if (!interactive()) dev.off()
