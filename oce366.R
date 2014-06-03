library(oce)
par(mar=c(3, 3, 1, 1))
##lonlim <- c(-20, 20)
##latlim <- c(-40, 40)
##mapPlot(coastlineWorld, longitudelim=lonlim, latitudelim=latlim, projection='mollweide')
mapPlot(coastlineWorld, projection='mollweide')
mapImage(topoWorld, col=oceColorsJet, zlim=c(-5000, 5000), debug=99)
mapPolygon(coastlineWorld, col='lightgray')

