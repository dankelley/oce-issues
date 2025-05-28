library(oce)
f <- "~/Dropbox/oce_secret_data/ad2cp/secret3_trimmed.ad2cp"

if (file.exists(f)) {
    beam <- read.adp.ad2cp(f, dataType = "burst")
    xyz <- beamToXyz(beam)
    enu <- xyzToEnu(xyz)
    zlim <- c(-1, 1) * quantile(abs(beam[["v"]]), 0.95)
    if (!interactive()) png("2315b_beam.png", width = 7, height = 7, unit = "in", res = 300)
    plot(beam, zlim = zlim)
    if (!interactive()) dev.off()
    if (!interactive()) png("2315b_xyz.png", width = 7, height = 7, unit = "in", res = 300)
    plot(xyz, zlim = zlim)
    if (!interactive()) dev.off()
    if (!interactive()) png("2315b_enu.png", width = 7, height = 7, unit = "in", res = 300)
    plot(enu, zlim = zlim)
    if (!interactive()) dev.off()
}
