## np is number of fake south-pole points
fakeSouthPole <- function(lon, lat, np=10, pole=-89.99)
{
    ## spi = south-pole indices
    spi <- which(lat < -89.99)
    lat1 <- lat[1:spi[1]]
    lon1 <- lon[1:spi[1]]
    lat2 <- lat[spi[2]:n]
    lon2 <- lon[spi[2]:n]
    LAT <- c(lat1, rep(pole, np), lat2)
    LON <- c(lon1, seq(lon[spi[1]], lon[spi[2]], length.out=np), lon2)
    list(lon=LON, lat=LAT)
}
fakeSouthPole2 <- function(lon, lat, np=10, pole=-89.99)
{
    ## spi = south-pole indices
    spi <- which(lat < -89.99)
    lat1 <- lat[1:spi[1]]
    lon1 <- lon[1:spi[1]]
    lat2 <- lat[spi[2]:n]
    lon2 <- lon[spi[2]:n]
    LAT <- c(lat1, rep(pole, np), lat2)
    LON <- c(lon1, seq(lon[spi[1]], lon[spi[2]], length.out=np), lon2)
    list(lon=LON, lat=LAT)
}

