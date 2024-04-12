library(oce)
data(sealevel)
t0 <- sealevel[["time"]][1]
sl <- subset(sealevel, time < t0 + 86400)
p <- function(...) {
    plot(sl, which = 1, drawTimeRange = FALSE, ...)
}

#if (!interactive()) png("2205b_%d.png")

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

# test xlim and ylim with xaxs="r"
p(xaxs = "r")
p(xlim = c(t0, t0 + 48 * 3600), xaxs = "r")
p(ylim = c(0, 2), xaxs = "r")
p(xlim = c(t0, t0 + 48 * 3600), ylim = c(0, 2), xaxs = "r")

# test xlim and ylim with yaxs="i"
p(yaxs = "i")
p(xlim = c(t0, t0 + 48 * 3600), yaxs = "i")
p(ylim = c(0, 2), yaxs = "i")
p(xlim = c(t0, t0 + 48 * 3600), ylim = c(0, 2), yaxs = "i")

# test xlim and ylim with yaxs="r"
p(yaxs = "r")
p(xlim = c(t0, t0 + 48 * 3600), yaxs = "r")
p(ylim = c(0, 2), yaxs = "r")
p(xlim = c(t0, t0 + 48 * 3600), ylim = c(0, 2), yaxs = "r")
