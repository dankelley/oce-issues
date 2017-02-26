rm(list=ls())
library(oce)

d <- read.argo('~/src/oce/create_data/argo/6900388_prof.nc')
D <- subset(d, dataMode == "D")
R <- subset(d, dataMode == "R")

summary(d)

if (!interactive()) png("830a.png")
plot(d)
points(D[['longitude']], D[['latitude']], col=2)
points(R[['longitude']], R[['latitude']], col=1)
legend('bottomright', c('delayed mode', 'realtime'),
       pch=1, col=2:1)
if (!interactive()) dev.off()

