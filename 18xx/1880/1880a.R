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
cat("Test 1: C++ index-style assignment (FIXME: using CRAN, so a poor test)\n")
t1 <- t.test(c(5.280, 5.284, 5.217, 5.577, 5.325, 5.316, 5.461, 5.402))
cat(sprintf("%.3f ± %0.3f s\n", t1$estimate, 0.5*diff(t1$conf.int)))

cat("Test t2: as t1 but C++ whole-style assignment\n")
t2 <- t.test(c(3.988, 4.037, 3.980, 3.908, 3.980, 3.934, 4.106, 4.010))
cat(sprintf("%.3f ± %0.3f s\n", t2$estimate, 0.5*diff(t2$conf.int)))
cat(sprintf("speedup by switching to whole-style assigment: %.1f%%\n",
        100 * (t1$estimate - t2$estimate) / (mean(t1$estimate, t2$estimate))))

cat("Test 3: C (pointer) style assignment into zz (10 trials)\n")
t3 <- t.test(c(5.539,5.645,5.494,5.512,5.588,5.590,5.531,5.517,5.556,5.524))
cat(sprintf("%.3f ± %0.3f s\n", t3$estimate, 0.5*diff(t3$conf.int)))

cat("Test 4: as test 3, but with RCpp assignment into zz (10 trials)\n")
t4 <- t.test(c(5.520,5.511,5.601,5.523,5.567,5.581,5.667,5.539,5.552,5.530))
cat(sprintf("%.3f ± %0.3f s\n", t4$estimate, 0.5*diff(t4$conf.int)))

cat("Test 5: as test 4, but with RCpp index-based assignment into z_g(i,j) and z_last (10 trials)\n")
t5 <- t.test(c(5.503,5.644,5.506,5.486,5.501,5.553,5.517,5.529,5.582,5.557))
cat(sprintf("%.3f ± %0.3f s\n", t5$estimate, 0.5*diff(t5$conf.int)))

cat("Test 6: can we speed up exp()? (compare with test 5)\n")
t6 <- t.test(c(2.449,2.447,2.448,2.442,2.447,2.451,2.458,2.447,2.484,2.453))
cat(sprintf("%.3f ± %0.3f s\n", t6$estimate, 0.5*diff(t6$conf.int)))



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
