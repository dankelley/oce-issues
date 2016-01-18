rm(list=ls())
library(oce)
try(source("~/src/oce/R/argo.R"))
try(source("~/src/R-richards/oce/R/argo.R"))

d <- read.argo('~/src/oce/create_data/argo/6900388_prof.nc')

## Want to test adding and subsetting other fields
d <- oceSetData(d, 'oxygen', d[['temperature']]*rnorm(d[['temperature']]),
                units=list(unit=expression(mu*mol/kg), scale=''))
dg <- argoGrid(d)

ds <- subset(d, dataMode == "D")
dgs <- subset(dg, pressure <= 1000)

if (!interactive()) png("830b.png")
plot(d)
points(ds[['longitude']], ds[['latitude']], col=2)
if (!interactive()) dev.off()

