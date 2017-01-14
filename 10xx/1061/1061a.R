library(oce)
showIsobath <- FALSE
d <- read.amsr(download.amsr(2016,8,08,"~/data/amsr"))
if (!interactive()) png("1061a.png", width=5, height=5, unit="in", res=100, pointsize=14)
plot(d, "SST", col=oceColorsJet, xlim=c(-80, -40), ylim=c(20,70), mar=c(1.75, 1.75, 1, 0.5))
data(coastlineWorldFine, package="ocedata")
lines(coastlineWorldFine[["longitude"]], coastlineWorldFine[["latitude"]])
if (!interactive()) dev.off()

