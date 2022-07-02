rm(list=ls())

library(oce)
debug <- 0

#' Try to retrieved a named item from the data buffer.
#'
#' This checks external variable `haveItem` to see whether the data item
#' indicated by `name` is available in external raw vector `buf`.  If so, the
#' item is retrieved from the starting at position indicated by external
#' variable `i0`, and `i0` is then increased to prepare for the next call to
#' this function.
#'
#' @param object a list containing what is known so far. A possibly-modified
#' value of this is returned.
#'
#' @param name character value naming the item.
#'
#' @return a list defined by adding the named item to `object`, if it
#' is present in the dataset.
#'
#' @author Dan Kelley
getItemFromBuf <- function(object, name, debug=getOption("oceDebug"))
{
    if (haveItem[[name]]) {
        if (name == "v") {
            n <- 4L
            value <- readBin(buf[i0+seq(1L, 4*n)], "int", n=n, size=4, endian="little")
            #message("v from buf[", paste(i0+seq(1L,n), collapse=","), "]")
            #print(value)
            object[[name]] <- value
            i0  <<- i0 + 4 * n
        } else if (name == "a") {
            n <- 2L
            value <- readBin(buf[i0+seq(1L, n)], "raw", n=n, size=1L)
            #message("a from buf[", paste(i0+seq(1L,n), collapse=","), "]")
            #message("a is ", paste(value, collapse=" "), "\n")
            object[[name]] <- value
            i0  <<- i0 + n
        } else if (name == "q") {
            n <- 3L
            value <- readBin(buf[i0+seq(1L, n)], "raw", n=n, size=1L)
            #message("q from buf[", paste(i0+seq(1L,n), collapse=","), "]")
            #print(value)
            object[[name]] <- value
            i0  <<- i0 + n
        } else {
            stop("unknown item, name=\"", name, "\"")
        }
        oceDebug(debug, name, "=", value, "; set new i0=", i0, "\n")
    } else {
        oceDebug(debug, name, " not found; retaining old i0=", i0, "\n")
    }
    object
}


# 1. Create fake dataset (with different lengths for each).
con <- file("dan", "wb")
v <- 1:4                               # 4 items, 16 bytes
a <- as.raw(10:11)                     # 2 items, 2 bytes
q <- as.raw(20:22)                     # 3 items, 3 bytes
writeBin(v, con, endian="little")
writeBin(a, con, endian="little")
writeBin(q, con, endian="little")
close(con)

# 2. Try the method
con <- file("dan", "rb")
buf <- readBin(con, "raw", n=file.info("dan")$size)
close(con)
haveItem <- list(v=TRUE, a=TRUE, q=TRUE, echosounder=FALSE)
i0 <- 0
DAN <- list()

DAN <- getItemFromBuf(DAN, "v", debug=debug)
DAN <- getItemFromBuf(DAN, "a", debug=debug)
DAN <- getItemFromBuf(DAN, "q", debug=debug)
DAN <- getItemFromBuf(DAN, "echosounder", debug=debug)

stopifnot(DAN$v == v)
stopifnot(DAN$a == a)
stopifnot(DAN$q == q)
print(DAN)
