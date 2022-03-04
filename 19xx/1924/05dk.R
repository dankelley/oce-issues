library(oce)
source("ctd.aml.R")

file <- "Custom.export.026043_2021-07-21_17-36-45.txt"
ctd <- read.ctd.aml(file)
summary(ctd)
if (!interactive()) png("05dk.png")
plot(ctd)
if (!interactive()) dev.off()
