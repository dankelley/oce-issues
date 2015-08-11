rm(list=ls())
library(oce)
source('~/src/oce/R/oce.R') # for updated oceMagic from rsktxt branch
source('~/src/oce/R/imagep.R') # to allow oce.plot.ts to work
source('~/src/oce/R/rsk.R') # for updated read.rsk

d <- read.rsk('060130_20150720_1135.txt', type='txt', debug=10)
## d <- read.rsk('010858_20150225_1139.eng.txt', type='txt', debug=10)

if (!interactive()) png('712a.png')

plot(d)

if (!interactive()) dev.off()
