library(oce)

longitude <- -59.56594
latitude <- 45.62391
easting <- 767700.000 / 1000           # convert to km
northing <- 5058000.000 / 1000         # convert to km
zone <- 20

lonlat <- utm2lonlat(northing, easting, zone, "N")
cat("Longitude: ", lonlat$longitude, ", expected:", longitude, ", error:", lonlat$longitude-longitude, "\n")
cat("Latitude:  ", lonlat$latitude,  ", expected:", latitude, ", error:", lonlat$latitude-latitude, "\n")
utm <- lonlat2utm(lonlat$longitude, lonlat$latitude)
cat("Easting: ", utm$easting, "km, expected:", easting, "km, error:", utm$easting-easting, "\n")
cat("Northing:  ", utm$northing,  "km, expected:", northing, "km, error:", utm$northing-northing, "\n")

