library(oce)
source("~/git/oce/R/oce.R")
source("~/git/oce/R/misc.R")
source("~/git/oce/R/imagep.R")
t0 <- as.POSIXct("2024-01-01 00:00:00", tz = "UTC")
i <- 1
for (by in c("sec", "min", "hour", "day", "month", "year")) {
    for (n in (3:10)) {
        pngname <- sprintf("issue2267a_%02d_%s_%d.png", i, by, n)
        i <- i + 1
        message(pngname)
        if (!interactive()) {
            png(pngname, unit="in", width=7, height=2, pointsize=10, res=300)
        }
        t <- seq(t0, by = by, length.out = n)
        y <- seq_along(t)
        g <- oce.plot.ts(t, y,
                         type = "n", drawTimeRange = FALSE,
                         grid = TRUE,
                         grid.col = "red", grid.lty = 1, grid.lwd = 1,
                         debug = 1 # prints trace + turns on the blue grid lines
        )
        mtext(sprintf("by=%s,n=%d (blue=OLD; red=NEW; yellow-dash=oce.grid()",
                      by,n), cex = 0.7)
        abline(v=g$xat, lwd=1, col = "yellow", lty = 2)
        if (!interactive()) {
            dev.off()
        }
    }
}
