library(oce)
f <- "~/Downloads/Suisun_test.ad2cp"
if (file.exists(f)) {
    TOC <- read.adp.ad2cp(f, TOC = TRUE)
    print(TOC)

    echosounderRaw <- read.adp.ad2cp(f, dataType = "echosounderRaw", plan = 0, debug = 2)

    burst <- read.adp.ad2cp(f, dataType = "burst", plan = 0)
    interleavedBurst <- read.adp.ad2cp(f, dataType = "interleavedBurst", plan = 0)
    # ERRORS echosounderRaw <- read.adp.ad2cp(f, dataType = "echosounderRaw", plan = 0)
    # Note appending '1' at the end of variable names to indicate plan=1.
    burst1 <- read.adp.ad2cp(f, dataType = "burst", plan = 1)
    burstAltimeterRaw1 <- read.adp.ad2cp(f, dataType = "burstAltimeterRaw", plan = 1)
    echosounder1 <- read.adp.ad2cp(f, dataType = "echosounder", plan = 1)
}
