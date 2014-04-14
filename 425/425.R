library(oce)
data(adp)
im <- adp@data$v[,,1]
if (!interactive()) png("425.png")
imagep(im, zlim="histogram")
if (!interactive()) dev.off()

