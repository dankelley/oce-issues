library(oce)
data(section)
stn <- section[['station', 117]] # has several bad salinities
as.data.frame(stn@data)
as.data.frame(stn@metadata$flags)
STN <- handleFlags(stn)
as.data.frame(STN@data)
as.data.frame(STN@metadata$flags)
if (!interactive()) png("1066a.png", height=300)
par(mfrow=c(1,2))
plotTS(stn)
plotTS(STN)
if (!interactive()) dev.off()

