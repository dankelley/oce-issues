rm(list=ls())
library(oce)
if (!interactive()) png("636a.png")
par(mfrow=c(1,1))
data(topoWorld)
if (FALSE){
par(mfrow=c(2,1))
cm <- colormap(name="gmt_globe")
imagep(topoWorld, breaks=cm$breaks, col=cm$col)
cm <- colormap(name="gmt_globe", subdivisions=10)
str(cm)
#imagep(topoWorld, breaks=cm$breaks, col=cm$col)
imagep(topoWorld, colormap=cm)#breaks=cm$breaks, col=cm$col)
mtext("NOTE: broken near coastline (land bridge in Bering St)", font=2, col="purple")
if (!interactive()) dev.off()
}
#NEW TEST
cm <- colormap(x0=c(-5000,-1000,   0,1000),
               x1=c(-1000,    0,1000,2000),
               col0=col2rgb(c("purple","blue","white","brown")),
               col1=col2rgb(c("blue",  "white","brown","black")), debug=3)
str(cm)
imagep(topoWorld, breaks=cm$breaks, col=cm$col, xlim=360+c(-70,-20), ylim=c(10, 60), asp=1)
#imagep(topoWorld, colormap=cm, xlim=360+c(-70,-20), ylim=c(10, 60), asp=1)
