library(oce)
try(source("~/src/oce/R/logger.R"))
try(source("~/src/oce/R/ctd.R"))
logger <- read.logger('file.rsk')
str(logger@metadata)
ctd <- as.ctd(logger)
profiles <- ctdFindProfiles(ctd)
str(ctd@metadata)
if (!interactive()) png("642b-%02d.png")
for (i in 1:length(profiles)) {
    plot(profiles[[i]])
}
if (!interactive()) dev.off()
