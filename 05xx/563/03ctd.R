require(oce)
start <- 20
end <- 30
p <- seq(0, 100, 1)
S <- 35 + p / 100
T <- 20 - p / 100
d <- as.ctd(S, T, p)
d <- subset(d, start <= pressure & pressure <= end)
stopifnot(all.equal.numeric(d[["pressure"]], 20:30))
