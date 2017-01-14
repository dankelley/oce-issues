rm(list=ls())
library(oce)
try(source('~/src/oce/R/ctd.R'))
try(source('~/src/R-richards/oce/R/ctd.R'))

if ('2016-01-0002.cnv' %in% list.files()) {
    system.time(d <- read.ctd.sbe('2016-01-0002.cnv'))
} else {
    message('Need the file 2016-01-0002.cnv')
}

