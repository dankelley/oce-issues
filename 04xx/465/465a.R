if (!interactive()) png("465a.png")
h <- readLines("LC80060292013272LGN00/LC80060292013272LGN00_MTL.txt")
corners <- h[grep("^\\s*CORNER.*(LON)|(LAT)", h)] 
get <- function(key)
    as.numeric(scan(text=corners[grep(key, corners)],
                    what=character(), quiet=TRUE)[3])
## ul ur ll lr
lat <- c(get("UL_LAT"),get("UR_LAT"),get("LL_LAT"),get("LR_LAT"))
lon <- c(get("UL_LON"),get("UR_LON"),get("LL_LON"),get("LR_LON"))
par(mar=c(3, 3, 1, 1), mgp=c(2, 0.7, 0))
asp <- 1 / cos(0.5*mean(lat) * atan2(1, 1) / 45)
plot(lon, lat, asp=asp, xlab="Lon", ylab="Lat")
abline(h=lat)
abline(v=lon)
if (!interactive()) dev.off()

