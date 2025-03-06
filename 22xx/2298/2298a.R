library(oce)
f <- "met_43405_hourly_2024_12_01.csv"
d <- read.csv("met_43405_hourly_2024_12_01.csv", header = TRUE)
met <- read.met(f)
bad <- which(d$Stn.Press.Flag == "M")
d[bad + seq(-1, 1), ]
readLines(f)[bad + seq(-1, 1)]
summary(met)
