if (!interactive()) png("520.png")
library(oce)
try({
    source("~/src/oce/R/ctd.R")
})
data(ctd)
ctd[['longitude']] <- -5
ctd[['latitude']] <- -30
plot(ctd)
if (!interactive()) dev.off()

