require(oce)
wrapper <- function(start, end) {
    make_ctd <- function(start, end) {
        p <- seq(0, 100, 1)
        S <- 35 + p / 100
        T <- 20 - p / 100
        d <- as.ctd(S, T, p)
        d <- subset(d, start <= pressure & pressure <= end)
    }
    make_ctd(start, end)
}
focus <- c(20, 30)
d <- wrapper(focus[1], focus[2])
str(d)

