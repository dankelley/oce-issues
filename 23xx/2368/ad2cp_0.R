# vim:textwidth=120:expandtab:shiftwidth=4:softtabstop=4:foldmethod=marker
library(oce)
debug <- 1
files <- c(
    "/Users/kelley/Downloads/104561_20250219T093916UTC.AD2CP", # ad2cp_1.R zooms plots
    "/Users/kelley/Downloads/S102791A003_Barrow_2022_0001_sub.ad2cp", # Clark's first file
    "/Users/kelley/Downloads/S102791A003_Barrow_2022_0005_sub.ad2cp" # Clark's second file
)

for (file in files) {
    cat("file=", file, "\n", sep = "")
    d <- try(read.adp.ad2cp(file, dataType = "bottomTrack", debug = debug))
    if (inherits(d, "try-error")) {
        message("FAILURE TO READ file ", file)
    } else {
        message("SUCCESSFULLY READ file ", file)
        summary(d)
        res <- 150
        pointsize <- 14 # make big because with lots of panels, it defaults to too small
        # p,t
        pngName <- paste0("ad2cp_", gsub(".*/", "", file), "_p_and_T.png")
        png(pngName, unit = "in", width = 7, height = 7, pointsize = pointsize, res = res)
        par(mfrow = c(2, 1))
        oce.plot.ts(d[["time"]], d[["pressure"]])
        oce.plot.ts(d[["time"]], d[["temperature"]])
        dev.off()
        # heading,pitch,roll
        pngName <- paste0("ad2cp_", gsub(".*/", "", file), "_angles.png")
        png(pngName, unit = "in", width = 7, height = 7, pointsize = pointsize, res = res)
        plot(d, which = "angles")
        # v
        pngName <- paste0("ad2cp_", gsub(".*/", "", file), "_v.png")
        png(pngName, unit = "in", width = 7, height = 7, pointsize = pointsize, res = res)
        par(mfrow = c(4, 1))
        ylim <- c(-1, 1) * max(abs(d[["v"]]))
        plot(d, ylim = ylim)
        dev.off()
        # distance
        pngName <- paste0("ad2cp_", gsub(".*/", "", file), "_distance.png")
        png(pngName, unit = "in", width = 7, height = 7, pointsize = pointsize, res = res)
        ylim <- range(d[["distance"]])
        plot(d, which = "distance", ylim = ylim)
        dev.off()
    }
}
