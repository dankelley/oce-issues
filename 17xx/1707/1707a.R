library(oce)
data("coastlineWorld")
proj <- "+proj=merc"
lonlim <- c(-20, 20)
latlim <- c(-20, 20)
if (!interactive()) png("1707a.png", width=7, height=5, res=120, unit="in")
par(mfrow=c(2, 3), mar=c(2,2,1,1))
for (axisStyle in 1:5) {
    mapPlot(coastlineWorld, longitudelim=lonlim, latitudelim=latlim,
            col="tan", proj=proj, axisStyle=axisStyle, grid=c(5,5))
    mtext(paste0("axisStyle=", axisStyle), cex=par("cex"))
}
plot(0:1,0:1,xlab="",ylab="",axes=FALSE,type="n")
box()
text(0.5,0.5,"Test of\nmapPlot(...,axisType)\n(github issue 1707)")
if (!interactive()) dev.off()

