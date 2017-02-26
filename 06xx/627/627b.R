library(oce)
data(ctd)
## This does not have conductivity, so add it
salinity <- ctd[["salinity"]]
temperature <- ctd[["temperature"]]
pressure <- ctd[["pressure"]]
conductivity <- swCSTp(salinity, temperature, pressure, eos="unesco")
ctd <- ctdAddColumn(ctd, conductivity, "conductivity")
S <- swSCTp(ctd)
misfit <- sqrt(mean((S-salinity)^2))
stopifnot(misfit < 1e-3)

