library(oce)
data(coastlineWorldFine, package="ocedata")
year <- 2020
month <- 9
day <- 1
d <- read.amsr(download.amsr(year, month, day, "."))
if (!interactive()) png("sst-cover.png", width=8, height=5, unit="in", res=150, pointsize=14)
plot(d, "SST", col=oceColorsTurbo, xlim=c(-80, -10), ylim=c(20,65), mar=c(1.75, 1.75, 1.25, 0.5))
lines(coastlineWorldFine[["longitude"]], coastlineWorldFine[["latitude"]])
data(topoWorld)
mtext(sprintf("AMSR2 at %d-%02d-%02d", year, month, day), side=3, line=0.25)
if (!interactive()) dev.off()

