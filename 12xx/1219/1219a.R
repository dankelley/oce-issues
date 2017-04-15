library(oce)
library(testthat)
## f <- "/Users/kelley/Dropbox/oce_ad2cp/labtestsig3.ad2cp"
f <- "labtestsig3.ad2cp"
N <- 50
d <- read.ad2cp(f, 1, N, 1)
## par(mar=c(3, 3, 1, 1), mgp=c(2, 0.7, 0))
## plot(d$id, ylim=c(20.5,22.5), type='p', cex=2/3, ylab="chunk type", lwd=2)
## grid()

## I know that the second one is a data/burst chunk. I think it is
## version "3", at least in the beginning ones. Certainly, the time
## fields seem (mostly) to be ok (except that they are slightly
## out of order).
time <- vector("numeric", N)
id <- vector("numeric", N)
version <- vector("numeric", N)
soundSpeed <- vector("numeric", N)
temperature <- vector("numeric", N)
pressure <- vector("numeric", N)
heading <- vector("numeric", N)
pitch <- vector("numeric", N)
roll <- vector("numeric", N)
coordinateSystem <- vector("character", N)
ncells <- vector("numeric", N)
nbeams <- vector("numeric", N)
cellSize <- vector("numeric", N)
blanking <- vector("numeric", N)
nominalCorrelation <- vector("numeric", N)
accelerometerx <- vector("numeric", N)
accelerometery <- vector("numeric", N)
accelerometerz <- vector("numeric", N)
transmitEnergy <- vector("numeric", N)
velocityScaling <- vector("numeric", N)
powerLevel <- vector("numeric", N)
temperatureMagnetometer <- vector("numeric", N)
temperatureRTC <- vector("numeric", N)
ensemble <- vector("numeric", N)
v <- vector("numeric", N)

options(digits.secs=6)
for (ch in 1:N) {
    id[ch] <- d$id[ch]
    if (d$id[ch] %in% c(21, 22)) {
        version[ch] <- as.integer(d$buf[d$index[ch]+1])
        if (version[ch] == 3) {
            offsetOfData <- as.integer(d$buf[d$index[ch]+2])
            if (ch==2) message("offsetOfData=", offsetOfData)
            i <- d$index[ch]
            serialNumber <- readBin(d$buf[i+5:8], "integer", size=4, endian="little")
            year<-as.integer(d$buf[i+9])
            month <- 1 + as.integer(d$buf[i+10]) # starts at 0, based on matlab results
            day<-as.integer(d$buf[i+11])
            hour<-as.integer(d$buf[i+12])
            min<-as.integer(d$buf[i+13])
            sec<-as.integer(d$buf[i+14])
            usec100 <- readBin(d$buf[d$index[ch]+15:16], "integer", size=2, signed=FALSE, endian="little")
            t <- ISOdatetime(1900+year,month,day,hour,min,sec+usec100/1e4,tz="UTC")
            time[ch] <- t
            soundSpeed[ch] <- 0.1 * readBin(d$buf[i+17:18], "integer", size=2, endian="little")
            temperature[ch] <- 0.01 * readBin(d$buf[i+19:20], "integer", size=2, endian="little")
            pressure[ch] <- 0.001 * readBin(d$buf[i+21:24], "integer", size=4, endian="little")
            heading[ch] <- 0.01 * readBin(d$buf[i+25:26], "integer", size=2, endian="little")
            pitch[ch] <- 0.01 * readBin(d$buf[i+27:28], "integer", size=2, endian="little")
            roll[ch] <- 0.01 * readBin(d$buf[i+29:30], "integer", size=2, endian="little")
            ## FIXME: this is pretty ugly code, but doing bit-level in R is awkward.
            ## cat("beam+coord+cells ... NOT DECODED YET\n")
            ## cat("0x", d$buf[i+31], " -> ", byteToBinary(d$buf[i+31]), " (b31)\n", sep="")
            ## cat("0x", d$buf[i+32], " -> ", byteToBinary(d$buf[i+32]), " (b32)\n", sep="")
            bcc <- strsplit(paste(byteToBinary(c(d$buf[i+31], d$buf[i+32])), collapse=""), "")[[1]]
            cs <- paste(bcc[12:11], collapse="")
            coordinateSystem[ch] <- switch(cs,"00"="enu", "01"="xyz", "10"="beam","11"="?")
            ncells[ch] <- sum(unlist(lapply(1:10,function(i) as.numeric(bcc[1:10][i])*2^(i-1))))
            nbeams[ch] <- sum(unlist(lapply(1:4,function(i) as.numeric(bcc[12:15][i])*2^(i-1))))
            ##message("coordinateSystem=", coordinateSystem, ", ncells=", ncells, ", nbeams=", nbeams, "\n")
            cellSize[ch] <- 0.001 * readBin(d$buf[i+33:34], "integer", size=2, signed=FALSE, endian="little")
            blanking[ch] <- 0.001 * readBin(d$buf[i+35:36], "integer", size=2, signed=FALSE, endian="little")
            nominalCorrelation[ch] <- as.integer(d$buf[i+37])
            ## skipping some variables
            accelerometerz[ch] <- 1/16384 * readBin(d$buf[i+51:52], "integer", size=2, signed=TRUE, endian="little")
            ## skipping some variables
            transmitEnergy[ch] <- readBin(d$buf[i+57:58], "integer", size=2, signed=FALSE, endian="little")
            velocityScaling[ch] <- readBin(d$buf[i+59], "integer", size=1, signed=TRUE, endian="little")
            velocityFactor <- 10^velocityScaling[ch]
            powerLevel[ch] <- readBin(d$buf[i+60], "integer", size=1, signed=TRUE, endian="little")
            temperatureMagnetometer[ch] <- 0.001 * readBin(d$buf[i+61:62], "integer", size=2, signed=TRUE, endian="little")
            temperatureRTC[ch] <- 0.01 * readBin(d$buf[i+63:64], "integer", size=2, endian="little")
            ensemble[ch] <- readBin(d$buf[i+73:76], "integer", size=4, endian="little")
            ## 77=1+offsetOfData
            v[ch] <- velocityFactor * readBin(d$buf[i+77:78], "integer", size=2, endian="little")
            ##ensemble[ch] <- readBin(d$buf[i+73:74], "integer", size=2, signed=FALSE, endian="little") +
            ##65536 * readBin(d$buf[i+75:76], "integer", size=2, signed=FALSE, endian="little")
            ##cat("chunk ", ch, " decoded\n")
        } else {
            cat("chunk ", ch, " is id=", d$id[ch], " version=", version, "\n", sep="")
        }
    } else {
        cat("chunk ", ch, " is id=", d$id[ch], "\n", sep="")
    }
}
options(width=120) # to get wide printing
time <- as.POSIXct(time, origin="1970-01-01 00:00:00", tz="UTC")
res <- data.frame(time, id, version,
                  soundSpeed, temperature, pressure,
                  heading, pitch, roll,
                  coordinateSystem, nbeams, ncells, cellSize, blanking, 
                  nominalCorrelation,
                  accelerometerz,
                  transmitEnergy,
                  velocityScaling,
                  powerLevel,
                  temperatureMagnetometer,
                  temperatureRTC,
                  ensemble,
                  v)
print(head(res, 10))

context("pressure (burst)")
expect_equal(serialNumber, 100159)
## >> load labtestsig3.ad2cp.00000_1.mat
## >> fieldnames(Data)
## >> Data.BurstHR_Pressure(1:10)
pressureMatlab <- c(10.260, 10.258, 10.264, 10.261, 10.263,
                    10.260, 10.260, 10.261, 10.259, 10.259)
expect_equal(head(subset(res, id==21), 10)$pressure, pressureMatlab)
## >> Data.BurstHR_WaterTemperature(1:10)
temperatureMatlab <- c(24.010, 24.000, 24.010, 24.010, 24.010,
                       24.010, 24.010, 24.010, 24.010, 24.000)
expect_equal(head(subset(res, id==21), 10)$temperature, temperatureMatlab)
## >> Data.BurstHR_Heading(1:10)
headingMatlab <- c(10.890, 10.910, 10.920, 10.980, 10.960,
                   10.910, 10.900, 10.900, 10.900, 10.900)
expect_equal(head(subset(res, id==21), 10)$heading, headingMatlab)
## >> Data.BurstHR_Pitch(1:10)
pitchMatlab <- c(-71.280, -71.280, -71.270, -71.280, -71.280,
                 -71.280, -71.270, -71.270, -71.270, -71.270)
expect_equal(head(subset(res, id==21), 10)$pitch, pitchMatlab)
## >> Data.BurstHR_ROll(1:10)
rollMatlab <- c(-78.050, -78.080, -78.080, -78.090, -78.090,
                -78.080, -78.080, -78.080, -78.080, -78.080)
expect_equal(head(subset(res, id==21), 10)$roll, rollMatlab)

cellSizeMatlab <- rep(0.02, 10)
expect_equal(head(subset(res, id==21), 10)$cellSize, cellSizeMatlab)

message("I think the blanking is in cm, not mm ... or the matlab is wrong")
## NOTE dividing by 10 to check against matlab
blankingMatlab <- rep(2.8000, 10) / 10
expect_equal(head(subset(res, id==21), 10)$blanking, blankingMatlab)

## >> Data.Alt_BurstHR_NominalCor(1:10)
nominalCorrelationMatlab <- c(100, 100, 100, 100, 100,
                              100, 100, 100, 100, 100)
expect_equal(head(subset(res, id==21), 10)$nominalCorrelation, nominalCorrelationMatlab)
##>> Data.Alt_Average_NominalCor(1:6)
avgNominalCorrelationMatlab <- c(33, 33, 33, 33, 33, 33)
expect_equal(head(subset(res, id==22), 6)$nominalCorrelation, avgNominalCorrelationMatlab)

##>> Data.BurstHR_AccelerometerZ(1:10)
accelerometerzMatlab <- c(0.066895, 0.065918, 0.065430, 0.066406, 0.065918,
                          0.068359, 0.070801, 0.068359, 0.069336, 0.069336)
## relax tolerance since it's a 16-bit value
expect_equal(head(subset(res, id==21), 10)$accelerometerz, accelerometerzMatlab, tolerance=1e-6)

powerLevelMatlab <- rep(0, 10)
expect_equal(head(subset(res, id==21), 10)$powerLevel, powerLevelMatlab)

## >> Data.BurstHR_TransmitEnergy(1:10)
transmitEnergyMatlab <- c(4, 0, 4, 4, 4,
                          4, 4, 4, 4, 0)
expect_equal(head(subset(res, id==21), 10)$transmitEnergy, transmitEnergyMatlab)

## > Data.BurstHR_RTCTemperature(1:10)
temperatureRTCMatlab <- c(28.500, 28.500, 28.500, 28.500, 28.500,
                          28.500, 28.500, 28.500, 28.500, 28.500)
expect_equal(head(subset(res, id==21), 10)$temperatureRTC, temperatureRTCMatlab)


##> Data.BurstHR_EnsembleCount(1:10)
ensembleMatlab <- c(969, 970, 971, 972, 973,
                    974, 975, 976, 977, 978)
expect_equal(head(subset(res, id==21), 10)$ensemble, ensembleMatlab)

## >> output_precision(25)
## >> Data.BurstHR_TimeStamp(1:10)
ts <- c(1.490564521001000165939331e+09, 1.490564521125800132751465e+09, 1.490564521251000165939331e+09,
        1.490564521376000165939331e+09, 1.490564521501000165939331e+09, 1.490564521626000165939331e+09,
        1.490564521751000165939331e+09, 1.490564521876000165939331e+09, 1.490564522001000165939331e+09,
        1.490564522125800132751465e+09)
timeMatlab <- numberAsPOSIXct(ts)
expect_equal(head(subset(res, id==21), 10)$time, timeMatlab)

## >> Data.BurstHR_MagnetometerTemperature(1:10)
temperatureMagnetometerMatlab <- c(2.579800034e+01, 2.584499931e+01, 2.593899918e+01, 2.589200020e+01,
                                   2.584499931e+01, 2.575099945e+01, 2.579800034e+01, 2.589200020e+01,
                                   2.584499931e+01, 2.579800034e+01)
expect_equal(head(subset(res, id==21), 10)$temperatureMagnetometer, temperatureMagnetometerMatlab, tolerance=1e-5)

## Evidently the bursts were just beam 5.
## >> size(Data.BurstHR_VelBeam5)
## ans = 23112     256
##>> Data.BurstHR_VelBeam5(1:3)
vMatlab <- c(3.623999953e-01, 3.375000060e-01, 3.422999978e-01, 3.871000111e-01, 3.436999917e-01,
              3.104000092e-01, 3.336000144e-01, 3.194999993e-01, -4.390000179e-02, 3.334000111e-01)
expect_equal(head(subset(res, id==21), 1)$v, vMatlab[1], tolerance=1e-5)
