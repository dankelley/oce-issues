library(oce)
d <- read.oce("test.ad2cp")# , debug=5)
if (!interactive()) png("1676a.png")
plot(d)
if (!interactive()) dev.off()

