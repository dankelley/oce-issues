library(oce)
d <- read.oce("PLNKG_2019004_1_1_Z.ODF")
# Find what's there
summary(d)
# Count by species
table(d[["taxonomicName"]])

