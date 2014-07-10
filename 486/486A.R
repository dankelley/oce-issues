if (!interactive()) png("486.png")
library(oce)
try({
    source('~/src/oce/R/landsat.R')
})
l <- read.landsat("~/google_drive/LC80080292014065LGN00", debug=1)

landsat <- landsatTrim(l, 
                       list(longitude=-64.572, latitude=45.295),
                       list(longitude=-64.481, latitude=45.363))
plot(landsat, band='aerosol')
plot(landsat, band=1) # FAILS

save(landsat, file="landsat.rda")
library(tools)
resaveRdaFiles("landsat.rda")
# 
# dim <- dim(landsat[["band", "panchromatic"]])
# if (!interactive()) png("landsat.png", width=dim[1], height=dim[2], pointsize=24)
# ## Cape Split from openstreetmap
# CS <- list(longitude=-mean(c(64.4924,64.4896)),latitude=mean(c(45.3277, 45.3296)))
# CSUTM <- lonlat2utm(CS, zone=landsat[["zoneUTM"]], km=TRUE)
# 
# plot(landsat, band="panchromatic")
# points(CS$longitude, CS$latitude, bg='pink', pch=22, lwd=2, cex=3)
# 
if (!interactive()) dev.off()
