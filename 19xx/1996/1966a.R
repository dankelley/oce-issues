library(oce)
options(warn=3) # convert warnings to errors

f1 <- "CTD_98071_001_204001_DN.ODF"
d1 <- read.oce(f1)
summary(d1)

f2 <- "D9871001P.ODF"
d2 <- read.oce(f2)
summary(d2)

print(sessionInfo())


