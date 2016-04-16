library(oce)
source("~/src/oce/R/ctd.sbe.R")
for (file in list.files(pattern=".cnv")) {
    message(file)
    cmd <- paste("grep '# name'", file)
    f <- pipe(cmd)
    lines <- readLines(f, encoding="UTF-8")
    for (i in seq_along(lines)) {
        print(oceNameFromSBE(lines[i]))
    }
}
