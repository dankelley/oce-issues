## Trying to figure out how to read "encoded" variables names as
## sensible plain text names. E.g. for dissolved o2

## should also remove spaces from names (e.g. `chlorophyll a` to `chlorophylla`)

## Also, why is read.rsk getting the chlorophyll wrong and calling it ph?
##   ** Ok, this is a grep thing. It's because it's finding `ph` in `cholorphyll`. Use `match()` instead

rm(list=ls())
library(oce)

if (!interactive()) png('726b-%03d.png')

d <- read.rsk('080284_20151106_1625.rsk')
plot(d)


if (!interactive()) dev.off()
