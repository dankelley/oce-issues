library(oce)
debug <- 1
data(coastlineWorld)
options("oce:test_sf" = 1)             # increases time from 1.8s to 2.1s
cl <- subset(coastlineWorld, -80<lon & lon<-50 & 30<lat & lat<60, debug=debug)
if (!interactive()) png("1629_coastline.png")
plot(cl, clon=-65, clat=45, span=6000)
rect(-80, 30, -50, 60, bg="transparent", border="red")
if (!interactive()) dev.off()
