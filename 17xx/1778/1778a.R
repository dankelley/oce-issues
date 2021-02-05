source("read.ctd.ios.R")

if (!interactive())
    png("1778a.png")

library(oce)
ctd <- read.ctd.ios("2007-019-055.ctd")
summary(ctd)
plot(ctd)

if (!interactive())
    dev.off()


