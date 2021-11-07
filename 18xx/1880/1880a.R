build <- FALSE

library(oce)
data(wind)
# To test speed, we want lots of points
set.seed(2012)
i <- sample(seq_along(wind$x), 500, replace=TRUE)
wind <- list(x=wind$x[i], y=wind$y[i], z=wind$z[i])
d <- 0.02
xg <- seq(0, 11, d)
yg <- seq(0, 9, d)
#  User   Version
# 3.929   CRAN
cat("C style assignment\n")
t1 <- t.test(c(5.280, 5.284, 5.217, 5.577, 5.325, 5.316, 5.461, 5.402))
cat(sprintf("%.3f ± %0.3f s\n", t1$estimate, 0.5*diff(t1$conf.int)))
cat("C++ style assignment\n")
t2 <- t.test(c(3.988, 4.037, 3.980, 3.908, 3.980, 3.934, 4.106, 4.010))
cat(sprintf("%.3f ± %0.3f s\n", t2$estimate, 0.5*diff(t2$conf.int)))
cat(sprintf("speedup by swithcing to C++: %.1f%%\n",
        100 * (t1$estimate - t2$estimate) / (mean(t1$estimate, t2$estimate))))

print(system.time(u <- with(wind, interpBarnes(x, y, z, xg=xg, yg=yg))))
if (build) {
    ucran <- u
    save(ucran, file="1880a_cran.rda")
} else {
    load("1880a_cran.rda")
    stopifnot(identical(u$xg, ucran$xg))
    stopifnot(identical(u$yg, ucran$yg))
    stopifnot(identical(u$zg, ucran$zg))
    stopifnot(identical(u$wg, ucran$wg))
    stopifnot(identical(u$zd, ucran$zd))
}
