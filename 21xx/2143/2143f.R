options(digits=15)
library(oce)
# The const.txt file was created by copying from the website for Hawaii, viz.
# <https:tidesandcurrents.noaa.gov/harcon.html?id=1612340>. The column names are
# 'Constituent..', 'Name', 'Amplitude', 'Phase', 'Speed', and 'Description'.
const <- read.delim("const.txt", sep="\t", header=TRUE)
const$Freq <- const$Speed/360
data(tidedata)
known <- sapply(const$Name, \(n) n %in% tidedata$const$name)
unknownNames <- const[!known, ]$Name

df <- function(a, b) # fractional difference
    (a-b)/(0.5*(a+b))

n <- length(const$Name)
nameworst <- ""
wworst <- -1
eps <- NULL
worst <- -1
for (name in const$Name) {
    fdf <- abs(df(tidedata$const$freq, const$Freq[const$Name==name]))
    w <- which.min(fdf)
    if (name %in% unknownNames) {
        cat("NOAA \"", name, "\" maps to oce \"",
            tidedata$const$name[w], "\"",
            " (", tidedata$const$freq[w], "; ", const$Freq[const$Name==name], "; ",
            fdf[w], ")\n", sep="")
    } else {
        cat("  NOAA \"", name, "\" matches oce \"",
            name, "\"",
            " (", tidedata$const$freq[w], "; ", const$Freq[const$Name==name], "; ",
            fdf[w], ")\n", sep="")
    }
    if (fdf[w] > worst) {
        nameworst <- name
        wworst <- w
        worst <- fdf[w]
    }
    eps <- c(eps, fdf[w])
}
cat(tidedata$const$name[wworst], " has worst fractional freq match (", worst, " or ", worst*86400, " sec per day)\n", sep="")
df <- data.frame(name=const$Name, eps=eps)
if (!interactive())
    png("f.png")
boxplot(log10(df$eps), ylab="log10(fractional frequency mismatch)", notch=TRUE)
text(1, log10(worst), tidedata$const$name[wworst], pos=4)
mtext("Tidal frequency mismatch between oce and NOAA", line=1)
if (!interactive())
    dev.off()
