library(oce)
data(section)
section <- handleFlags(section)
if (dir.exists("~/git/oce")) {         # speed development
    source("~/git/oce/R/sw.R")
    source("~/git/oce/R/ctd.R")
    source("~/git/oce/R/section.R")
}

# 1. Specified contour levels
# Top: automatic labels; bottom: user-specified labels.
par(mfrow=c(2,1))
plot(section, which="temperature",
    contourLevels=seq(5,15,5))
plot(section, which="temperature",
    contourLevels=seq(5,15,5),
    contourLabels=c("cold","intermediate","warm"))


