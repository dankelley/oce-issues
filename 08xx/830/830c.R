rm(list=ls())
library(oce)

d <- read.argo('~/src/oce/create_data/argo/6900388_prof.nc')

## Want to test adding and subsetting other fields
d <- oceSetData(d, 'oxygen', d[['temperature']]*rnorm(d[['temperature']]),
                units=list(unit=expression(mu*mol/kg), scale=''))
ds1 <- subset(d, dataMode == "D")
ds2 <- subset(argoGrid(d), pressure <= 1000)

summary(ds1)
summary(ds2)


