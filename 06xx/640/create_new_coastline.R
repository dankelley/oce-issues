library(oce)
part3 <- !FALSE
show <- function(i, pch=1, col=2, pos=3, cex=3/4) {
    points(longitude[i], latitude[i], pch=pch, cex=cex, col=col)
    text(longitude[i], latitude[i], i, pos=pos, cex=cex, col=col)
}
shownew <- function(i, pch=1, col=2, pos=3, cex=3/4) {
    points(LON[i], LAT[i], pch=pch, cex=cex, col=col)
    text(LON[i], LAT[i], i, pos=pos, cex=cex, col=col)
}

data(coastlineWorld)
longitude <- coastlineWorld[["longitude"]]
latitude <- coastlineWorld[["latitude"]]
write.table(data.frame(longitude=longitude, latitude=latitude),
            col.names=FALSE, row.names=FALSE, file="coastline.dat")
look <- 445:999
par(mar=c(2,2,0.2,0.2), mgp=c(2,0.6,0))
plot(longitude[look], latitude[look], type='l')

show(445, pos=4)
show(470, pos=4)
show(700, pos=1)
show(824, pos=3)
show(825, pos=3)
show(826, pos=3)
show(827, pos=3)
show(999, pos=3)

## new indices: 826:999, 445:825
n <- length(longitude)
LON <- c(longitude[1:444], longitude[826:999], longitude[445:825],
         seq(165, -180, -15),
         longitude[1000:n])
LAT <- c(latitude[1:444], latitude[826:999], latitude[445:825],
         rep(-90, 24),
         latitude[1000:n])
epsilon <- 1e-8
LAT[LAT<(-89.999)] <- -90 + epsilon
plot(LON[445:1023], LAT[445:1023], type='l')
shownew(445, pos=1)
shownew(500, pos=4)
shownew(600, pos=1)
shownew(700, pos=1)
shownew(800, pos=3)
shownew(900, pos=3)
shownew(999, pos=3)
shownew(1000, pos=1)
shownew(1010, pos=1)
shownew(1022, pos=3)

if (part3) {
    coastlineWorld <- as.coastline(longitude=LON, latitude=LAT)
    coastlineWorld@metadata$filename="ne_110m_admin_0_countries.shp, with Antarctica modified"
    save(coastlineWorld, file="coastlineWorld.rda")
    tools::resaveRdaFiles("coastlineWorld.rda")
    write.table(data.frame(longitude=LON, latitude=LAT),
                col.names=FALSE, row.names=FALSE, file="coastlineNEW.dat")
    cl <- as.coastline(lon=LON, lat=LAT)
    plot(cl)
    cl2 <- coastlineCut(cl, lon_0=-120)
    mapPlot(cl2, proj="+proj=wintri +lon_0=-120", fill='pink')

}
