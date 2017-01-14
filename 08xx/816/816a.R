library(oce)
##> try(source("~/src/oce/R/ctd.R"))
##> try(source("~/src/oce/R/coastline.R"))
data(ctd)
Hlon <- -157.8
Hlat <- 21.2
ctd[["longitude"]] <- Hlon
ctd[["latitude"]] <- Hlat
if (!interactive()) png("816a.png")
par(mfrow=c(2,2))
plot(ctd, which='map', span=500)
mtext("Expect same across columns", side=3, line=2, font=2, col='magenta')
mtext(sprintf("CTD with lon: %.2f", ctd[['longitude']]), side=1, line=-2, col='magenta')
ctd[["longitude"]] <- 360 + ctd[["longitude"]]
plot(ctd, which='map', span=500)
mtext(sprintf("CTD with lon: %.2f", ctd[['longitude']]), side=1, line=-2, col='magenta')
## Test coastline plotting too: both plots should show lon<0
data(coastlineWorld)
plot(coastlineWorld, clongitude=Hlon, clatitude=Hlat, span=500)
mtext(sprintf("clon: %.2f", Hlon), side=1, line=-2, col='magenta')
plot(coastlineWorld, clongitude=Hlon+360, clatitude=Hlat, span=500)
mtext(sprintf("clon: %.2f", Hlon+360), side=1, line=-2, col='magenta')
if (!interactive()) dev.off()

