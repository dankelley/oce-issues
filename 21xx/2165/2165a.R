library(oce)
debug <- 1
f <- "~/Downloads/arcticbay_aquadopp/AB1904.PRF"
if (!file.exists(f)) {
    stop("cannot locate data file \"", f, "\"")
}
cat("file \"", f, "\" has magic \"", oceMagic(f), "\"\n", sep="")

d <- read.adp.nortek(f, debug = debug)
# check that cellSize is 1m
stopifnot(all.equal(1.0, d[["cellSize"]], tol=1e-3))

# d <- read.oce(f, debug=3)
## tcut <- numberAsPOSIXct(1560805594) # by eye on larger time-span plot
## dd <- subset(d, time < tcut)
focus <- structure(c(1559231882, 1561138020), tzone = "UTC", class = c("POSIXct", "POSIXt"))
dd <- subset(d, focus[1] <= time & time <= focus[2])
dd[["orientation"]] <- "downward"
png("2165a_%d.png", unit="in", width=7, height=7, res=200, pointsize=16)
par(mfrow = c(3, 1))
oce.plot.ts(d[["time"]], d[["pressure"]])
mtext(sprintf("cellSize=%.4fm", d[["cellSize"]]), adj = 1, col = 2)
oce.plot.ts(d[["time"]], d[["temperature"]])
oce.plot.ts(d[["time"]], d[["heading"]])
## plot(dd, which=1:3, zlim=c(-1, 1), col=oceColorsVelocity)
par(mfrow = c(3, 1))
imagep(d[["time"]], d[["distance"]], d[["v"]][, , 1], zlim = c(-1, 1), col = oceColorsVelocity)
mtext(sprintf("cellSize=%.4fm", d[["cellSize"]]), adj = 1, col = 2)
imagep(d[["time"]], d[["distance"]], d[["v"]][, , 2], zlim = c(-1, 1), col = oceColorsVelocity)
imagep(d[["time"]], d[["distance"]], d[["v"]][, , 3], zlim = c(-1, 1), col = oceColorsVelocity)

par(mfrow = c(3, 1))
imagep(d[["time"]], d[["distance"]], d[["a", "numeric"]][, , 1], col = oceColorsTurbo)
mtext(sprintf("cellSize=%.4fm", d[["cellSize"]]), adj = 1, col = 2)
imagep(d[["time"]], d[["distance"]], d[["a", "numeric"]][, , 2], col = oceColorsTurbo)
imagep(d[["time"]], d[["distance"]], d[["a", "numeric"]][, , 3], col = oceColorsTurbo)

## plot(dd, which=5:7)
dev.off()
