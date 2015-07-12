## https://github.com/dankelley/oce/issues/692

library(oce)
try(source("~/src/oce/R/ctd.R")) # DK uses for faster code-test cycle

## PART 1: rsk conversion
file <- system.file("extdata", "sample.rsk.gz", package="oce")
tmp <- tempfile(fileext=".rsk")
R.utils::decompressFile(file, destname=tmp, ext="gz", FUN=gzfile, remove=FALSE)
rsk <- read.rsk(tmp)
rsk[["filename"]] <- "sample.rsk" # trick it ... otherwise a tmp file
ctd <- as.ctd(rsk)

stopifnot(all.equal(ctd[["filename"]], rsk[["filename"]]))
stopifnot(all.equal(ctd[["serialNumber"]], rsk[["serialNumber"]]))
names <- c("pressure", "temperature", "salinity", "conductivity", "sigmaTheta")
stopifnot(length(names) == sum(names %in%  ctd[["names"]]))
labels <- c("Pressure", "Temperature", "Salinity", "Conductivity", "Sigma Theta")
stopifnot(length(labels) == sum(labels %in%  ctd[["labels"]]))
stopifnot(all.equal("ITS-90", ctd[["temperatureUnit"]]))
stopifnot(all.equal(rsk[["temperatureUnit"]], ctd[["temperatureUnit"]]))
stopifnot(all.equal("mS/cm", ctd[["conductivityUnit"]]))
stopifnot(is.na(ctd[["waterDepth"]]))  # @richardc -- agreed?

## PART 2: waterDepth
stopifnot(is.na(as.ctd(1:10, 1:10, 1:10)[["waterDepth"]])) # @richardc -- agreed?

