library(oce)
file <- "~/Dropbox/S101135A001_Ronald.ad2cp"
d <- read.oce(file) # , debug=5)
if (!interactive()) png("1676b_velocity.png")
plot(d, zlim=c(-1.5, 1.5))
summary(d)
if (!interactive()) dev.off()

if (!interactive()) png("1676b_backscatter.png")
par(mfrow=c(4,1), mar=c(3,3,2,1), mgp=c(2,0.7,0))
plot(d, which="a1")
plot(d, which="a2")
plot(d, which="a3")
plot(d, which="a4")
if (!interactive()) dev.off()

if (!interactive()) png("1676b_hist.png")
par(mfrow=c(3,1), mar=c(3,3,2,1), mgp=c(2,0.7,0))
v <- d[["v"]]
hist(v[,,1], xlab="u [m/s]", main="")
hist(v[,,2], xlab="v [m/s]", main="")
hist(v[,,3], xlab="z [m/s]", main="")
if (!interactive()) dev.off()

## A start to how testing could go
library(testthat)
options(digits=15)
v <- d[["v"]]
expect_equal(v[1,,1], c(-0.832, -0.048, 0.001, 0.003, 0.027, 0.148, 0.066,
                        -0.067, -0.056, -0.103, -0.07, -0.051, 0.071, 0.062,
                        0.1, 0.067, 0.023, 0.026, -0.119, -0.013, 0.004,
                        -0.094, -0.041, 0.151, 0.145, 0.465, 0.462, 0.456,
                        1.029, 0.342, 0.29, 0.3))
expect_equal(v[1,1,], c(-0.832, 0.901, -0.013, 0.961))
expect_equal(v[1,,2], c(0.901, -0.022, 0.014, -0.103, -0.114, -0.039, -0.005,
                        -0.065, -0.074, -0.125, -0.301, -0.271, -0.28, -0.046,
                        -0.092, -0.128, -0.229, -0.245, -0.175, -0.171, -0.129,
                        -0.031, -0.166, -0.011, -0.058, -0.451, -0.671, -0.747,
                        -0.812, -0.421, -0.336, -0.489))
expect_equal(sort(names(d[["data"]])), c("activeConfiguration", "average",
                                         "echosounder", "orientation",
                                         "powerLevel", "status"))
expect_equal(sort(names(d[["average"]])), c("a", "accelerometerx",
                                            "accelerometery", "accelerometerz",
                                            "blankingDistance", "cellSize",
                                            "ensemble", "heading",
                                            "nominalCorrelation",
                                            "numberOfBeams", "numberOfCells",
                                            "oceCoordinate", "orientation",
                                            "originalCoordinate", "pitch",
                                            "powerLevel", "pressure", "q",
                                            "roll", "soundSpeed",
                                            "temperature",
                                            "temperatureMagnetometer",
                                            "temperatureRTC", "time",
                                            "transmitEnergy", "v"))

## NONE of the following works.  They ALL should. I'll look into this
##? d[["type"]]
##? d[["fileType"]]
##? d[["serialNumber"]]
##? sink('a');dput(sort(names(d[["average"]])));sink()

