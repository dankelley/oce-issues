library(oce)
library(testthat)
## f <- "/Users/kelley/Dropbox/oce_ad2cp/labtestsig3.ad2cp"

f <- "labtestsig3.ad2cp"
N <- 50
res <- new("adp")
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
BCC <- vector("character", N)
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
v <- vector("list", N)
amplitude <- vector("list", N)
correlation <- vector("list", N)

options(digits.secs=6)
for (ch in 1:N) {
    id[ch] <- d$id[ch]
    if (d$id[ch] == 160) {
        ## skip an extra byte at start because it is a code
        chars <- rawToChar(d$buf[seq.int(2+d$index[ch], by=1, length.out=-1+d$length[ch])])
        header <- strsplit(chars, "\r\n")[[1]]
    } else if (d$id[ch] %in% c(21, 22)) {
        version[ch] <- as.integer(d$buf[d$index[ch]+1])
        if (version[ch] == 3) {
            offsetOfData <- as.integer(d$buf[d$index[ch]+2])
            if (ch==2) message("offsetOfData=", offsetOfData)
            i <- d$index[ch]
            serialNumber <- readBin(d$buf[i+5:8], "integer", size=4, endian="little")
            year<-as.integer(d$buf[i+9])
            month <- 1 + as.integer(d$buf[i+10]) # starts at 0, based on matlab valueults
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
            ## Notes on decoding the nbeam/coord/ncell structure.
            ## According to p47 of the ad2cp doc:
            ##  bits  9 to  0: ncells
            ##  bits 11 to 10: coord system (00=enu, 01=xyz, 10=beam, 11=NA)
            ##  bits 15 to 12: nbeams
            ##
            ## Try using intToBits() etc ... these functions return with least-signficant
            ## bit first, e.g. 2 decimal corvalueponds to 0,1 and not 1,0 as one would write
            ## on paper. This has to be borne in mind whilst reading the Nortek documents,
            ## which list e.g. bit 9 to bit 0 (which in R, with intToBits() etc,
            ## corvalueponds to bit 1 to bit 10).
            ##
            ## ch==2 (burst) expect nbeam=1, ncell=256, "beam"(?)
            ## > substr(paste(ifelse(intToBits(256)==0x01, "1", "0"), collapse=""), 1, 10)
            ## [1] "0000000010"
            ## > substr(paste(ifelse(intToBits(1)==0x01, "1", "0"), collapse=""), 1, 4)
            ## [1] "1000"
            ## > paste(ifelse(rawToBits(d$buf[i+31:32])==0x01, "1", "0"), collapse="")
            ## [1] "0000000010011000"
            ## bit  0 to  9: 0000000010 OK
            ## bit 10 to 11: 01 OK
            ## bit 12 to 15: 1000 OK
            ##
            ## ch==3 (avg) expect nbeam=4, ncell=150, "beam"(?)
            ## ncell=150 so expect bit pattern
            ## > substr(paste(ifelse(intToBits(150)==0x01, "1", "0"), collapse=""), 1, 10)
            ## [1] "0110100100"
            ## > substr(paste(ifelse(intToBits(4)==0x01, "1", "0"), collapse=""), 1, 4)
            ## [1] "0010"
            ## > paste(ifelse(rawToBits(d$buf[i+31:32])==0x01, "1", "0"), collapse="")
            ## [1] "0110100100010010"
            ## bit  0 to  9: 0110100100 OK
            ## bit 10 to 11: 01 OK
            ## bit 12 to 15: 0010 OK

            bits <- rawToBits(d$buf[i+31:32])==0x01
            ncells[ch] <- sum(unlist(lapply(1:10, function(i) bits[0+i]*2^(i-1))))
            nbeams[ch] <- sum(unlist(lapply(1:4, function(i) bits[12+i]*2^(i-1))))
            BCC[ch] <- paste(ifelse(bits, "1", "0"), collapse="")
            coordinateSystem[ch] <- c("enu", "xyz", "beam", "?")[1+bits[11]+2*bits[12]]
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
            nn <- nbeams[ch] * ncells[ch]
            nbytes <- 2 * nn
            velocity <- velocityFactor * readBin(d$buf[i+77+seq(0, nbytes-1)],
                                                 "integer", size=2, n=nbeams[ch]*ncells[ch],
                                                 endian="little")
            v[[ch]] <- matrix(velocity, ncol=nbeams[ch], nrow=ncells[ch], byrow=FALSE)
            amp <- d$buf[i+77+nbytes+seq(0, nn-1)]
            amplitude[[ch]] <- matrix(amp, ncol=nbeams[ch], nrow=ncells[ch], byrow=FALSE)
            cor <- d$buf[i+77+nbytes+nn+seq(0, nn-1)]
            correlation[[ch]] <- matrix(cor, ncol=nbeams[ch], nrow=ncells[ch], byrow=FALSE)
            ## FIXME: read correlation etc
            ##cat("chunk ", ch, " decoded\n")
        } else {
            cat("chunk ", ch, " is id=", d$id[ch], " version=", version, "\n", sep="")
        }
    } else {
        cat("chunk ", ch, " is id=", d$id[ch], "\n", sep="")
    }
}
options(width=200) # to get wide printing
time <- as.POSIXct(time, origin="1970-01-01 00:00:00", tz="UTC")
value <- list(header=header,
            time=time, id=id, vsn=version,
            soundSpeed=soundSpeed, temperature=temperature, pressure=pressure,
            heading=heading, pitch=pitch, roll=roll,
            BCC=BCC, coord=coordinateSystem, nbeams=nbeams, ncells=ncells,
            cellSize=cellSize, blanking=blanking, 
            nomcor=nominalCorrelation,
            accz=accelerometerz,
            transmitEnergy=transmitEnergy,
            velocityScaling=velocityScaling,
            powerLevel=powerLevel,
            temperatureMagnetometer=temperatureMagnetometer,
            temperatureRTC=temperatureRTC,
            ensemble=ensemble,
            v=v, amplitude=amplitude, correlation=correlation)

expect_equal(serialNumber, 100159)
## >> load labtestsig3.ad2cp.00000_1.mat
## >> fieldnames(Data)
## >> Data.BurstHR_Pvaluesure(1:10)
pressureMatlab <- c(10.260, 10.258, 10.264, 10.261, 10.263,
                    10.260, 10.260, 10.261, 10.259, 10.259)
expect_equal(value$pressure[value$id==21][1:10], pressureMatlab)
## >> Data.BurstHR_WaterTemperature(1:10)
temperatureMatlab <- c(24.010, 24.000, 24.010, 24.010, 24.010,
                       24.010, 24.010, 24.010, 24.010, 24.000)
expect_equal(value$temperature[value$id==21][1:10], temperatureMatlab)
## >> Data.BurstHR_Heading(1:10)
headingMatlab <- c(10.890, 10.910, 10.920, 10.980, 10.960,
                   10.910, 10.900, 10.900, 10.900, 10.900)
expect_equal(value$heading[value$id==21][1:10], headingMatlab)
## >> Data.BurstHR_Pitch(1:10)
pitchMatlab <- c(-71.280, -71.280, -71.270, -71.280, -71.280,
                 -71.280, -71.270, -71.270, -71.270, -71.270)
expect_equal(value$pitch[value$id==21][1:10], pitchMatlab)
## >> Data.BurstHR_ROll(1:10)
rollMatlab <- c(-78.050, -78.080, -78.080, -78.090, -78.090,
                -78.080, -78.080, -78.080, -78.080, -78.080)
expect_equal(value$roll[value$id==21][1:10], rollMatlab)

cellSizeMatlab <- rep(0.02, 10)
expect_equal(value$cellSize[value$id==21][1:10], cellSizeMatlab)

## NOTE dividing by 10 to check against matlab
blankingMatlab <- rep(2.8000, 10) / 10
expect_equal(value$blanking[value$id==21][1:10], blankingMatlab)

## >> Data.Alt_BurstHR_NominalCor(1:10)
nominalCorrelationMatlab <- c(100, 100, 100, 100, 100,
                              100, 100, 100, 100, 100)
expect_equal(value$nomcor[value$id==21][1:10], nominalCorrelationMatlab)
##>> Data.Alt_Average_NominalCor(1:6)
avgNominalCorrelationMatlab <- c(33, 33, 33, 33, 33, 33)
expect_equal(value$nomcor[value$id==22][1:6], avgNominalCorrelationMatlab)

##>> Data.BurstHR_AccelerometerZ(1:10)
acczMatlab <- c(0.066895, 0.065918, 0.065430, 0.066406, 0.065918,
                0.068359, 0.070801, 0.068359, 0.069336, 0.069336)
## relax tolerance since it's a 16-bit value
expect_equal(value$accz[value$id==21][1:10], acczMatlab, tolerance=1e-6)

powerLevelMatlab <- rep(0, 10)
expect_equal(value$powerLevel[value$id==21][1:10], powerLevelMatlab)

## >> Data.BurstHR_TransmitEnergy(1:10)
transmitEnergyMatlab <- c(4, 0, 4, 4, 4,
                          4, 4, 4, 4, 0)
expect_equal(value$transmitEnergy[value$id==21][1:10], transmitEnergyMatlab)

## > Data.BurstHR_RTCTemperature(1:10)
temperatureRTCMatlab <- c(28.500, 28.500, 28.500, 28.500, 28.500,
                          28.500, 28.500, 28.500, 28.500, 28.500)
expect_equal(value$temperatureRTC[value$id==21][1:10], temperatureRTCMatlab)

##> Data.BurstHR_EnsembleCount(1:10)
ensembleMatlab <- c(969, 970, 971, 972, 973,
                    974, 975, 976, 977, 978)
expect_equal(value$ensemble[value$id==21][1:10], ensembleMatlab)

## >> output_precision(25)
## >> Data.BurstHR_TimeStamp(1:10)
ts <- c(1.490564521001000165939331e+09, 1.490564521125800132751465e+09, 1.490564521251000165939331e+09,
        1.490564521376000165939331e+09, 1.490564521501000165939331e+09, 1.490564521626000165939331e+09,
        1.490564521751000165939331e+09, 1.490564521876000165939331e+09, 1.490564522001000165939331e+09,
        1.490564522125800132751465e+09)
timeMatlab <- numberAsPOSIXct(ts)
expect_equal(value$time[value$id==21][1:10], timeMatlab)

## >> Data.BurstHR_MagnetometerTemperature(1:10)
temperatureMagnetometerMatlab <- c(2.579800034e+01, 2.584499931e+01, 2.593899918e+01, 2.589200020e+01,
                                   2.584499931e+01, 2.575099945e+01, 2.579800034e+01, 2.589200020e+01,
                                   2.584499931e+01, 2.579800034e+01)
expect_equal(value$temperatureMagnetometer[value$id==21][1:10], temperatureMagnetometerMatlab, tolerance=1e-5)

context("nbeams and ncells")
expect_equal(value$nbeams[value$id==21][1], 1)
expect_equal(value$ncells[value$id==21][1], 256)
expect_equal(value$nbeams[value$id==22][1], 4)
expect_equal(value$ncells[value$id==22][1], 150)

## Ensemble 2 is "burst" mode (beam5)
## >> Data.BurstHR_VelBeam5(1,1:10)
v <- c(0.36240, 0.35830, 0.36430, 0.20590, 0.35690, 0.35650, 0.35730, 0.36090, 0.36390, 0.36600)
expect_equal(value$v[[2]][1:10], v, tolerance=1e-5)

## Ensemble 3 is in "average" mode.
## >> Data.Average_VelBeam1(1,1:10)
v <- c(-0.81700,-0.88900,-1.91700,-2.11100,-1.00000,-2.08900,-1.54000,-0.85800,-1.93400,-1.56100)
expect_equal(value$v[[3]][1:10,1], v)

## >> Data.Average_VelBeam2(1,1:10)
v <- c(-0.16300,1.69300,1.84900,1.11200,1.57300,-1.50400,1.60000,-2.52800,1.72100,1.68400)
expect_equal(value$v[[3]][1:10,2], v)
 
## >> Data.Average_VelBeam3(1,1:10)
v <- c(-1.56000,1.41400,1.56300,1.55100,-0.32300,-1.27200,-2.11300,-1.28600,-2.36900,-2.38800)
expect_equal(value$v[[3]][1:10,3], v)
 
## >> Data.Average_VelBeam4(1,1:10)
v <- c(-0.079000,1.522000,1.587000,1.702000,1.674000,1.230000,2.855000,2.999000,2.913000,1.486000)
expect_equal(value$v[[3]][1:10,4], v)

if (FALSE) { # plot some image
    par(mfrow=c(3,3))
    for (i in 1:9)
        imagep(value$v[[i+1]])
    par(mfrow=c(1,1))
}

## Ensemble 2 is burst mode.
## The bursts are just beam 5.
## >> Data.BurstHR_VelBeam5(1,1:10)
v <- c(0.36240, 0.35830, 0.36430, 0.20590, 0.35690, 0.35650, 0.35730, 0.36090, 0.36390, 0.36600)
expect_equal(value$v[[2]][1:10], v, tolerance=1e-5)

## Ensemble 3 is average mode.
## >> Data.Average_VelBeam1(1,1:10)
v <- c(-0.81700,-0.88900,-1.91700,-2.11100,-1.00000,-2.08900,-1.54000,-0.85800,-1.93400,-1.56100)
expect_equal(value$v[[3]][1:10,1], v, tolerance=1e-5)

## >> Data.Average_VelBeam2(1,1:10)
v <- c(-0.16300,1.69300,1.84900,1.11200,1.57300,-1.50400,1.60000,-2.52800,1.72100,1.68400)
expect_equal(value$v[[3]][1:10,2], v, tolerance=1e-5)
 
## >> Data.Average_VelBeam3(1,1:10)
v <- c(-1.56000,1.41400,1.56300,1.55100,-0.32300,-1.27200,-2.11300,-1.28600,-2.36900,-2.38800)
expect_equal(value$v[[3]][1:10,3], v, tolerance=1e-5)
 
## >> Data.Average_VelBeam4(1,1:10)
v <- c(-0.079000,1.522000,1.587000,1.702000,1.674000,1.230000,2.855000,2.999000,2.913000,1.486000)
expect_equal(value$v[[3]][1:10,4], v, tolerance=1e-5)


res@metadata$header <- header
res@metadata$time <- time
res@metadata$id <- id
value$header <- NULL
value$time <- NULL
value$id <- NULL
res@data <- value

warning("FIXME: devise storage layout")
warning("FIXME: handle data checksum")
warning("FIXME: read configuration (bytes 3:4)")
warning("FIXME: test amplitude,correlation etc")
warning("FIXME: test cell size")
warning("FIXME: read more things from p49")
warning("Q: blanking=? matlab|doc error (RC)")
warning("Q: how many types can exist? (RC)")
warning("Q: are all 'versions' used? (RC)")

