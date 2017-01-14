library(oce)
## try(source("~/src/oce/R/map.R"))
data(coastlineWorld)
data(coastlineWorldMedium, package="ocedata")
if (!interactive()) png("766a.png")
par(mar=c(3, 3, 1, 1))
mapPlot(coastlineWorldMedium, proj="+proj=lcc +lon_0=-65",
        grid=c(5, 5),
        longitudelim=c(280, 310), latitudelim=c(35, 45), debug=3)
if (!interactive()) dev.off()

