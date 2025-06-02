library(oce)
f <- "~/Downloads/S104098A002_2297d.ad2cp"
dataType <- "average"
if (!file.exists("ad2cp.rds")) {
    if (file.exists(f)) {
        from <- 3300000
        to <- from + 100
        # timing [s]: user=1.7, system=3.1, elapsed=4.8
        ad2cp <- read.adp.ad2cp(f, dataType = dataType, from = from, to = to)
        saveRDS(ad2cp, file = "ad2cp.rds")
        message("created 'ad2cp.rds' file")
    } else {
        stop("cannot run this script because \"", f, "\" does not exist")
    }
}
beam <- readRDS("ad2cp.rds")
xyz <- beamToXyz(beam, debug = 2)
enu <- xyzToEnu(xyz, debug = 2)
zlim <- c(-1, 1) * quantile(abs(xyz[["v"]]), 0.95)

if (!interactive()) png("2315a_angles.png", width = 7, height = 7, unit = "in", res = 300)
plot(beam, which = "angles")
if (!interactive()) dev.off()

if (!interactive()) png("2315a_beam.png", width = 7, height = 7, unit = "in", res = 300)
plot(beam, zlim = zlim)
if (!interactive()) dev.off()

if (!interactive()) png("2315a_xyz.png", width = 7, height = 7, unit = "in", res = 300)
plot(xyz, zlim = zlim)
if (!interactive()) dev.off()

if (!interactive()) png("2315a_enu.png", width = 7, height = 7, unit = "in", res = 300)
plot(enu, zlim = zlim)
if (!interactive()) dev.off()

cat(sprintf("File '%s' (dataType \"%s\") has declination %g\n", f, dataType, beam[["declination"]]))
