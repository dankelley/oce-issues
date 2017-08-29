## See notes in README.md
library(oce)
## source("~/git/oce/R/map.R")
data(coastlineWorldFine, package="ocedata")
L <- 7e6 / 10
xlim <- L * c(-1, 1)
ylim <- L * c(-1, 1)

if (!interactive()) png("1288b_%d.png")
par(mar=c(1.5, 1.5, 1, 1))

a <- system.time({
    mapPlot(coastlineWorldFine, projection="+proj=ortho +lon_0=-64 +lat_0=45",
            type="l", grid=FALSE, xlim=xlim, ylim=ylim)
})

b <- system.time({
    mapPlot(coastlineWorldFine, projection="+proj=ortho +lon_0=-64 +lat_0=45",
            type="l", grid=TRUE, xlim=xlim, ylim=ylim, debug=0)
})

speedup <- (as.vector(b) / as.vector(a))[1:3]
print(a)
print(b)
cat("speedup (user, system, elapsed) = ", paste(round(speedup, 1), collapse=" "), "\n")

if (!interactive()) dev.off()

