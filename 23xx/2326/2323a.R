library(oce)
file <- "~/Dropbox/oce_secret_data/ad2cp/S101088A009_Nain_2022_0001_sub.ad2cp"
if (file.exists(file)) {
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
    X <- matrix(xv, byrow = FALSE, nrow = dim[1])
    # X <- matrix(xv, byrow=FALSE, nrow=dim[2])
    # X <- matrix(xv, byrow=!FALSE, nrow=dim[1])
    # X <- matrix(xv, byrow=!FALSE, nrow=dim[2])
    par(mfrow = c(2, 1))
    imagep(x, mar = c(2, 2, 1, 1))
    title("Original")
    imagep(X, mar = c(2, 2, 1, 1))
    title("Modified")
}
