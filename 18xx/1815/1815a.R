library(oce)
par(mfrow=c(2,1), mgp=c(2, 0.7, 0))
x <- cumsum(rnorm(100))
t <- as.POSIXct(Sys.time(), tz='UTC') + 3600*seq_along(x)
cm <- colormap(t)

# Temporal case
par(mar=c(3.5,3.5,2,2))
drawPalette(colormap=cm)
plot(t, x, col=cm$zcol, pch=20)

# Numeric case
par(mar=c(3.5,3.5,2,2))
x <- cumsum(rnorm(100))
tn <- as.numeric(t - t[1]) / 86400
cmn <- colormap(tn)
drawPalette(colormap=cmn)
plot(tn, x, col=cmn$zcol, pch=20)
