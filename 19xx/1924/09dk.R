library(oce)

f <- "Custom.export.026043_2021-07-21_17-36-45.txt"
d <- read.oce(f)
summary(d)
if (!interactive()) png("09dk.png")
plot(d)
if (!interactive()) dev.off()
