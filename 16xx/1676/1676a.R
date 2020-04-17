library(oce)
d <- read.oce("ad2cp_01.ad2cp", debug=5)
if (!interactive()) png("1676a.png")
plot(d)
summary(d)
if (!interactive()) dev.off()

