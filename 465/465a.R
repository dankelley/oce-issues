if (!interactive()) png("465a.png")
h <- readLines("LC80060292013272LGN00/LC80060292013272LGN00_MTL.txt")
corners <- h[grep("^\\s*CORNER", h)] # all, in lonlat and also proj
corners <- corners[grep("(LON)|(LAT)", corners)]
get <- function(key)
    as.numeric(scan(text=corners[grep(key, corners)],
                    what=character(), quiet=TRUE)[3])
ullat <- get("UL_LAT")
urlat <- get("UR_LAT")
lllat <- get("LL_LAT")
lrlat <- get("LR_LAT")
ullon <- get("UL_LON")
urlon <- get("UR_LON")
lllon <- get("LL_LON")
lrlon <- get("LR_LON")
par(mar=c(3, 3, 1, 1), mgp=c(2, 0.7, 0))
asp <- 1 / cos(0.5*(lrlat+urlat) * atan2(1, 1) / 45)
plot(c(lllon,lrlon,ullon,urlon), c(lllat,lrlat,ullat,urlat),
     asp=asp, xlab="Lon", ylab="Lat")
abline(h=c(lllat, lrlat, ullat, urlat))
abline(v=c(lllon, lrlon, ullon, urlon))
if (!interactive()) dev.off()

