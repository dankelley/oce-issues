library(oce)
ctd <- as.ctd(read.logger('file.rsk'))
print(names(ctd@metadata))

