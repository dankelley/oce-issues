if (!interactive()) png("486_%d.png")
library(oce)
try({
    source('~/src/oce/R/landsat.R')
})
l <- read.landsat("~/google_drive/LC80080292014065LGN00", debug=3)

landsat <- landsatTrim(l, 
                       list(longitude=-64.572, latitude=45.295),
                       list(longitude=-64.481, latitude=45.363))
save(landsat, file="landsat.rda")
library(tools)
resaveRdaFiles("landsat.rda")

for (b in landsat[["bandnames"]])
    plot(landsat, band=b)

if (!interactive()) dev.off()
