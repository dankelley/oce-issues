library(oce)
d <- read.ctd.ssda("14190549.csv")
summary(d)
plot(d, span=3000)

# Finally, print some values for checking against the file.
head(data.frame(S=d[["salinity"]], T=d[["temperature"]], p=d[["pressure"]]))

