PNG <- function(name) {
    if (!interactive()) {
        # For the png settings, see
        # https://codedocean.wordpress.com/2014/02/03/anti-aliasing-and-image-plots/
        png(name,
            type = "cairo", antialias = "none", family = "Arial",
            unit = "in", width = 7, height = 7, res = 400
        )
    }
}
GNP <- function() {
    if (!interactive()) {
        dev.off()
    }
}
library(oce)
data("coastlineWorldMedium", package = "ocedata")
int <- 0.1
lon <- seq(-130, -90, int)
lat <- seq(50, 89.95, int)
m <- matrix(lat, byrow = TRUE, nrow = length(lon), ncol = length(lat))

PNG("2199a_default.png")

par(mar = c(3, 3, 1, 1))
mapPlot(coastlineWorldMedium,
    projection = "+proj=lcc +lat_1=30 +lat_2=45 +lon_0=-110",
    longitudelim = c(-140, -80), latitudelim = c(65, 75)
)
# use semi-transparent colours so we have coastline for reference
g <- function(...) binMean2D(..., fill = TRUE)
mapImage(
    longitude = lon, latitude = lat, z = m,
    filledContour = TRUE,
    breaks = 256,
    # col = function(n) paste0(oceColorsJet(n), "aa")
    col = oceColorsJet
)

GNP()
PNG("2199a_custom_gridder.png")

par(mar = c(3, 3, 1, 1))
mapPlot(coastlineWorldMedium,
    projection = "+proj=lcc +lat_1=30 +lat_2=45 +lon_0=-110",
    longitudelim = c(-140, -80), latitudelim = c(65, 75)
)
# use semi-transparent colours so we have coastline for reference
g <- function(...) binMean2D(..., fill = TRUE)
mapImage(
    longitude = lon, latitude = lat, z = m,
    filledContour = TRUE,
    breaks = 256,
    gridder = g,
    # col = function(n) paste0(oceColorsJet(n), "aa")
    col = oceColorsJet
)

GNP()
