## use dolfyn-supplied test data, one file with IMU, the other without it.

library(oce)

message("\n* ~/src/dolfyn/example_data/vector_data_imu01.VEC")
dimu <- read.oce("~/src/dolfyn/example_data/vector_data_imu01.VEC")
summary(dimu)
if (!interactive()) png("887d.png")
par(mfrow=c(3,1), mar=c(3, 3, 1, 1), mgp=c(2, 0.7, 0))
plot(dimu[['IMUtime']], dimu[['IMUaccelx']], type='l')
plot(dimu[['IMUtime']], dimu[['IMUaccely']], type='l')
plot(dimu[['IMUtime']], dimu[['IMUaccelz']], type='l')
if (!interactive()) dev.off()

