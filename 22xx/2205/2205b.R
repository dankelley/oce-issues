library(oce)
data(sealevel)
t0 <- sealevel[["time"]][1]
sl <- subset(sealevel, time < t0 + 86400)
p <- function(title = "", ...) {
    plot(sl, which = 1, drawTimeRange = FALSE, ...)
    mtext(title, adj = 0, col = 4, font = 2)
}


# test xaxs and yaxs
par(mfrow = c(2, 2))
p(title = "(a)")
p(xaxs = "i", title = "(b)")
p(yaxs = "i", title = "(c)")
p(xaxs = "i", yaxs = "i", title = "(d)")

# test xlim and ylim
par(mfrow = c(2, 2))
p(title = "(a)")
p(xlim = c(t0, t0 + 48 * 3600), title = "(b)")
p(ylim = c(0, 2), title = "(c)")
p(xlim = c(t0, t0 + 48 * 3600), ylim = c(0, 2), title = "(d)")

# test xlim and ylim with xaxs="i"
par(mfrow = c(2, 2))
p(xaxs = "i", title = "(a)")
p(xlim = c(t0, t0 + 48 * 3600), xaxs = "i", title = "(b)")
p(ylim = c(0, 2), xaxs = "i", title = "(c)")
p(xlim = c(t0, t0 + 48 * 3600), ylim = c(0, 2), xaxs = "i", title = "(d)")

# test xlim and ylim with xaxs="r"
par(mfrow = c(2, 2))
p(xaxs = "r", title = "(a)")
p(xlim = c(t0, t0 + 48 * 3600), xaxs = "r", title = "(b)")
p(ylim = c(0, 2), xaxs = "r", title = "(c)")
p(xlim = c(t0, t0 + 48 * 3600), ylim = c(0, 2), xaxs = "r", title = "(d)")

# test xlim and ylim with yaxs="i"
par(mfrow = c(2, 2))
p(yaxs = "i", title = "(a)")
p(xlim = c(t0, t0 + 48 * 3600), yaxs = "i", title = "(b)")
p(ylim = c(0, 2), yaxs = "i", title = "(c)")
p(xlim = c(t0, t0 + 48 * 3600), ylim = c(0, 2), yaxs = "i", title = "(d)")

# test xlim and ylim with yaxs="r"
par(mfrow = c(2, 2))
p(yaxs = "r", title = "(a)")
p(xlim = c(t0, t0 + 48 * 3600), yaxs = "r", title = "(b)")
p(ylim = c(0, 2), yaxs = "r", title = "(c)")
p(xlim = c(t0, t0 + 48 * 3600), ylim = c(0, 2), yaxs = "r", title = "d()")
