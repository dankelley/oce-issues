if (!interactive()) png("481A.png")
library(oce)
try({
    source('~/src/oce/R/section.R')
})
data(section)
GS <- subset(section, 109<=stationId&stationId<=129)
GS <- sectionSort(GS, by="longitude")
GSG <- sectionGrid(GS, p=seq(0, 1600, 25))
par(mfrow=c(2,2))
plot(GSG, which=99, map.xlim=c(-80,-60))
mtext("(a)", adj=1)
mtext("EXPECT: no projection", font=2, col="purple", adj=0)

plot(GSG, which=99, map.xlim=c(-80,-60), proj="automatic")
mtext("(b)", adj=1)
mtext("EXPECT: mollweide (automatic)", font=2, col="purple", adj=0)

plot(GSG, which=99, map.xlim=c(-80,-60), proj="+proj=moll +lon_0=-71")
mtext("(c)", adj=1)
mtext("EXPECT: mollweide", font=2, col="purple", adj=0)

## NB +proj=merc fills badly in this case
plot(GSG, which=99, map.xlim=c(-80,-60), proj="+proj=merc", orientation=c(90, -71, 0))
mtext("(d)", adj=1)
mtext("EXPECT: mercator", font=2, col="purple", adj=0)

if (!interactive()) dev.off()

