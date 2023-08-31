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
worst <- -1
wworst <- -1
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
        worst <- fdf[w]
        wworst <- tidedata$const$name[w]
    }
}
cat(wworst, " has worst fractional freq match (", worst, " or ", worst*86400, " sec per day)\n", sep="")

