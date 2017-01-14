## use dolfyn-supplied test data, one file with IMU, the other without it.

library(oce)

message("\n* ~/src/dolfyn/example_data/vector_data_imu01.VEC")
dimu <- read.oce("~/src/dolfyn/example_data/vector_data_imu01.VEC")
#plot(dimu)
summary(dimu)

message("\n* ~/src/dolfyn/example_data/vector_data01.VEC")
d <- read.oce("~/src/dolfyn/example_data/vector_data01.VEC")
#plot(d)
summary(d)

