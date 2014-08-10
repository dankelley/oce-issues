if (!interactive()) png("520.png")
library(oce)
try({
    source("~/src/oce/R/ctd.R")
    source("~/src/oce/R/coastline.R")
    source("~/src/oce/R/map.R")
})
data(ctd)
par(mfrow=c(2,2))

ctd[['latitude']] <- 20
ctd[['longitude']] <- -50
plot(ctd, which='map')
mtext("non-projected", font=2, col='purple', adj=0)
plot(ctd, which='map', projection="automatic")
mtext("projected", font=2, col='purple', adj=0)

ctd[['latitude']] <- 72
ctd[['longitude']] <- 0
plot(ctd, which='map')
mtext("non-projected", font=2, col='purple', adj=0)

plot(ctd, which='map', proj='automatic')
mtext("projected", font=2, col='purple', adj=0)


if (!interactive()) dev.off()

