library(oce)
e <- read.csv("CO-OPS_8720218_wl.csv")
t <- as.POSIXct(paste(e$Date, e$Time..GMT.), tz="UTC")
e <- e$Verified..m.
sl <- as.sealevel(e, t)
summary(tidem(sl))

