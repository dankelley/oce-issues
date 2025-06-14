library(oce)
file <- "~/Dropbox/oce_secret_data/ad2cp/S101088A009_Nain_2022_0001_sub.ad2cp"
if (file.exists(file)) {
    if (!interactive()) png("2323a_%02d.png", unit = "in", width = 7, height = 7, res = 300)
    TOC <- read.adp.ad2cp(file, TOC = TRUE)
    text <- read.adp.ad2cp(file, dataType = "text")
    print(text)
    d <- read.adp.ad2cp(file, dataType = "averageAltimeter", debug = 3)
    # print(str(d))
    # imagep(d[["altimeterRawSamples"]])
    

    # DK messing around to try to find a combination that will yield
    # an image that seems to make sense.  I tried changing 'byrow' and 'nrow'
    # below but I don't think any combination looked like clean data.
    x <- d[["altimeterRawSamples"]]
    # Create 2323a_01.png
    imagep(x, mar = c(2, 2, 1, 1))
    # Create 2323a_02.png
    par(mfrow = c(5, 1))
    with(d@data, {
        oce.plot.ts(time, temperature)
        oce.plot.ts(time, pressure)
        oce.plot.ts(time, heading)
        oce.plot.ts(time, pitch)
        oce.plot.ts(time, roll)
    })
    # Create 2323a_03.png
    par(mfrow = c(4, 1))
    plot(x[1, ], pch = ".")
    mtext("time 1", cex = par("cex"))
    plot(x[2, ], pch = ".")
    mtext("time 2", cex = par("cex"))
    plot(x[10, ], pch = ".")
    mtext("time 10", cex = par("cex"))
    plot(x[21, ], pch = ".")
    mtext("time 11", cex = par("cex"))
    if (!interactive()) dev.off()
    message("range(altimeterRawSamples): ", paste(range(x), collapse = ","))
    print(dim(x))
}
