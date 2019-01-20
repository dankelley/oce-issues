library(oce)
d <- read.oce("~/Dropbox/oce_secret_data/01.rsk")
summary(d)
if (!interactive()) png("1483a.png", height=250)
par(mfrow=c(2, 1))
hist(d[["conductivity"]])
hist(d[["cond12"]])
if (!interactive()) dev.off()

