library(oce)
f <- "~/Downloads/Suisun_test.ad2cp"
if (file.exists(f)) {
    options("oceDebugAD2CP" = TRUE) # to export 'DAN'
    TOC <- read.adp.ad2cp(f, TOC = TRUE, plan = 2)
    print(TOC)
    dataTypes <- TOC$dataType
    dataTypes <- dataTypes[dataTypes != "text"]
    for (dataType in dataTypes[[1]]) { # "burst") {
        message("trying to read dataType \"", dataType, "\"")
        d <- read.adp.ad2cp(f, dataType = dataType, debug = 2)
        if (is.null(d)) {
            message("No ", dataType, "data found in file")
        } else {
            message("    ... got ", length(d[["time"]]), " time entries")
            summary(d)
        }
    }

    if (!interactive()) {
        png("oce2303a.png",
            unit = "in",
            width = 7, height = 4, res = 400, pointsize = 10
        )
    }
    par(mfrow = c(2, 1), mar = c(3, 3, 1, 1), mgp = c(2, 0.7, 0))
    #plot(DAN$activeConfiguration, type = "p", pch = ".")
    #t <- table(DAN$activeConfiguration)
    #mtext(sprintf(
    #    "activeConfigure (plan): %d instances of 0 and %d of 1",
    #    t[1], t[2]
    #))
    #r <- c(4450, 4550)
    #abline(v = r, col = 2)
    #plot(DAN$activeConfiguration,
    #    type = "p", pch = 20,
    #    xlim = r
    #)
    if (!interactive()) {
        dev.off()
    }
}
