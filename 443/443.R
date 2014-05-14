library(oce)

## extract some data to use
data(adp)
t <- adp[['time']]
z <- adp[['distance']]
u <- apply(adp[['v']][,,1], 1, mean, na.rm=TRUE)
v <- apply(adp[['v']][,,2], 1, mean, na.rm=TRUE)
p <- adp[['pressure']]
spd <- sqrt(u^2 + v^2)

## ok, lets use it to plot a time series of pressure, colored for pressure
par(mfrow=c(2,1))
cm <- colormap(p)
drawPalette(colormap=cm)
oce.plot.ts(t, p, type='p', pch=21, bg=cm$zcol, mar=c(3, 3, 1, 4))

## now where I specify the breaks
cm <- colormap(p, breaks=seq(39, 42, length.out=31))
drawPalette(colormap=cm)
oce.plot.ts(t, p, type='p', pch=21, bg=cm$zcol, mar=c(3, 3, 1, 4))
