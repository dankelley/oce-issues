library(oce)
## source("~/src/oce/R/ctd.sbe.R")
for (file in list.files(pattern=".cnv")) {
    message(file)
    #cmd <- paste("grep '^# name [0-9]+ ='", file)
    cmd <- paste("grep '^# name [0-9][0-9]* = \\(.*\\):.*$'", file)
    f <- pipe(cmd)
    lines <- readLines(f, encoding="UTF-8")
    for (i in seq_along(lines)) {
        print(cnvName2oceName(lines[i]))
    }
    close(f)
}
