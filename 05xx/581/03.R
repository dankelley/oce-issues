trange <- as.POSIXct(c("2010-07-02 16:00:32", "2011-05-16 00:00:48"), tz='UTC')
if (!interactive()) png('03.png', width=1000, height=400)
timeConst <- seq(trange[1], trange[2], length.out=100)
plot(timeConst, seq_along(timeConst))
grid(lwd=3)
if (!interactive()) dev.off()

