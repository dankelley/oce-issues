library(oce)
if (!file.exists("ad2cp.rds")) {
    if (file.exists(f)) {
        f <- "~/Downloads/S104098A002_2297d.ad2cp"
        from <- 3300000
        to <- from + 100
        ad2cp <- read.adp.ad2cp(f, dataType = "average", from = from, to = to)
        saveRDS(ad2cp, file = "ad2cp.rds")
        message("created 'ad2cp.rds' file")
    } else {
        stop("cannot run this script because \"", f, "\" does not exist")
    }
}
ad2cp <- readRDS("ad2cp.rds")
xyz <- beamToXyz(ad2cp, debug = 2)
zlim <- c(-1, 1) * quantile(abs(ad2cp[["v"]]), 0.95)
if (!interactive()) png("2315a_beam.png", width = 7, height = 7, unit = "in", res = 300)
plot(ad2cp, zlim = zlim)
if (!interactive()) dev.off()
if (!interactive()) png("2315a_xyz.png", width = 7, height = 7, unit = "in", res = 300)
plot(xyz, zlim = zlim)
if (!interactive()) dev.off()
