init <- TRUE
library(oce)
if (init) {
    setwd("~/Dropbox")
    l <- read.oce("LC80080292014065LGN00")
    landsat <- landsatTrim(l,
                          list(longitude=-64.559, latitude=45.256),
                          list(longitude=-64.408, latitude=45.370))
    save(landsat, file="landsat.rda")
    library(tools)
    resaveRdaFiles("landsat.rda")
} else {
    load("landsat.rda")
}

message("FIXME: reduce span by 10, then include all bands (keep focus on Cape tip)")

## dim <- dim(landsat@data[[1]])
## 
## if (!interactive()) png("landsat.png", width=dim[1], height=dim[2], pointsize=24)
## plot(landsat, which=2, zlim=c(0.10, 0.15))
## if (!interactive()) dev.off()
## 
