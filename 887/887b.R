library(oce)
try(source("~/src/oce/R/adv.nortek.R")) # contains some message("TEST..") lines
message("* ~/src/dolfyn/example_data/vector_data_imu01.VEC")
d <- read.adv.nortek("~/src/dolfyn/example_data/vector_data_imu01.VEC", from=1, to=1000)
names(d@data)

message("* ~/src/dolfyn/example_data/vector_data01.VEC")
d <- read.adv.nortek("~/src/dolfyn/example_data/vector_data01.VEC", from=1, to=1000)
names(d@data)
