# this is based on a test file from Clark Richards
library(oce)
debug <- 3
f <- "~/Downloads/arcticbay_aquadopp/AB1904.PRF"
if (!file.exists(f)) {
    stop("cannot locate data file \"", f, "\"")
}
print(oceMagic(f))
d <- read.adp.nortek(f, debug = debug)

# d <- read.oce(f, debug=3)
## tcut <- numberAsPOSIXct(1560805594) # by eye on larger time-span plot
## dd <- subset(d, time < tcut)
focus <- structure(c(1559231882.51953, 1561138020.65625), tzone = "UTC", class = c(
    "POSIXct",
    "POSIXt"
))
dd <- subset(d, focus[1] <= time & time <= focus[2])
dd[["orientation"]] <- "downward"
summary(dd)
cat(vectorShow(dd[["cellSize"]]))
cat(vectorShow(dd[["blankingDistance"]]))
if (!interactive()) {
    png("2165b_%d.png", unit = "in", res = 200, width = 7, height = 5)
}
par(mfrow = c(3, 1))
oce.plot.ts(d[["time"]], d[["pressure"]], ylab = "Pressure [dbar]")
label <- numberAsPOSIXct(1561170000) # chosen by eye
abline(v = label, col = "magenta")
oce.plot.ts(d[["time"]], d[["temperature"]], ylab = "Temperature [degC]")
abline(v = label, col = "magenta")
oce.plot.ts(d[["time"]], d[["heading"]], ylab = "Heading")
abline(v = label, col = "magenta")
## plot(dd, which=1:3, zlim=c(-1, 1), col=oceColorsVelocity)

par(mfrow = c(3, 1))

imagep(d[["time"]], d[["distance"]], d[["v"]][, , 1],
    ylab = "Distance [m]", zlim = c(-1, 1), col = oceColorsVelocity
)
abline(v = label, col = "magenta")
mtext("v[, , 1]", adj = 0.5, cex = par("cex"))

imagep(d[["time"]], d[["distance"]], d[["v"]][, , 2],
    ylab = "Distance [m]", zlim = c(-1, 1), col = oceColorsVelocity
)

abline(v = label, col = "magenta")
mtext("v[, , 2]", adj = 0.5, cex = par("cex"))

imagep(d[["time"]], d[["distance"]], d[["v"]][, , 3],
    ylab = "Distance [m]", zlim = c(-1, 1), col = oceColorsVelocity
)
abline(v = label, col = "magenta")
mtext("v[, , 3]", adj = 0.5, cex = par("cex"))

par(mfrow = c(3, 1))
imagep(d[["time"]], d[["distance"]], d[["a", "numeric"]][, , 1],
    col = oceColorsTurbo,
    ylab = "Distance [m]"
)
mtext("a[, , 1]", adj = 0.5, cex = par("cex"))
abline(v = label, col = "magenta")

imagep(d[["time"]], d[["distance"]], d[["a", "numeric"]][, , 2],
    col = oceColorsTurbo,
    ylab = "Distance [m]"
)
mtext("a[, , 2]", adj = 0.5, cex = par("cex"))
abline(v = label, col = "magenta")

imagep(d[["time"]], d[["distance"]], d[["a", "numeric"]][, , 3],
    col = oceColorsTurbo,
    ylab = "Distance [m]"
)
mtext("a[, , 3]", adj = 0.5, cex = par("cex"))
abline(v = label, col = "magenta")

## plot(dd, which=5:7)
if (!interactive()) {
    dev.off()
}
