if (!interactive()) png("477a.png")
library(oce)
data(ctd)
##ctd[['latitude']] <- 80
##ctd[['longitude']] <- 0
plot(ctd, which='map', span=2000)
if (!interactive()) dev.off()

