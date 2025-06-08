library(oce)
file <- "~/Dropbox/oce_secret_data/ad2cp/S101088A009_Nain_2022_0001_sub.ad2cp"
if (file.exists(file)) {
    if (!interactive()) png("2323a_%02d.png", unit = "in", width = 7, height = 7, res = 300)
    TOC <- read.adp.ad2cp(file, TOC = TRUE) # indicates 34 'averageAltimeter' entries
    print(TOC)
    d <- read.adp.ad2cp(file, dataType = "averageAltimeter")
    print(str(d))
    # imagep(d[["altimeterRawSamples"]])

    # DK messing around to try to find a combination that will yield
    # an image that seems to make sense.  I tried changing 'byrow' and 'nrow'
    # below but I don't think any combination looked like clean data.
    x <- d[["altimeterRawSamples"]]
    dim <- dim(x)
    xv <- as.vector(x)
    # file 1
    par(mfrow = c(2, 2))
    # imagep(x, mar = c(2, 2, 1, 1))
    X <- matrix(xv, byrow = FALSE, nrow = dim[1])
    imagep(X, mar = c(2, 2, 1, 1))
    abline(h = d[["altimeterRawNumberOfSamples"]] / 2, col = "white", lwd = 2)
    mtext("byrow=FALSE,nrow=dim[1], i.e. default", cex = par("cex"))
    X <- matrix(xv, byrow = FALSE, nrow = dim[2])
    imagep(X, mar = c(2, 2, 1, 1))
    mtext("byrow=FALSE,nrow=dim[2]", cex = par("cex"))
    X <- matrix(xv, byrow = TRUE, nrow = dim[1])
    imagep(X, mar = c(2, 2, 1, 1))
    mtext("byrow=TRUE,nrow=dim[1]", cex = par("cex"))
    X <- matrix(xv, byrow = TRUE, nrow = dim[2])
    imagep(X, mar = c(2, 2, 1, 1))
    mtext("byrow=TRUE,nrow=dim[2]", cex = par("cex"))
    par(mfrow = c(5, 1))
    # file 2
    with(d@data, {
        oce.plot.ts(time, temperature)
        oce.plot.ts(time, pressure)
        oce.plot.ts(time, heading)
        oce.plot.ts(time, pitch)
        oce.plot.ts(time, roll)
    })
    par(mfrow=c(4,1))
    plot(x[1, ], pch=".")
    mtext("time 1", cex=par("cex"))
    plot(x[2, ], pch=".")
    mtext("time 2", cex=par("cex"))
    plot(x[10, ], pch=".")
    mtext("time 10", cex=par("cex"))
    plot(x[21, ], pch = ".")
    mtext("time 11", cex=par("cex"))
    if (!interactive()) dev.off()
}
