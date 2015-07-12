library(oce)
try(source("~/src/oce/R/rsk.R"))
file <- system.file("extdata", "sample.rsk.gz", package="oce")
tmp <- tempfile(fileext=".rsk")
R.utils::decompressFile(file, destname=tmp, ext="gz", FUN=gzfile, remove=FALSE)
rsk <- read.rsk(tmp)

ctd <- as.ctd(rsk)
stopifnot(all.equal(ctd[["filename"]], rsk[["filename"]]))

