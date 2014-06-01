if (!interactive()) png("465b.png", width=7, height=7, unit="in", res=150, pointsize=9)
## Test trimming on Cape Split (the landsat dataset in ocedata)
library(oce)
if ("kelley"==system("whoami", intern=TRUE)) {
    ## source('~/src/oce/R/map.R')
    ## source('~/src/oce/R/landsat.R')
    par(mfrow=c(2,2))
    if (!exists("whole")) {
        whole <- read.landsat("~/Google Drive/LC80080292014065LGN00", band="panchromatic")
        message("for speed during debugging, just read panchromatic band")
    }
    for (utm in c(FALSE, TRUE)) {
        plot(whole, decimate=10, utm=utm)
        CS <- list(longitude=-64.495, latitude=45.334, zone=whole[["zoneUTM"]]) # openstreetmap
        CSUTM <- lonlat2utm(CS, km=TRUE)
        abline(v=CSUTM$easting, col='red')
        abline(h=CSUTM$northing, col='red')
        ll <- list(longitude=-64.521, latitude=45.300, km=TRUE)
        ur <- list(longitude=-64.429, latitude=45.368, km=TRUE)
        llUTM <- lonlat2utm(ll, zone=whole[["zoneUTM"]], km=TRUE)
        urUTM <- lonlat2utm(ur, zone=whole[["zoneUTM"]], km=TRUE)
        if (utm) {
            abline(h=c(llUTM$northing, urUTM$northing), col='green')
            abline(v=c(llUTM$easting, urUTM$easting), col='green')
            abline(v=CSUTM$easting, col='red')
            abline(h=CSUTM$northing, col='red')
        } else {
            abline(h=c(ll$latitude, ur$latitude), col='green')
            abline(v=c(ll$longitue, ur$longitude), col='green')
            abline(v=CS$longitude, col='red')
            abline(h=CS$latitude, col='red')
        }
        landsat <- landsatTrim(whole, ll, ur)
        plot(landsat, utm=utm)
        if (utm) {
            abline(h=c(llUTM$northing, urUTM$northing), col='green')
            abline(v=c(llUTM$easting, urUTM$easting), col='green')
            abline(v=CSUTM$easting, col='red')
            abline(h=CSUTM$northing, col='red')
        } else {
            abline(h=c(ll$latitude, ur$latitude), col='green')
            abline(v=c(ll$longitue, ur$longitude), col='green')
            abline(v=CS$longitude, col='red')
            abline(h=CS$latitude, col='red')
        }
    }
} else {
    message("Since this test involves a 1-Gbyte file, the data are not on github")
}
if (!interactive()) dev.off()
