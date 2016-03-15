library(oce)
## d1 <- read.adv.nortek("~/Dropbox/OCE-ADV-IMU-Mr2/15080902.vec")
## vectorShow(d1[['time']])

dI <- read.adv.nortek("~/Dropbox/OCE-ADV-IMU-Mr2/I5080902.VEC")
vectorShow(dI[['time']])
vectorShow(dI[['IMUtime']])

look <- 1:100
oce.plot.ts(dI[['time']][look], dI[['IMUtime']][look], type='o')

