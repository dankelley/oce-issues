# Tests from CR posting to the issue thread

library(oce)
try({source('~/src/oce/R/map.R')})

library(ocedata)
data(coastlineWorld)
lonlim <- c(-20, 20)
latlim <- c(50, 80)

if (FALSE) {
if (!interactive()) png("529A1.png")
par(mfrow=c(1,2), mar=rep(2,4))
mapPlot(coastlineWorld, projection='stereographic',
        longitudelim=lonlim, latitudelim=latlim,
        main='mapproj stereographic')
mapPlot(coastlineWorld, projection='+proj=stere',
        longitudelim=lonlim, latitudelim=latlim,
        main='proj4 stere')
if (!interactive()) dev.off()


if (!interactive()) png("529A2.png")
par(mfrow=c(1,2), mar=rep(2,4))
mapPlot(coastlineWorld, projection='stereographic',
        longitudelim=lonlim, latitudelim=latlim,
        main='mapproj stereographic')
mapPlot(coastlineWorld, projection='+proj=stere +lat_0=90',
        longitudelim=lonlim, latitudelim=latlim,
        main='proj4 stere lat_0=90')
if (!interactive()) dev.off()

if (!interactive()) png("529A3.png")
par(mfrow=c(1,2), mar=rep(2,4))
mapPlot(coastlineWorld, projection='stereographic',
        longitudelim=lonlim, latitudelim=latlim,
        main='mapproj stereographic')
mapPlot(coastlineWorld, projection='+proj=sterea +lat_0=90',
        longitudelim=lonlim, latitudelim=latlim,
        main='proj4 sterea lat_0=90')
if (!interactive()) dev.off()

if (!interactive()) png("529A4.png", height=400, width=700)
par(mfrow=c(1,2), mar=c(3, 3, 3, 1))
mapPlot(coastlineWorld, projection='+proj=sterea +lat_0=90',
        longitudelim=lonlim, latitudelim=latlim,
        main='proj4 sterea lat_0=90')
mapPlot(coastlineWorld, projection='+proj=sterea +lat_0=89.9',
        longitudelim=lonlim, latitudelim=latlim,
        main='proj4 sterea lat_0=89.9')
if (!interactive()) dev.off()
}

message("Other problems:\n
1. The y-axis labeling seems to have a harder time with the various\n
proj4 parameters (e.g. see the figure above).\n
\n
2. The sterea projection produces an extra dark central meridian in\n
some cases, e.g. when lat_0=89.9 and lon_0=180.")

