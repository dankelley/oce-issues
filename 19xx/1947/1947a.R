library(oce)
source("~/git/oce/R/ctd.sbe.R")
options(warn=1)

# wrapper
read.ctd.sbe.wrapper <- function(cnv)
{
    lines <- readLines(cnv)
    # Add a sequence of lines like below, as needed
    lines <- gsub("^\\*\\* Date: (.*)-(.*)-(.*)", "** Date: \\3-\\1-\\2", lines)
    read.ctd.sbe(textConnection(lines))
}

cat("# without wrapper\n")
for (file in list.files(pattern=".cnv")) {
    cat("FILE ..._", gsub(".*_", "", file), "\n")
    d <- read.ctd.sbe(file)
    stop()
    cat("   d[[\"date\"]]=", format(d[["date"]]), "\n", sep="")
    cat("   first entry in time column: ", format(d[["time"]][1]), "\n\n\n", sep="")
}

cat("# with wrapper\n")
for (file in list.files(pattern=".cnv")) {
    cat("FILE ..._", gsub(".*_", "", file), "\n")
    d <- read.ctd.sbe.wrapper(file)
    cat("   d[[\"date\"]]=", format(d[["date"]]), "\n", sep="")
    cat("   first entry in time column: ", format(d[["time"]][1]), "\n\n\n", sep="")
}


