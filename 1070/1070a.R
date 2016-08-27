library(oce)
if (!interactive()) png("1070a_%03d.png")
par(mfrow=c(2,1))
t <- rep(as.POSIXct("2016-07-01 00:00:00", tz="UTC"), 2)
x <- c(1, 2)
step <- c(1, 60, 3600, 86400, 28*86400, 12*28*86400)
onetwofive <- c(1, 2, 5)
for (istep in seq_along(step)) {
    for (ionetwofive in seq_along(onetwofive)) {
        t[2] <- t[1] + onetwofive[ionetwofive] * step[istep]
        oce.plot.ts(t, x, type='o')
        mtext(paste(" step[", istep, "] =", step[istep],
                    ", onetwofive[", ionetwofive, "] = ", onetwofive[ionetwofive], sep=""),
              side=3, line=-1)
        grid()
        plot(t, x, type='o', xlab="")
    }
}
if (!interactive()) dev.off()

