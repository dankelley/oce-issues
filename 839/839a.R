library(oce)
## try(source("~/src/oce/R/amsr.R"))
d <- read.amsr("f34_20160102v7.2.gz")
## Test accessors (sensible for temperature?)
median(d[["SSTDay"]], na.rm=TRUE)
median(d[["SSTNight"]], na.rm=TRUE)
## Test summary (are they in right units?)
summary(d)


## Plot default and named channels
if (!interactive()) png("839a.png", pointsize=9)
par(mfrow=c(2,1))
plot(d) # default SSTDay
plot(d, 'SSTNight')
if (!interactive()) dev.off()

