library(oce)
file <- "~/data/argo/D6902967_001.nc"
if (file.exists(file)) {
    argo <- read.argo(file)
    ctd <- as.ctd(argo, profile = 1)
    print(ctd[["station"]])
    print(ctd@metadata$station)
}
