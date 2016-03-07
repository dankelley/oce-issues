library(oce)
try(source("~/src/oce/R/imagep.R")) # contains some message("TEST..") lines
try(source("~/src/oce/R/adv.R")) # contains some message("TEST..") lines
try(source("~/src/oce/R/adv.nortek.R")) # contains some message("TEST..") lines
try(source("~/src/oce/R/oce.R"))
try(source("~/src/oce/R/misc.R"))
message("\n* ~/src/dolfyn/example_data/vector_data_imu01.VEC")
message(oceMagic("~/src/dolfyn/example_data/vector_data_imu01.VEC"))
d <- read.oce("~/src/dolfyn/example_data/vector_data_imu01.VEC", from=1, to=100)
plot(d)
d <- read.adv.nortek("~/src/dolfyn/example_data/vector_data_imu01.VEC", from=1, to=100)
plot(d)
names(d@data)

message("\n* ~/src/dolfyn/example_data/vector_data01.VEC")
message(oceMagic("~/src/dolfyn/example_data/vector_data01.VEC"))
d <- read.oce("~/src/dolfyn/example_data/vector_data01.VEC", from=1, to=100)
plot(d)
d <- read.adv.nortek("~/src/dolfyn/example_data/vector_data01.VEC", from=1, to=100)
plot(d)
names(d@data)
