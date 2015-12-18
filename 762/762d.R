## read details of sampling schedule

rm(list=ls())
library(oce)
try(source('~/src/oce/R/rsk.R'))
try(source('~/src/R-richards/oce/R/rsk.R'))

if (!interactive()) png('726d-%03d.png')

d <- read.rsk('065583_20150516_1717.rsk')
plot(d)
title('')
title('from/to not provided', outer=TRUE)

if (!interactive()) dev.off()
