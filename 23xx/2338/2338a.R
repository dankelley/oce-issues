library(oce)
f <- "~/data/argo/D4902911_095.nc"
if (file.exists(f)) {
    d <- read.argo(f) |> as.ctd()
    p <- d[["pressure"]]
    spiciness0 <- d[["spiciness0"]]
    cabbeling <- d[["cabbeling"]]
    look <- 0 <= p & p <= 200
    if (!interactive()) {
        png("2338a_%02d.png", units = "in", width = 7, height = 5, pointsize = 9, res = 300)
    }
    plot(as.ctd(d))

    par(mfrow = c(1, 3), mar = c(3.3, 3.3, 1, 1), mgp = c(2, 0.7, 0))
    p <- d[["pressure"]]
    ylim <- rev(range(p))
    plot(spiciness0, p,
        ylim = ylim, type = "l",
        ylab = resizableLabel("p"),
        xlab = resizableLabel("spiciness0"),
        yaxs = "i"
    )
    grid()
    lines(spiciness0[look], p[look], col = 2)

    plot(cabbeling, p,
        ylim = ylim, type = "l",
        ylab = resizableLabel("p"),
        xlab = expression("Cabbeling Index [" * kg^-2 * "]"),
        yaxs = "i"
    )
    grid()
    lines(cabbeling[look], p[look], col = 2)

    plot(spiciness0, cabbeling, type = "l")
    grid()
    lines(spiciness0[look], cabbeling[look], col = 2)
}
