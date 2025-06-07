library(oce)
file <- "~/Dropbox/oce_secret_data/ad2cp/S101088A009_Nain_2022_0001_sub.ad2cp"
if (file.exists(file)) {
    TOC <- read.adp.ad2cp(file, TOC = TRUE) # indicates 34 'averageAltimeter' entries
    print(TOC)
    d <- read.adp.ad2cp(file, dataType = "averageAltimeter")
    print(str(d))
}
