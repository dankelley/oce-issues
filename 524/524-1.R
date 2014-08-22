path <- "~/Dropbox/gsw_matlab_v3_04"
n <- 0
for (file in list.files(path, "*.m$")) {
    if (file == "gsw_ver.m")
        next
    lines <- readLines(paste(path, file, sep="/"), warn=FALSE)
    usage <- grep("USAGE", lines)
    if (length(usage)) {
        lines <- lines[usage:length(lines)]
        equals <- grep("=", lines)[1]
        if (length(equals)) {
            ## remove { and } ... not sure what they mean anyway
            line <- lines[equals]
            if (length(grep("\\.\\.\\.[ ]*$", line))) { # continued line
                line <- paste(gsub("\\.\\.\\.[ ]*$", "", line),
                              gsub("^%[ ]*", "", lines[equals+1]), sep="")
            }
            if (length(grep("\\(", line))) { # only do functions
                line <- gsub("\\{", "", gsub("\\}", "", line))
                cat("## ", file, "\n")
                cat("## ", line, "\n")
                tokens <- strsplit(line, "=")[[1]]
                lval <- gsub(" *$", "", gsub("^% *", "", tokens[1]))
                fname <- gsub("\\(.*$", "", gsub("^.*=[ ]*", "", tokens[2]))
                fname <- gsub("^ *", "", fname)
                args <- gsub("\\)$", "", gsub("^.*\\(", "", tokens[2]))
                args <- gsub("\\{|\\}", "", args)
                argList <- strsplit(args, ",")[[1]]
                narg <- length(argList)
                for (i in 1:narg)
                    argList[i] <- gsub("\\}", "", gsub("\\{", "", argList[i]))
                cat(fname, " <- function(", args, ")\n{\n", sep="")
                cat("    return(list(", sep='')
                lval <- gsub(" *$", "", gsub("^%[ ]*", "", tokens[1]))
                lval <- gsub("\\]", "", gsub("\\[", "", lval))
                retList <- strsplit(lval, ",")[[1]]
                nret <- length(retList)
                for (i in 1:nret) {
                    cat(retList[i])
                    cat(if(i<nret) "=NA," else "=NA)", sep='')
                }
                cat(")\n}\n\n", sep='')
            }
            n <- n + 1
        }
    }
}
cat("## Translated", n, "function skeletons from matlab to R\n")

