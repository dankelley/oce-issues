require(oce)
make_ctd <- function(start, end) {
    start <- 20
    end <- 30
    p <- seq(0, 100, 1)
    S <- 35 + p / 100
    T <- 20 - p / 100
    d <- as.ctd(S, T, p)
    d <- subset(d, start <= pressure & pressure <= end)
}
focus <- c(20, 30)
d <- make_ctd(focus[1], focus[2])
stopifnot(all.equal.numeric(d[["pressure"]], 20:30))
