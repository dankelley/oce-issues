library(oce)
rsk <- read.rsk("cast4.rsk")
ctd <- as.ctd(rsk)
Srsk <- swSCTp(rsk)
ctd <- as.ctd(rsk)
Sctd <- swSCTp(ctd)
stopifnot(identical(Sctd, Srsk))

