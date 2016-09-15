rm(list=ls())
library(oce)

d <- read.table('CAST0090_downcast.txt', header=TRUE, stringsAsFactors=FALSE)

ctd <- as.ctd(salinity=d$Sal,
              temperature=d$Temp,
              pressure=d$Pres,
              conductivity = d$Cond,
              time=as.POSIXct(paste(d$Date, d$Time), tz='UTC'),
              other=list(soundVelocity = d$SoundV,
                         turbidity = d$Turb),
              )
              
ctd <- subset(ctd, pressure < 520)

if (!interactive()) png('1080a.png')

par(mfrow=c(2, 2))
plotProfile(ctd, xtype='temperature')
plotProfile(ctd, xtype='salinity')
plotProfile(ctd, xtype='turbidity')
plotTS(ctd)

if (!interactive()) dev.off()
