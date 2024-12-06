library(oce)
source("~/git/oce/R/oce.R")
source("~/git/oce/R/misc.R")
source("~/git/oce/R/imagep.R")
t0 <- as.POSIXct("2024-01-01 00:00:00", tz = "UTC")
n <- 4 # 4: pretty fails
n <- 6 # 4: pretty fails
t <- seq(t0, by = "month", length.out = n)
y <- seq_along(t)
g <- oce.plot.ts(t, y,
    type = "n", drawTimeRange = FALSE,
    grid = TRUE,
    grid.col = 2, grid.lty = 1, grid.lwd = 2
)
mtext("red=old internal; blue=trial new internal; yellow-dash=oce.grid()")
abline(v=g$xat, lwd=1, col = "yellow", lty = 2)
