library(oce)
data(ctd)
salinity <- ctd[["salinity"]]
temperature <- ctd[["temperature"]]
pressure <- ctd[["pressure"]]
cond1 <- swCSTp(salinity, temperature, pressure, eos="unesco")
ctd <- ctdAddColumn(ctd, cond1, "conductivity")
cond2 <- swCSTp(ctd)
misfit <- sqrt(mean((cond1-cond2)^2))
stopifnot(misfit == 0)
