library(oce)
library(testthat)
if (!length(ls(pattern='^d$')))
    d <- read.amsr("f34_20160102v7.2.gz")
## Test accessors (sensible for temperature?)
median(d[["SSTDay"]], na.rm=TRUE)
median(d[["SSTNight"]], na.rm=TRUE)
data("coastlineWorld")

## Visual test: units OK?
summary(d)

if (!interactive()) png("839a.png", pointsize=12)
par(mfrow=c(2,2))
asp <- 1/cos(45*pi/180)
xlim <- c(-70, -20)
ylim <- c(0, 90)
plot(d, 'SSTDay', xlim=c(-70, -20), ylim=c(0,90), col=oceColorsJet)
lines(coastlineWorld[["longitude"]], coastlineWorld[["latitude"]])

plot(d, 'SSTNight', xlim=c(-70, -20), ylim=c(0,90), col=oceColorsJet)
lines(coastlineWorld[["longitude"]], coastlineWorld[["latitude"]])

plot(d, 'SST', xlim=c(-70, -20), ylim=c(0,90), col=oceColorsJet)
lines(coastlineWorld[["longitude"]], coastlineWorld[["latitude"]])

plot(c(0,1), c(0,1), xlab="", ylab="", type='n', axes=FALSE)
text(0.0, 0.6, "Note how the white day", cex=0.8, pos=4)
text(0.0, 0.5, "& night missing-value", cex=0.8, pos=4)
text(0.0, 0.4, "wedges become diamonds.", cex=0.8, pos=4)

if (!interactive()) dev.off()

## Check whether 'raw' access OK
loni <- 1272
lati <- 580
expect_true(is.numeric(d[['SSTDay']][loni,lati]))
expect_true(is.raw(d[['SSTDay','raw']][loni,lati]))
plot(d, 'SST', col=oceColorsJet)
