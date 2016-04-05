rm(list=ls())
library(oce)
data(ctd)

## create a fake section from modified `ctd` profiles
ctd1 <- ctd
ctd2 <- ctd
ctd2[['longitude']] <- ctd2[['longitude']] + 1
ctd2[['startTime']] <- ctd2[['startTime']] + 3600
ctd3 <- ctd
ctd3[['longitude']] <- ctd3[['longitude']] + 2
ctd3[['startTime']] <- ctd3[['startTime']] + 3600*2
ctd4 <- ctd
ctd4[['longitude']] <- ctd4[['longitude']] + 3
ctd4[['startTime']] <- ctd4[['startTime']] + 3600*3
ctd5 <- ctd
ctd5[['longitude']] <- ctd5[['longitude']] + 4
ctd5[['startTime']] <- ctd5[['startTime']] + 3600*4

d <- list(ctd1, ctd2, ctd3, ctd4, ctd5)
sec <- as.section(d)

if (!interactive()) png('907b.png')
plot(sec, which='temperature', xtype='time')
if (!interactive()) dev.off()

