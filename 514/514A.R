rm(list=ls())
library(oce)
data(coastlineWorld)

mapPlot(coastlineWorld, longitudelim=c(-20, 20), latitudelim=c(65, 80),
        projection = 'stereographic')
points_west <- mapLocator()
points_east <- mapLocator()
mapPoints(points_west, pch=21, bg=2)
mapPoints(points_east, pch=21, bg=3)
print(points_west)
print(points_east)

