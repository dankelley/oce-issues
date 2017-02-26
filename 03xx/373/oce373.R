library(oce)
data(a03)
GS <- subset(a03, 109<=stationId&stationId<=129)
GSg <- sectionGrid(GS, p=seq(0,2000,100))
par(mfrow=c(2,1))
plot(GS, which=1, ylim=c(2000, 0), ztype='points',
     zbreaks=seq(0,30,2), pch=20, cex=3)
plot(GSg, which=1, ztype='image', zbreaks=seq(0,30,2), zlim=c(-100, 100))

