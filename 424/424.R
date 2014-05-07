library(oce)
library(ocedata)
data(landsat)

dim <- dim(landsat@data[[1]])
if (!interactive()) png("424A.png", width=dim[1], height=dim[2], pointsize=10)
plot(landsat, which=2, zlim="histogram")
if (!interactive()) dev.off()

if (!interactive()) png("424B.png", width=dim[1], height=dim[2], pointsize=10)
plot(landsat, which=2, zlim=c(0.098, 0.111), col=rev(oceColorsJet(200)))
if (!interactive()) dev.off()

if (!interactive()) png("424C.png", width=dim[1], height=dim[2], pointsize=10)
plot(landsat, which=2, zlim=c(0.101, 0.112), col=oceColorsJet(200))
if (!interactive()) dev.off()

if (!interactive()) png("424D.png", width=dim[1], height=dim[2], pointsize=10)
plot(landsat, which=1, breaks=200, xlim=c(0.1, 0.12))
if (!interactive()) dev.off()
