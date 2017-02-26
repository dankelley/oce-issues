library(oce)
## test inference of conductivity unit
files <- c("01dk.cnv", "02dk.cnv", "03dk.cnv", "04dk.cnv")
Cunit <- c("unknown", "mS/cm", "mS/cm", "unknown")
Tunit <- c("IPTS-68", "ITS-90", "ITS-90", "IPTS-68")
for (i in seq_along(files)) {
    d <- read.oce(files[i])
    cat("File", files[i], "has conductivity unit: ", d[["conductivityUnit"]], "\n")
    stopifnot(all.equal(d[["conductivityUnit"]], Cunit[i]))
    cat("File", files[i], "has temperature unit: ", d[["temperatureUnit"]], "\n")
    stopifnot(all.equal(d[["temperatureUnit"]], Tunit[i]))
}
