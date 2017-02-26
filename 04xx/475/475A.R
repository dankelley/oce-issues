if (!interactive()) png("475a1.png")
library(oce)
data(ctd)
par(mfrow=c(2,1))
d <- 0
plot(ctd, which='map', span=3000, debug=d)
plot(ctd, which='map', debug=d)
if (!interactive()) dev.off()
