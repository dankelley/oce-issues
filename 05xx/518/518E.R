message("518E.R is now moot because oce does proj4 internally")
## ortho fails on points on 'other side of earth'.  (Really, it should give NA
## or something, I think.)  We are forced to use try(), on individual points,
## which is going to be slow.

library(proj4)
proj <- "+proj=ortho +lon_0=-100"
lon <- c(-90, 30)
lat <- c(35, 36)
n <- 2

matrix(unlist(lapply(1:n, function(i) {
                     t <- try({project(list(lon[i], lat[i]), proj=proj)})
                     if (inherits(t, "try-error")) c(NA, NA) else c(t$x, t$y)})), ncol=2, byrow=TRUE)

library(oce)
data(coastlineWorld)
longitude <- coastlineWorld[['longitude']]
latitude <- coastlineWorld[['latitude']]
matrix(unlist(lapply(1:n, function(i) {
                     t <- try({project(list(lon[i], lat[i]), proj=proj)})
                     if (inherits(t, "try-error")) c(NA, NA) else c(t$x, t$y)})), ncol=2, byrow=TRUE)
n <- length(longitude)
system.time(
            res <- matrix(unlist(lapply(1:n, function(i) {
                                        t <- try({project(list(longitude[i], latitude[i]), proj=proj)}, silent=TRUE)
                                        if (inherits(t, "try-error")) c(NA, NA) else c(t$x, t$y)})), ncol=2, byrow=TRUE)
            )
ll <- cbind(longitude, latitude)
system.time(
            res <- matrix(unlist(lapply(1:n, function(i) {
                                        t <- try({project(ll[i,], proj=proj)}, silent=TRUE)
                                        if (inherits(t, "try-error")) c(NA, NA) else t[1,]})), ncol=2, byrow=TRUE)
            )

if (!interactive()) png("518E.png", width=8.5, height=7, unit="in", res=150, pointsize=9, type="cairo", antialias="none")

plot(res[,1], res[,2], asp=1, type='l')
if (!interactive()) dev.off()
