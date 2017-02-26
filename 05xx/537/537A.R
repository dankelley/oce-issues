if (!interactive()) png("537A.png")
library(oce)
data(coastlineWorld)
mapPlot(coastlineWorld, longitudelim=c(-120,-50), latitudelim=c(30,50),
        projection="mercator", grid=TRUE, debug=10)
mtext("EXPECT: a grid and axes", font=2, col="purple", adj=0)
if (!interactive()) dev.off()

