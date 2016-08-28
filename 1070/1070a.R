library(oce)
if (!interactive()) png("1070a_%03d.png")
par(mfrow=c(2,1))
t <- rep(as.POSIXct("2016-07-01 01:00:00", tz="UTC"), 2)
x <- c(1, 2)
step <- c(1, 60, 3600, 86400, 28*86400, 12*28*86400)
onetwofive <- c(1, 2, 5)
for (istep in seq_along(step)) {
    for (ionetwofive in seq_along(onetwofive)) {
        t[2] <- t[1] + onetwofive[ionetwofive] * step[istep]
        oce.plot.ts(t, x, type='o', debug=3)
        mtext(paste(" step[", istep, "] =", step[istep],
                    ", onetwofive[", ionetwofive, "] = ", onetwofive[ionetwofive], sep=""),
              side=3, line=-1)
        grid()
        par(mar=c(3,3,1,1))
        plot(t, x, type='o', xlab="")
        cat("istep=", istep, ", ionetwofive=", ionetwofive, "\n", sep="")
        sec  <- as.numeric(t[2]) - as.numeric(t[1])
        mtext(sprintf("%gs %gmin %ghour %gday", sec, sec/60, sec/3600, sec/86400), side=3, line=-1)
    }
}
if (!interactive()) dev.off()

