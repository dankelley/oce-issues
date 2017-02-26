if (!interactive()) png("514B.png")
library(oce)
data(coastlineWorld)

par(mar=c(2, 2, 1, 1), mfrow=c(2,1))
for (proj in c("stereographic", "+proj=stere")) {
    mapPlot(coastlineWorld, longitudelim=c(-20, 20), latitudelim=c(65, 80),
            projection = 'stereographic')

    west <- mapproject(-10, 72)
    east <- mapproject(10, 72)
    options(oceDebug=0) # set to 2 for debugging since map2lonlat lacks 'debug' arg
    points_east <- map2lonlat(east$x, east$y)
    points_west <- map2lonlat(west$x, west$y)
    options(oceDebug=0) # turn debugging off

    mapPoints(points_east, pch=21, bg=3)
    mapPoints(points_west, pch=21, bg=3)
    mapText(points_east$longitude, points_east$latitude, pos=4,
            sprintf("%.4fE\n%.4fN", points_east$longitude, points_east$latitude))
    mapText(points_west$longitude, points_west$latitude, pos=2,
            sprintf("%.4fE\n%.4fN", points_west$longitude, points_west$latitude))
    if (abs(points_west$longitude + 10) > 0.1) stop("error: lon should be near -10")
    if (abs(points_west$latitude - 72) > 0.1) stop("error: lat should be near 72")
    if (abs(points_east$longitude - 10) > 0.1) stop("error: lon should be near 10")
    if (abs(points_east$latitude - 72) > 0.1) stop("error: lat should be near 72")
    mtext(paste("projection=\"", proj, "\"", sep=""), adj=0)
    mtext("EXPECT: lon=c(-10,10), lat=72", font=2, col="purple", adj=1)
}
if (!interactive()) dev.off()

