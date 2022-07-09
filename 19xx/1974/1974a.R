# Try to address failure of test_ctd_ssda.R on iso885915 encoding.
# https://github.com/dankelley/oce/issues/1974
# https://blog.r-project.org/2022/06/27/why-to-avoid-%5Cx-in-regular-expressions/index.html

options(warn=2)
filename <- system.file("extdata", "ctd_ssda.csv", package="oce")

if (FALSE) { # OS reports request to set locale to "iso885915" cannot be honored
    for (encoding in c("en_US.latin1", "en_US.UTF-8", "en_US.iso885915")) {
        cat("Encoding: ", encoding, "\n")
        Sys.setlocale("LC_ALL", encoding)
        l <- readLines(filename)
        try(cat("->", l[grep("^Line", l)], "\n"))
    }
}

cat("Method 1: as oce 1.7-8 -- file(...,encoding=...), readLines(...,encoding=...)\n")
for (e in c("latin1", "UTF-8", "en_US.iso885915")) {
    cat(e, "\n", sep="")
    file <- file(filename, "r", encoding=e)
    lines <- try(readLines(file, encoding=e))
    if (inherits(lines, "try-error")) cat("    -> readLines() FAILED\n")
    found <- try(grep("^Lines[ ]*:[ ]*[0-9]*$", lines))
    if (inherits(found, "try-error")) cat("    -> grep() FAILED\n")
    else cat("    -> found=", found, " (", lines[found], ")\n", sep="")
    close(file)
}


cat("Method 2: no file(); readLines(...,encoding=...)\n")
for (e in c("latin1", "UTF-8", "en_US.iso885915")) {
    cat(e, "\n", sep="")
    lines <- try(readLines(filename, encoding=e))
    if (inherits(lines, "try-error")) cat("    -> readLines() FAILED\n")
    found <- try(grep("^Lines[ ]*:[ ]*[0-9]*$", lines))
    if (inherits(found, "try-error")) cat("    -> grep() FAILED\n")
    else cat("    -> found=", found, " (", lines[found], ")\n", sep="")
}


