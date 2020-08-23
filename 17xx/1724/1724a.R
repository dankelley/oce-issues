library(oce)
data(coastlineWorld)
testMap <- function(axisStyle)
{
    t <- system.time(mapPlot(coastlineWorld,
                              longitudelim=c(-10,10),
                              latitudelim=c(40,60),
                              col="tan",
                              projection="+proj=aea +lat_1=20 +lat_2=50",
                              axisStyle=axisStyle))
    print(t)
    mtext(paste0("axisStyle=",axisStyle), cex=par("cex"))
}

if (!interactive()) png("1724a.png", pointsize=18)
par(mfrow=c(2,3), mar=c(2,2,1,1))
for (axisStyle in 1:5)
    testMap(axisStyle)

if (!interactive()) dev.off()

