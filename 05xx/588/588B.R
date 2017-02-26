library(oce)
d1 <- subset(d, pressure > 2)
options(warn=3)
d2 <- ctdTrim(d1, debug=3) 
d3 <- ctdDecimate(d2)
if (!interactive()) png("588B.png")
plot(d3)
if (!interactive()) dev.off()

