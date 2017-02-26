rm(list=ls())
library(oce)

if (!interactive()) png('882a-%03d.png')
## read the "old" rsk version
d <- read.rsk('060130_20150720_1135.rsk')
plot(d)
title('rskVersion < 1.12.2')
## read the "upgraded" version (with datasetID in data table)
d <- read.rsk('060130_20150720_1135_upgraded.rsk')
plot(d)
title('rskVersion >= 1.12.2')
if (!interactive()) dev.off()
