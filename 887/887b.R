library(oce)
try(source("~/src/oce/R/adv.nortek.R")) # contains some message("TEST..") lines
d <- read.adv.nortek("~/src/dolfyn/example_data/vector_data_imu01.VEC", from=1, to=1000)
names(d@data)
