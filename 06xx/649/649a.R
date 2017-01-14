## Try reading ODF "adcp" manually.
library(oce)

file <- "MADCPS_hud2013021_1842_3380-69_3600.ODF"
lines <- readLines(file, encoding="UTF-8") # need encoding for French accents
headerEnd <- grep("--[ ]*DATA[ ]*--", lines)
if (1 != length(headerEnd))
    stop("problem finding end of header")

## KLUDGE: should read the column names, missing values, etc, from the header.
data <- read.table(text=lines, skip=headerEnd, header=FALSE, 
                   col.names=c("u", "v", "w", "error", "counts", "percent", "time"))
data$time <-strptime(data$time, "%d-%b-%Y %H:%M:%S", tz="UTC")
missing <- -1000000
data$u[data$u==missing] <- NA
data$v[data$v==missing] <- NA
data$w[data$w==missing] <- NA

if (!interactive()) png("649a.png")
par(mfrow=c(3,1))
oce.plot.ts(data$time, data$u)
n <- length(data$u)
mtext(sprintf("%.1f percent are NA", 100*(1-sum(is.na(data$u))/n)),
      side=3, line=0, adj=1)
oce.plot.ts(data$time, data$v)
mtext(sprintf("%.1f percent are NA", 100*(1-sum(is.na(data$v))/n)),
      side=3, line=0, adj=1)
oce.plot.ts(data$time, data$w)
mtext(sprintf("%.1f percent are NA", 100*(1-sum(is.na(data$w))/n)),
      side=3, line=0, adj=1)
if (!interactive()) dev.off()
