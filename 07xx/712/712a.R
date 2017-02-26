rm(list=ls())
library(oce)

## MH's file (that started this whole thing)
## d <- read.rsk('010858_20150225_1139.eng.txt', type='txt', debug=10)

if (!interactive()) png('712a-%03d.png')

d <- read.oce('060130_20150720_1135.txt', debug=10)
plot(d)

d <- read.rsk('060130_20150720_1135.txt', type='txt', from=1000, debug=10)
plot(d)

d <- read.rsk('060130_20150720_1135.txt', type='txt', from=100, to=2000, by='00:01', debug=10)
plot(d)

d <- read.rsk('060130_20150720_1135.txt', type='txt', from=100, to=2000, by='01:00', debug=10)
plot(d)

d <- read.oce('pt_rbr_014765.dat')
plot(d)

if (!interactive()) dev.off()
