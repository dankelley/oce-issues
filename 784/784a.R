library(oce)
read.owhl <- function(file, tz="UTC")
{
    filename <- ""
    if (is.character(file)) {
        filename <- fullFilename(file)
        file <- file(file, "r")
        on.exit(close(file))
    }
    if (!inherits(file, "connection"))
        stop("argument `file' must be a character string or connection")
    if (!isOpen(file)) {
        open(file, "r")
        on.exit(close(file))
    }
    res <- new("oce")
    nheader <- 2 # FIXME: are there docs telling us how header works?
    header <- readLines(file, n=nheader)
    namesInHeader <- strsplit(header[nheader], ",")[[1]]
    names <- namesInHeader
    units <- list()
    dataNamesOriginal <- as.list(namesInHeader)
    names(dataNamesOriginal) <- namesInHeader
    ## The upcoming code is brittle because I don't know whether
    ## the column names are fixed in this file format.  All I know is
    ## that a sample file has as below:
    ##     POSIXt,DateTime,frac.seconds,Pressure.mbar,TempC
    if ("TempC" %in% namesInHeader) {
        names[names=="TempC"] <- "temperature"
        units$temperature <- list(unit=expression(degree*C), scale="ITS-90") # assumption on scale
        dataNamesOriginal$temperature <- "TempC"
    }
    if ("Pressure.mbar" %in% namesInHeader) {
        names[names=="Pressure.mbar"] <- "pressure"
        units$pressure <- list(unit=expression(dbar), scale="") # will use dbar, not the mbar in the file
        dataNamesOriginal$pressure <- "Pressure.mbar"
    }

    pushBack(header, file)
    data <- read.csv(file, skip=nheader, header=FALSE, col.names=names, stringsAsFactors=FALSE)
    data <- as.list(data) # preferred in oce
    ## I am not sure what 'frac.seconds' means, e.g. does "25" mean 0.25s? I'm guessing that
    time <- numberAsPOSIXct(data$POSIXt, tz=tz) + data$frac.seconds / 100
    data$time <- time
    if ("pressure" %in% names(data)) {
        data$pressure <- data$pressure / 10
        warning("converted pressure to dbar because that is the oceanographic convention")
    }
    dataNamesOriginal$time <- "-"
    res@metadata$filename <- filename
    res@metadata$header <- header
    res@metadata$dataNamesOriginal <- dataNamesOriginal
    res@metadata$units <- units
    res@data <- data
    res@processingLog <- processingLogAppend(res@processingLog,
                                             paste("read.owhl(\"",filename, "\")", sep=""))
    res
}
d <- read.owhl("~/git/testing_OWHL/sample_data/15032600_halfday.CSV")
summary(d)
if (!interactive()) png("784a.png")
par(mfrow=c(2,2), mar=c(3, 3, 2, 1), mgp=c(2, 0.7, 0))
oce.plot.ts(d[["time"]], d[["pressure"]], ylab="Pressure [dbar]")
## Chop out the descent phase; time determined by locator()
dd <- subset(d, time>1427371658)
t <- dd[["time"]]
p <- dd[["pressure"]]
oce.plot.ts(t, p, ylab="Pressure [dbar]")
## low-pass to prewhiten spectrum; lp=lowpass; hp=highpass
plp <- predict(smooth.spline(t, p, df=10)) 
lines(plp$x, plp$y, col='red', lwd=3)
php <- p - plp$y
phpts <- ts(php, deltat=diff(as.numeric(t[1:2])))

par(mar=c(3.5, 3.5, 2, 1), mgp=c(2, 0.7, 0))

s <- spectrum(phpts, spans=c(31,11,5), plot=FALSE)
plot(s$freq, s$spec, type='l', xlab="Frequency [Hz]", ylab="Power [dbar^2/Hz]")
## plot(log10(s$freq), (s$spec), type='l', xlab="log10 Frequency", ylab="log10 Power")

## Variance conserving plot with log(freq). Crude period
## axis on bottom of plot.



plot(log10(s$freq), s$spec*s$freq, type='l',
     xlim=c(-1.5,-0.6), xlab="Frequency [Hz]", ylab=expression("Freq*Power [dbar^2]"), axes=FALSE)
xaxp <- par("xaxp")
l <- seq(xaxp[1], xaxp[2], length.out=xaxp[3]+1)
axis(side=2)
axis(1)
period <- c(5, 10, 15, 20, 25)
rug(log10(1/period), side=3, tick=-0.02, lwd=1)
rug(log10(1/(1:100)), side=3, tick=-0.01, lwd=1)
mtext(period, side=3, line=0.7, at=log10(1/period), cex=par('cex'))
mtext("Period [s]", side=3, line=2)
box()

if (!interactive()) dev.off()

