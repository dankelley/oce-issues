library(oce)
try(source("~/src/oce/R/section.R"))
data(argo)
argo <- handleFlags(subset(argo, dataMode=="D"))
sec <- as.section(argo)
par(mfrow=c(2,1))
plot(sec, xtype="time", which="temperature")
plot(sec, xtype="distance", which="temperature")

