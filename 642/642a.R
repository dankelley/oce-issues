library(oce)
try(source("~/src/oce/R/logger.R"))
try(source("~/src/oce/R/ctd.R"))
logger <- read.logger('file.rsk')
str(logger)
ctd <- as.ctd(logger)
str(ctd)

