rm(list=ls())
library(oce)

if ('2016-01-0002.cnv' %in% list.files()) {
    d <- read.ctd.sbe('2016-01-0002.cnv')
} else {
    message('Need the file 2016-01-0002.cnv')
}

if (!interactive()) png('915a.png')
plot(d)
if (!interactive()) dev.off()
