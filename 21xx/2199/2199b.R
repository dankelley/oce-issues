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
require(oce)
data("coastlineWorldMedium", package = "ocedata")
int <- .1
lon <- seq(-179.95, 179.95, int)
lat <- seq(-39.95, 89.95, int)
m <- matrix(0, nrow = length(lon), ncol = length(lat))
PNG("2199b_default.png")
mapPlot(coastlineWorldMedium,
    type = "polygon",
    col = "grey95",
    # projection="+proj=laea +lat0=40 +lat1=60 +lon_0=-110",
    projection = "+proj=lcc +lat_1=30 +lat_2=45 +lon_0=-110",
    # longitudelim = c(minlon, maxlon), latitudelim = c(minlat, maxlat),
    longitudelim = c(-140, -80), latitudelim = c(45, 70),
    polarCircle = 0,
    clip = TRUE, drawBox = TRUE,
    cex.axis = .7
)

mapImage(
    longitude = lon, latitude = lat, z = m,
    filledContour = TRUE,
    breaks = 10,
    col = colorRampPalette(c("blue", "red"))(10)
)
GNP()

PNG("2199b_custom_gridder.png")
mapPlot(coastlineWorldMedium,
    type = "polygon",
    col = "grey95",
    # projection="+proj=laea +lat0=40 +lat1=60 +lon_0=-110",
    projection = "+proj=lcc +lat_1=30 +lat_2=45 +lon_0=-110",
    # longitudelim = c(minlon, maxlon), latitudelim = c(minlat, maxlat),
    longitudelim = c(-140, -80), latitudelim = c(45, 70),
    polarCircle = 0,
    clip = TRUE, drawBox = TRUE,
    cex.axis = .7
)
g <- function(...) binMean2D(..., fill = TRUE)

mapImage(
    longitude = lon, latitude = lat, z = m,
    filledContour = TRUE,
    breaks = 10,
    gridder = g,
    col = colorRampPalette(c("blue", "red"))(10)
)
GNP()
