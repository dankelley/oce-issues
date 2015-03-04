library(oce)
#source('adp.rdi.R')

d <- read.adp.rdi('UW2015-02000_000000.ENS', debug=10)

if (!interactive()) png('594A-%02d.png')

plot(d)

plot(d, which=5:8)

if (!interactive()) dev.off()
