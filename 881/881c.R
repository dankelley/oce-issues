## Find lines with unexpected number of tabs
rm(list=ls())
library(oce)

files <- c("5145HawaiiQC.txt", "6401HawaiiQC.txt")
par(mfrow=c(length(files), 1), mar=c(3, 3, 1, 1), mgp=c(2, 0.7, 0))
for (file in files) {
    lines <- readLines(file, encoding="latin1", n=500)
    nlines <- length(lines)
    ntab <- unlist(lapply(1:nlines, function(i) sum(strsplit(lines[i], "")[[1]] == "\t")))
    plot(1:nlines, ntab, type='l')
    headerLength <- max(which(substr(lines, 1, 1) == '/'))
    cat("file", file, ", headerlength:", headerLength, sep="")
    oddLines <- which(ntab!=median(ntab))
    oddLines <- oddLines[oddLines > headerLength]
    cat(", oddLines: ", if(sum(oddLines)>0)
        paste(paste(oddLines, collapse=","), ", ...", sep="") else "NIL", "\n")
}

