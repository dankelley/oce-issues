if (!interactive()) png("465b.png")
h <- readLines("LC80060292013272LGN00/LC80060292013272LGN00_MTL.txt")
corners <- h[grep("^\\s*CORNER.*(LON)|(LAT)", h)] 
get <- function(key)
    as.numeric(scan(text=corners[grep(key, corners)],
                    what=character(), quiet=TRUE)[3])
## ul ur ll lr
lat <- c(get("UL_LAT"),get("UR_LAT"),get("LL_LAT"),get("LR_LAT"))
lon <- c(get("UL_LON"),get("UR_LON"),get("LL_LON"),get("LR_LON"))
x <- c(0, 1, 0, 1)
y <- c(0, 0, 1, 1)

par(mar=c(3, 3, 1, 1), mgp=c(2, 0.7, 0))
asp <- 1 / cos(mean(lat) * atan2(1, 1) / 45)
plot(lon, lat, asp=asp, xlab="Lon", ylab="Lat")
abline(h=lat)
abline(v=lon)
if (!interactive()) dev.off()

## Model the x and y functions.
xm <- lm(x~lon+lat+lon*lat)
ym <- lm(y~lon+lat+lon*lat)
cat("x model misfit:", sd(x-predict(xm)), "\n")
cat("y model misfit:", sd(y-predict(ym)), "\n")
message("above means we can convert lon-lat to x-y.")
cat("lat quirkiness", round(100*sd(lat)/mean(lat), 2), "%\n")

## OK, those functions fit perfectly (well, no surprise)
## so all we need is a conversion from UTM (x,y) back to
## lon and lat.

## In our sample: UTM datum WGS84, zone 20 with 15m cell size panchromatic.
## Test data:
##    CORNER_UR_LAT_PRODUCT = 45.62391
##    CORNER_UR_LON_PRODUCT = -59.56594
##     CORNER_UR_PROJECTION_X_PRODUCT = 767700.000
##     CORNER_UR_PROJECTION_Y_PRODUCT = 5058000.000
latExpected <- 45.62391
lonExpected <- -59.56594
northing <- 5058000.000 / 1000
easting <- 767700.000 / 1000
zone <- 20

## Below from [wikipedia](http://en.wikipedia.org/wiki/Universal_Transverse_Mercator_coordinate_system)
utm2lonlat <- function(northing, easting, zone, hemisphere="N") 
{
    a <- 6378.137                          # earth radius in WSG84 (in km for these formulae)
    f <- 1 / 298.257223563                 # flatening
    n <- f / (2 - f)
    A <- (a / (1 + n)) * (1 + n^2/4 + n^4/64)
    alpha1 <- (1/2)*n - (2/3)*n^2 + (5/16)*n^3
    alpha2 <- (13/48)*n^2 - (3/5)*n^3
    alpha3 <- (61/240)*n^3
    beta1 <- (1/2)*n - (2/3)*n^2 + (37/96)*n^3
    beta2 <- (1/48)*n^2 + (1/15)*n^3
    beta3 <- (17/480)*n^3
    delta1 <- 2*n - (2/3)*n^2 - 2*n^3
    delta2 <- (7/3)*n^2 - (8/5)*n^3
    delta3 <- (56/15)*n^3
    N0 <- if (hemisphere=="N") 0 else 10000
    k0 <- 0.9996
    E0 <- 500                              # km
    xi <- (northing - N0) / (k0 * A)
    eta <- (easting - E0) / (k0 * A)
    xiprime <-   xi -   (beta1*sin(2*xi)*cosh(2*eta) +  beta2*sin(4*xi)*cosh(4*eta) +  beta3*sin(6*xi)*cosh(6*eta))
    etaprime <- eta -   (beta1*cos(2*xi)*sinh(2*eta) +  beta2*cos(4*xi)*sinh(4*eta) +  beta3*cos(6*xi)*sinh(6*eta))
    sigmaprime <- 1 - 2*(beta1*cos(2*xi)*cosh(2*eta) +2*beta2*cos(4*xi)*cosh(4*eta) +3*beta3*cos(6*xi)*cosh(6*eta))
    tauprime <-       2*(beta1*sin(2*xi)*sinh(2*eta) +2*beta2*sin(4*xi)*sinh(4*eta) +3*beta3*sin(6*xi)*sinh(6*eta))
    chi <- asin(sin(xiprime)/cosh(etaprime)) # Q: in deg or radian?
    phi <- chi + (delta1*sin(2*chi) + delta2*sin(4*chi) + delta3*sin(6*chi))
    latitude <- 180 * phi / pi
    lambda0 <- zone * 6 - 183              # this offset is weird but apparently true
    longitude <- lambda0 + 180/pi*atan(sinh(etaprime) / cos(xiprime))
    list(longitude=longitude, latitude=latitude)
}
lonlat <- utm2lonlat(northing, easting, zone, "N")
lonError <- 111e3*(lonlat$longitude - lonExpected) # roughly in m
latError <- 111e3*(lonlat$latitude - latExpected) # roughly in m
cat("Longitude: ", lonlat$longitude, ", expected:", lonExpected, ", error:", round(lonError, 1), "m, approx\n")
cat("Latitude:  ", lonlat$latitude,  ", expected:", latExpected, ", error:", round(latError, 1), "m, approx\n")
message("code lonlat2utm next; include in R/map.R for general use")

