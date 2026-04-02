# vim:textwidth=80:expandtab:shiftwidth=4:softtabstop=4:foldmethod=marker
library(oce)
debug <- 0
files <- c(
    "/Users/kelley/Downloads/104561_20250219T093916UTC.AD2CP", # issue's file
    "/Users/kelley/Downloads/S102791A003_Barrow_2022_0001_sub.ad2cp", # Clark's first file
    "/Users/kelley/Downloads/S102791A003_Barrow_2022_0005_sub.ad2cp" # Clark's second file
)
createPlots <- TRUE

for (file in files[3]) {
    cat("file=", file, "\n", sep = "")
    d <- try(read.adp.ad2cp(file, dataType = "bottomTrack", debug = debug))
    if (inherits(d, "try-error")) {
        message("FAILURE TO READ")
    } else {
        res <- 150
        pointsize <- 14 # make big because with lots of panels, it defaults to too small
        if (createPlots) {
            # {{{ p,t
            pngName <- paste0("ad2cp_", gsub(".*/", "", file), "_p_and_T.png")
            png(pngName, unit = "in", width = 7, height = 7, pointsize = pointsize, res = res)
            par(mfrow = c(2, 1))
            oce.plot.ts(d[["time"]], d[["pressure"]])
            oce.plot.ts(d[["time"]], d[["temperature"]])
            dev.off()
            cat("Plotted pressure,temperature in", pngName, "\n")
            # }}}
            # {{{ head,pitch,roll
            pngName <- paste0("ad2cp_", gsub(".*/", "", file), "_angles.png")
            png(pngName, unit = "in", width = 7, height = 7, pointsize = pointsize, res = res)
            par(mfrow = c(3, 1))
            oce.plot.ts(d[["time"]], d[["heading"]])
            oce.plot.ts(d[["time"]], d[["pitch"]])
            oce.plot.ts(d[["time"]], d[["roll"]])
            dev.off()
            cat("Plotted angles in", pngName, "\n")
            # }}}
            # {{{ v
            pngName <- paste0("ad2cp_", gsub(".*/", "", file), "_v.png")
            png(pngName, unit = "in", width = 7, height = 7, pointsize = pointsize, res = res)
            par(mfrow = c(4, 1))
            ylim <- c(-1, 1) * max(abs(d[["v"]]))
            oce.plot.ts(d[["time"]], d[["v"]][, 1], ylim = ylim)
            oce.plot.ts(d[["time"]], d[["v"]][, 2], ylim = ylim)
            oce.plot.ts(d[["time"]], d[["v"]][, 3], ylim = ylim)
            oce.plot.ts(d[["time"]], d[["v"]][, 4], ylim = ylim)
            dev.off()
            cat("Plotted v in", pngName, "\n")
            # }}}
            # {{{ distance
            pngName <- paste0("ad2cp_", gsub(".*/", "", file), "_distance.png")
            png(pngName, unit = "in", width = 7, height = 7, pointsize = pointsize, res = res)
            par(mfrow = c(4, 1))
            ylim <- range(d[["distance"]])
            oce.plot.ts(d[["time"]], d[["distance"]][, 1], ylim = ylim)
            oce.plot.ts(d[["time"]], d[["distance"]][, 2], ylim = ylim)
            oce.plot.ts(d[["time"]], d[["distance"]][, 3], ylim = ylim)
            oce.plot.ts(d[["time"]], d[["distance"]][, 4], ylim = ylim)
            dev.off()
            cat("Plotted distance in", pngName, "\n")
            # }}}
        }
    }
}
