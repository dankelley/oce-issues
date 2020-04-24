library(oce)
files <- list.files(pattern="*.BTL")   # e.g. "001A001.BTL"
for (i in seq_along(files)) {
    d <- read.ctd.sbe(files[i], btl=TRUE)
    summary(d)
    cat("\nT036C stddv/avg: ", d[["T068C_sdev"]] / d[["T068C"]], "\n")
}


