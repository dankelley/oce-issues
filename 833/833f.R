rm(list=ls())
library(oce)

DEBUG <- FALSE

## Read several nc files from the Dropbox

## http://www.argodatamgt.org/Media/Medias-Argo-Data-Management/Argo-documentation/General-documentation/Data-format/Obsolete-documents/Argo-user-s-manual-version-2.3-July-13th-2010
## sec 2.2.4, page 17 items stored for each profile are:
## <PARAM> <PARAM>_QC <PARAM>_ADJUSTED <PARAM>_ADJUSTED_QC <PARAM>_ADJUSTED_ERROR


library(ncdf4)
library(testthat)

path <- "~/Dropbox/oce-data/argo"
files <- list.files(path, "*.nc")

argoDataNames <- function(names)
{
    names <- gsub("CYCLE_NUMBER", "cycle", names)
    names <- gsub("TEMP_DOXY", "temperatureOxygen", names)
    names <- gsub("DOXY", "oxygen", names)
    names <- gsub("PRES", "pressure", names)
    names <- gsub("PSAL", "salinity", names)
    names <- gsub("TEMP", "temperature", names)
    names <- gsub("_ADJUSTED", "Adjusted", names)
    names <- gsub("_QC", "Qc", names)
    names <- gsub("_ERROR", "Error", names)
    names
}

for (file in files) {
    fullfile <- paste(path, file, sep="/")
    f <- try(nc_open(fullfile), silent=TRUE)
    if (inherits(f, "try-error"))
        stop("you need to have '6900388_prof.nc' here")
    cat(file, "\n")

    getData <- function(f, name)
    {
        res <- try(ncvar_get(f, name), silent=TRUE)
        if (inherits(res, "try-error")) {
            cat(f$filename, " has no variable named '", name, "'\n")
            res <- NULL
        }
        res
    }
    ## FIXME: what if different profiles have different data? This seems to be
    ## permitted, maybe.
    N <- gsub(" ", "", ncvar_get(f, "STATION_PARAMETERS"))
    if (DEBUG) {
        cat("    column sampling (unequal for 5904124_20160104211204622.nc)\n")
        cat("    row 1  '", paste(N[,1], collapse="', '"), "'\n")
        cat("    row 4  '", paste(N[,4], collapse="', '"), "'\n")
        cat("\n")
    }

    items <- unique(as.vector(ncvar_get(f, "STATION_PARAMETERS")))
    if (DEBUG) cat("    items: '", paste(items, collapse="', '"), "' originally\n")
    items <- gsub(" ", "", items)
    if (DEBUG) cat("    items: '", paste(items, collapse="', '"), "' after removing leading/trailing/interior blanks\n")
    ## 5904124_20160104211204622 has a blank-named item (how??)
    items <- items[nchar(items)>0]
    if (DEBUG) cat("    items: '", paste(items, collapse="', '"), "' after removing blank-named\n")
    variants <- 4
    res <- list()
    for (item in items) {
        ##cat("** item: '", item, "'\n", sep="")
        n <- item
        d <- getData(f, n)
        if (!is.null(d)) res[[n]] <- d
        n <- paste(item, "_QC", sep="")
        d <- getData(f, n)
        if (!is.null(d)) res[[n]] <- d
        n <- paste(item, "_ADJUSTED", sep="")
        d <- getData(f, n)
        if (!is.null(d)) res[[n]] <- d
        n <- paste(item, "_ADJUSTED_QC", sep="")
        d <- getData(f, n)
        if (!is.null(d)) res[[n]] <- d
        n <- paste(item, "_ADJUSTED_ERROR", sep="")
        d <- getData(f, n)
        if (!is.null(d)) res[[n]] <- d
    }
    ## str(res)
    resNames <- argoDataNames(names(res))
    names(res) <- resNames
    ## cat("    names(res): '", paste(names(res), collapse="', '", sep=""), "\n")
    ## cat("\n")

    ## compare res with the subset that read.argo() already handles
    d <- read.argo(fullfile)
    expect_equal(res$temperature, d[["temperature"]])
    expect_equal(res$pressure, d[["pressure"]])
    expect_equal(res$salinity, d[["salinity"]])
}
