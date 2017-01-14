## Test interpolating poly linking x/y to lon/lat.
rm(list=ls())
library(testthat)
## CORNER_UL_LAT_PRODUCT = 70.68271
## CORNER_UL_LON_PRODUCT = -54.28961
## CORNER_UR_LAT_PRODUCT = 70.67792
## CORNER_UR_LON_PRODUCT = -47.45356
## CORNER_LL_LAT_PRODUCT = 68.46651
## CORNER_LL_LON_PRODUCT = -53.96471
## CORNER_LR_LAT_PRODUCT = 68.46225
## CORNER_LR_LON_PRODUCT = -47.80372
## CORNER_UL_PROJECTION_X_PRODUCT = 378600.000
## CORNER_UL_PROJECTION_Y_PRODUCT = 7845300.000
## CORNER_UR_PROJECTION_X_PRODUCT = 630900.000
## CORNER_UR_PROJECTION_Y_PRODUCT = 7845300.000
## CORNER_LL_PROJECTION_X_PRODUCT = 378600.000
## CORNER_LL_PROJECTION_Y_PRODUCT = 7597800.000
## CORNER_LR_PROJECTION_X_PRODUCT = 630900.000
## CORNER_LR_PROJECTION_Y_PRODUCT = 7597800.000

file <- '/data/archive/landsat/LC80100112013172LGN00/LC80100112013172LGN00_MTL.txt'
d <- readLines(file)
#d <- d[grep("LON|LAT", d)]
num <- function(d, pattern)
    as.numeric(gsub(".* =", "", d[grep(pattern, d)]))
ullat <- num(d, "CORNER_UL_LAT_PRODUCT")
ullon <- num(d, "CORNER_UL_LON_PRODUCT")
urlat <- num(d, "CORNER_UR_LAT_PRODUCT")
urlon <- num(d, "CORNER_UR_LON_PRODUCT")
lllat <- num(d, "CORNER_LL_LAT_PRODUCT")
lllon <- num(d, "CORNER_LL_LON_PRODUCT")
lrlat <- num(d, "CORNER_LR_LAT_PRODUCT")
lrlon <- num(d, "CORNER_LR_LON_PRODUCT")
ulx <- num(d, "CORNER_UL_PROJECTION_X_PRODUCT")
uly <- num(d, "CORNER_UL_PROJECTION_Y_PRODUCT")
urx <- num(d, "CORNER_UR_PROJECTION_X_PRODUCT")
ury <- num(d, "CORNER_UR_PROJECTION_Y_PRODUCT")
llx <- num(d, "CORNER_LL_PROJECTION_X_PRODUCT")
lly <- num(d, "CORNER_LL_PROJECTION_Y_PRODUCT")
lrx <- num(d, "CORNER_LR_PROJECTION_X_PRODUCT")
lry <- num(d, "CORNER_LR_PROJECTION_Y_PRODUCT")

x <- c(ulx, urx, llx, lrx)
y <- c(uly, ury, lly, lry)
lon <- c(ullon, urlon, lllon, lrlon)
lat <- c(ullat, urlat, lllat, lrlat)

## These are really interpolating polynomials, but lm is a simple way to calculate.
mlon <- lm(lon~x+y+x*y)
mlat <- lm(lat~x+y+x*y)
expect_less_than(mean(abs(lat-predict(mlat))), 1e-7)
expect_less_than(mean(abs(lon-predict(mlon))), 1e-7)
mx <- lm(x~lon+lat+lon*lat)
my <- lm(y~lon+lat+lon*lat)
expect_less_than(mean(abs(x-predict(mx))), 1e-7)
expect_less_than(mean(abs(y-predict(my))), 1e-7)


