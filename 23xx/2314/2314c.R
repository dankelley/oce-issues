library(oce)
f <- "~/Downloads/S104098A002_2297d.ad2cp"
if (file.exists(f)) {
    # event <- as.POSIXct("2025-03-13 18:00:00", tz = "UTC")
    # focus <- as.POSIXct(c("2025-03-13 17:00", "2025-03-13 19:00"), tz = "UTC")
    # focus2 <- as.POSIXct(c("2025-03-13 17:50", "2025-03-13 18:10"), tz = "UTC")
    startIndex <- 3300000
    d <- read.adp.ad2cp(f, dataType = "average", from = startIndex, to = startIndex + 1e5)
    zlim <- c(-1, 1) * quantile(abs(d[["v"]]), 0.95)
    if (!interactive()) png("2314c.png", width = 7, height = 7, unit = "in", res = 300)
    plot(d, zlim = zlim)
    if (!interactive()) dev.off()
    summary(d)
}
