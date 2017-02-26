library(oce)
d1 <- read.odf(system.file("extdata", "CTD_BCD2014666_008_1_DN.ODF", package="oce")) 
summary(d1)

d2 <- read.ctd(system.file("extdata", "CTD_BCD2014666_008_1_DN.ODF", package="oce")) 
summary(d2)

d3 <- as.ctd(d1)
summary(d3)
