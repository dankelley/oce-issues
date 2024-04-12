library(oce)
t0 <- as.POSIXct("2024-03-12 00:00:00", tz = "UTC")
t <- seq(t0, by = "1 hour", length.out = 24)
y <- sin(pi * seq_along(t) / 24)
p <- function(...) oce.plot.ts(t, y, drawTimeRange = FALSE, ...)

if (!interactive()) png("2205a_%d.png")

# test xaxs and yaxs
p()
p(xaxs = "i")
p(yaxs = "i")
p(xaxs = "i", yaxs = "i")

# test xlim and ylim
p()
p(xlim = c(t0, t0 + 48 * 3600))
p(ylim = c(0, 2))
p(xlim = c(t0, t0 + 48 * 3600), ylim = c(0, 2))

# test xlim and ylim with xaxs="i"
p(xaxs = "i")
p(xlim = c(t0, t0 + 48 * 3600), xaxs = "i")
p(ylim = c(0, 2), xaxs = "i")
p(xlim = c(t0, t0 + 48 * 3600), ylim = c(0, 2), xaxs = "i")

# test xlim and ylim with yaxs="i"
p(yaxs = "i")
p(xlim = c(t0, t0 + 48 * 3600), yaxs = "i")
p(ylim = c(0, 2), yaxs = "i")
p(xlim = c(t0, t0 + 48 * 3600), ylim = c(0, 2), yaxs = "i")
