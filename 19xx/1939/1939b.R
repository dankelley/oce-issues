# This test takes a minute to run, and produces a PNG that summarizes the
# results.

# This creates 5 plots -- you may ignore them.
quartz()
ns <-  c(1e3, 3e3, 1e4, 3e4, 1e5)
t1s <- rep(NA, length(ns))
t2s <- rep(NA, length(ns))
for (i in seq_along(ns)) {
   x <- rnorm(ns[i])
   y <- sin(seq_along(x/100)) + x
   t1s[i] <- system.time({
       plot(x,y, type="n")
       axis(side=3)
       mtext("empty plot first")
       points(x, y,col=2)
   })[1]
   t2s[i] <- system.time({
       plot(x,y)
       axis(side=3)
       mtext("full plot first")
   })[1]
}
dev.off()

# This creates a single plot -- please post it at
# https://github.com/dankelley/oce/issues/1939
# along with a brief description of your machine.
png("1939b.png")
par(mar=c(3,3,1,1), mgp=c(2,0.7,0), mfrow=c(2,1))
plot(ns, t1s,
    xlim=range(ns),
    ylim=range(c(t1s, t2s)),
    pch=1, log="xy",
    xlab="# points",
    ylab="Time [s]",
    type="b")
grid()
mtext("Log scale")
points(ns, t2s, pch=2, type="b", col=2)
legend("topleft", pch=1:2, col=1:2, bg="white",
    legend=c("empty plot at start",
        "full plot at start"))
# scalebar
N <- length(ns)
x <- ns[N]
y <- t1s[N-1]
lines(rep(x,2), y*c(1, 3), col=4, lwd=3)
text(ns[N], y*sqrt(3), "3X", pos=2, col=4, font=2)

plot(ns, t2s/t1s, type="o", ylim=c(1, 4),
    log="xy",
    xlab="# points",
    ylab="Speedup Factor")
abline(h=3, col=4, lwd=3)
mtext("3x", side=4, at=3, font=2, col=4)

dev.off()
