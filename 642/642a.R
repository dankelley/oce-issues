library(oce)
logger <- read.logger('file.rsk')
print(names(logger@metadata))
ctd <- as.ctd(logger)
print(names(ctd@metadata))

