library(oce)
file <- "~/Dropbox/S101135A001_Ronald.ad2cp"
d <- read.oce(file, debug=5)
if (!interactive()) png("1676b.png")
plot(d)
summary(d)
if (!interactive()) dev.off()

