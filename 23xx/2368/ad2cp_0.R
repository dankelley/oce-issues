library(oce)
# source("~/git/oce/R/adp.nortek.ad2cp.bottom.track.R")
files <- c(
    "~/Downloads/104561_20250219T093916UTC.AD2CP", # issue's file
    "~/Downloads/S102791A003_Barrow_2022_0001_sub.ad2cp" # Clark's file
)
for (file in files[2]) {
    cat("file=", file, "\n", sep = "")
    d <- try(read.adp.ad2cp(file, dataType = "bottomTrack", debug = 2))
    if (inherits(d, "try-error")) {
        message("FAILURE TO READ")
    } else {
        if (FALSE) {
            pngName <- paste0("ad2cp_", gsub(".*/", "", file), ".png")
            png(pngName, unit = "in", width = 7, height = 7, pointsize = 9, res = 200)
            par(mfrow = c(2, 2))
            oce.plot.ts(d[["time"]], d[["v"]][, 1])
            oce.plot.ts(d[["time"]], d[["v"]][, 2])
            oce.plot.ts(d[["time"]], d[["v"]][, 3])
            oce.plot.ts(d[["time"]], d[["v"]][, 4])
            dev.off()
            message("Plotted to ", pngName)
        }
    }
}
