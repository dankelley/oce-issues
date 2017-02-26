if (!interactive()) png("424.png", width=7, height=4, unit="in", res=100,
                        pointsize=10)
library(oce)
data(landsat, package="ocedata")

par(mfrow=c(2,1))
dim <- dim(landsat@data[[1]]$msb)
plot(landsat, which=2, zlim="histogram")
F <- 2^16-1
plot(landsat, which=1, zlim=c(14000, 18000), col=rev(oceColorsJet(200)))
if (!interactive()) dev.off()

