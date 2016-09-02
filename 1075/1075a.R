## trial code
file <- "M39_5_phys_oce.tab.tsv"
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
message("FIXME: (1) decode units; (2) select conventional names; (3) store originalNames; (4) decode times")


