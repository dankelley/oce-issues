library(oce)
if (!interactive()) png("1070a_%03d.png")
t0 <- as.POSIXct("2016-07-01", tz="UTC")
x <- c(1, 2)
step <- c(1, 60, 3600, 86400, 28*86400, 12*28*86400)
onetwofive <- c(1, 2, 5)
for (istep in seq_along(step)) {
    for (ionetwofive in seq_along(onetwofive)) {
        t <- c(t0, t0 + onetwofive[ionetwofive] * step[istep])
        oce.plot.ts(t, x, type='o', debug=3)
        mtext(paste("step[", istep, "] =", step[istep],
                    ", onetwofive[", ionetwofive, "] = ", onetwofive[ionetwofive], sep=""),
              side=1, line=1.75)
        grid()
    }
}
if (!interactive()) dev.off()

