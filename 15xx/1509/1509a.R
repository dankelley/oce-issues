library(oce)

t <- seq(as.POSIXct('2019-03-01 00:00:00', tz='UTC'),
         as.POSIXct('2019-03-02 00:00:00', tz='UTC'), 60)
y <- rnorm(t)
z <- seq_along(y)

if (!interactive()) png('1509a-%03d.png')

cm <- colormap(y)
par(mfrow=c(2, 1))
plot(t, y, col=cm$zcol, pch=19, cex=0.5)
title('No trimming -- colours are the same in each plot')
oce.plot.ts(t, y, type='p', col=cm$zcol, pch=19, cex=0.5)

focus <- as.POSIXct(c('2019-03-01 06:00:00', '2019-03-01 18:00:00'), tz='UTC')

plot(t, y, col=cm$zcol, pch=19, cex=0.5, xlim=focus)
title('xlim provided; colours look ok')
oce.plot.ts(t, y, type='p', col=cm$zcol, pch=19, cex=0.5, xlim=focus)
title('xlim provided; colours should look the same as above')

if (!interactive()) dev.off()
