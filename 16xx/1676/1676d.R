## Potential test code, if this dataset becomes available
library(testthat)
library(oce)
file <- "test.ad2cp"

## Do we get the early-end indication? (Thre are also two warnings)
d <- expect_warning(expect_output(read.oce(file), "^.*wanted 16032 bytes but got only 6168.*$"))

## Identifiers
expect_equal(d[["type"]], "Signature100")
expect_equal(d[["fileType"]], "AD2CP")
expect_equal(d[["serialNumber"]], 101135)

## Entry names
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
## Beams and cells
expect_equal(d[["oceCoordinate"]], "enu")
expect_equal(d[["cellSize", "average"]], 10)
expect_equal(d[["cellSize", "echosounder"]], 0.75)
expect_equal(d[["blankingDistance", "average"]], 2)
expect_equal(d[["blankingDistance", "echosounder"]], 20) # FIXME: or is it 2???
expect_equal(d[["numberOfBeams", "average"]], 4)
expect_equal(d[["numberOfCells", "average"]], 32)
expect_equal(d[["numberOfBeams", "echosounder"]], 1)
expect_equal(d[["numberOfCells", "echosounder"]], 438)

## Velocities
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

## Time
expect_equal(d[["time"]],
             structure(c(1559664065.001, 1559664070.0011, 1559664075.001,
                         1559664080.0011, 1559664085.001, 1559664090.001,
                         1559664095.001),
                       class = c("POSIXct", "POSIXt"),
                       tzone = "UTC"))
expect_equal(d[["time", "average"]],
             structure(c(1559664065.001, 1559664070.0011, 1559664075.001,
                         1559664080.0011, 1559664085.001, 1559664090.001,
                         1559664095.001),
                       class = c("POSIXct", "POSIXt"),
                       tzone = "UTC"))
expect_equal(d[["time", "echosounder"]],
             structure(c(1559664081.001, 1559664101.001, 1559664121.001,
                         1559664141.001, 1559664161.001),
                       class = c("POSIXct", "POSIXt"),
                       tzone = "UTC"))

## Pressure, temperature etc
expect_equal(d[["pressure"]], c(6.999, 7, 7.077, 6.979, 7.043, 7.044, 7.039))
expect_equal(d[["pressure", "average"]], c(6.999, 7, 7.077, 6.979, 7.043, 7.044, 7.039))
expect_equal(d[["pressure", "echosounder"]], c(6.97, 7.02, 7.029, 7.041, 7.065))

expect_equal(d[["temperature"]], c(1.51, 1.48, 1.5, 1.48, 1.51, 1.49, 1.49))
expect_equal(d[["temperature", "average"]], c(1.51, 1.48, 1.5, 1.48, 1.51, 1.49, 1.49))
expect_equal(d[["temperature", "echosounder"]], c(1.51, 1.51, 1.49, 1.49, 1.48))

expect_equal(d[["heading"]], c(153.48, 153.36, 153.04, 152.66, 152.35, 151.77, 151.58))
expect_equal(d[["heading", "average"]], c(153.48, 153.36, 153.04, 152.66, 152.35, 151.77, 151.58))
expect_equal(d[["heading", "echosounder"]], c(152.92, 151.19, 149.78, 148.03, 146.45))

expect_equal(d[["pitch"]], c(-0.25, -0.25, -0.23, -0.24, -0.25, -0.2, -0.24))
expect_equal(d[["pitch", "average"]], c(-0.25, -0.25, -0.23, -0.24, -0.25, -0.2, -0.24))
expect_equal(d[["pitch", "echosounder"]], c(-0.21, -0.25, -0.27, -0.21, -0.25))

expect_equal(d[["roll"]], c(0, 0, 0.02, 0.02, -0.01, -0.02, 0.03))
expect_equal(d[["roll", "average"]], c(0, 0, 0.02, 0.02, -0.01, -0.02, 0.03))
expect_equal(d[["roll", "echosounder"]], c(0, 0.04, 0, 0, 0))

## How I got the numbers above
## sink('a');dput(d[["roll", "average"]]);sink()
## sink('b');dput(d[["roll", "echosounder"]]);sink()

