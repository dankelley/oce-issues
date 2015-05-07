library(oce)
logger <- read.logger('file.rsk')
str(logger@metadata)
ctd <- as.ctd(logger)
str(ctd@metadata)

