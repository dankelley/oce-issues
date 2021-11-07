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
# 5.511   CRAN
# 5.494   CRAN
# 5.503   CRAN
# 7.558   develop
# 7.460   develop
# 7.353   develop

print(system.time(u <- with(wind, interpBarnes(x, y, z, xg=xg, yg=yg))))
save(ucran, file="1880a_cran.rda")
stop()
load("1880a_cran.rda")
stopifnot(identical(u$xg, ucran$xg))
stopifnot(identical(u$yg, ucran$yg))
stopifnot(identical(u$zg, ucran$zg))
stopifnot(identical(u$wg, ucran$wg))
stopifnot(identical(u$zd, ucran$zd))

