library(oce)
data(coastlineWorldFine,package="ocedata")
if (!interactive()) png("612A.png")
mapPlot(coastlineWorldFine, projection="+proj=merc", 
        longitudelim=c(-65,-60),latitudelim=c(40,45), debug=3)
if (!interactive()) dev.off()

