PNG <- function(name) {
    if (!interactive()) {
        # For the png settings, see
        # https://codedocean.wordpress.com/2014/02/03/anti-aliasing-and-image-plots/
        png(name,
            type = "cairo", antialias = "none", family = "Arial",
            unit = "in", width = 7, height = 3.5, res = 400, pointsize = 8
        )
        par(mar = c(2, 2, 1, 1), mgp = c(2, 0.7, 0))
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

mapPlot(coastlineWorldMedium,
    projection = "+proj=lcc +lat_1=30 +lat_2=45 +lon_0=-110",
    longitudelim = c(-140, -80), latitudelim = c(65, 75)
)
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

mapPlot(coastlineWorldMedium,
    projection = "+proj=lcc +lat_1=30 +lat_2=45 +lon_0=-110",
    longitudelim = c(-140, -80), latitudelim = c(65, 75)
)
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
