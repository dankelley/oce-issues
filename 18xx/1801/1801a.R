# Test read.odf(), read.ctd.odf() and read.oce() with an ODF file supplied with oce
library(oce)
file <- system.file("extdata", "CTD_BCD2014666_008_1_DN.ODF.gz", package="oce")

# Read temperatures straight from file
Tref <- read.table(file, skip=675, header=FALSE)$V4
Tref90 <- T90fromT68(Tref)

# read.odf()
ctd1 <- read.odf(file)
ctd1@metadata$units$temperature
all.equal(ctd1@data$temperature, Tref)
all.equal(ctd1[["temperature"]], Tref90) # should be TRUE
all.equal(ctd1[["temperature"]], Tref)   # should be FALSE

# read.ctd.odf()
ctd2 <- read.ctd.odf(file)
all.equal(ctd2@metadata$units$temperature, ctd1@metadata$units$temperature)
all.equal(ctd1@data$temperature, ctd2@data$temperature)
all.equal(ctd2[["temperature"]], Tref90) # should be TRUE
all.equal(ctd2[["temperature"]], Tref)   # should be FALSE

# read.oce()
ctd3 <- read.oce(file)
all.equal(ctd3@metadata$units$temperature, ctd1@metadata$units$temperature)
all.equal(ctd1@data$temperature, ctd3@data$temperature)
all.equal(ctd3[["temperature"]], Tref90) # should be TRUE
all.equal(ctd3[["temperature"]], Tref)   # should be FALSE
