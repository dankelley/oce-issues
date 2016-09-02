## trial code
file <- "M39_5_phys_oce.tab.tsv" # in this github repository
##file <- "Schneider-etal_2015.tab.tsv" # private file
lines <- readLines(file)
headerEnd <- grep("^\\*/$", lines)
if (!length(headerEnd))
    stop("cannot find header")
if (length(headerEnd) > 1)
    stop("cannot decode header")
headerEnd <- headerEnd[1]
header <- lines[seq.int(1L, headerEnd)]
print(header)
## FIXME: probably we want to reop
data <- read.delim(file, skip=headerEnd, sep="\t", header=TRUE)
print(head(data))
time <- as.POSIXct(data$Date.Time, tz="UTC")
data$time <- time
message("FIXME:")
message("(1) decode units")
message("(2) select conventional names")
message("(3) store originalNames")
message("(4) make ctdFindProfile work with these data (if it doesn't)")


