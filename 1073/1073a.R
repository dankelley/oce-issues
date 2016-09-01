library(oce)
debug <- 0                             # set to 3 to get names of intermediate files etc
file <- download.coastline(destdir="~/data/coastline", debug=debug)
coastline <- read.coastline(file, debug=debug)
if (!interactive()) png("1073a.png")
plot(coastline)
if (!interactive()) dev.off()

