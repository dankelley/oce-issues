library(oce)
try(source("~/src/oce/R/odf.R"))
print(system.time(d <- read.odf("MCM_HUD2013021_1841_3508_300.ODF")))
try({
    library(ODF)
    print(system.time(D <- read_odf("MCM_HUD2013021_1841_3508_300.ODF")))
    D2 <- as.oce(D)
})
d
D2
