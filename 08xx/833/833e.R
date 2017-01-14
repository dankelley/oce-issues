rm(list=ls())

## Read several nc files from the Dropbox

## http://www.argodatamgt.org/Media/Medias-Argo-Data-Management/Argo-documentation/General-documentation/Data-format/Obsolete-documents/Argo-user-s-manual-version-2.3-July-13th-2010
## sec 2.2.4, page 17 items stored for each profile are:
## <PARAM> <PARAM>_QC <PARAM>_ADJUSTED <PARAM>_ADJUSTED_QC <PARAM>_ADJUSTED_ERROR


library(ncdf4)

path <- "~/Dropbox/oce-data/argo"
files <- list.files(path, "*.nc")[1]

argoDataNames <- function(names)
{
    names <- gsub("CYCLE_NUMBER", "cycle", names)
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
    f <- try(nc_open(paste(path, file, sep="/")), silent=TRUE)
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
    cat("    column sampling (unequal for 5904124_20160104211204622.nc)\n")
    cat("    row 1  '", paste(N[,1], collapse="', '"), "'\n")
    cat("    row 4  '", paste(N[,4], collapse="', '"), "'\n")
    cat("\n")

    items <- unique(as.vector(ncvar_get(f, "STATION_PARAMETERS")))
    cat("    items: '", paste(items, collapse="', '"), "' originally\n")
    items <- gsub(" ", "", items)
    cat("    items: '", paste(items, collapse="', '"), "' after removing leading/trailing/interior blanks\n")
    ## 5904124_20160104211204622 has a blank-named item (how??)
    items <- items[nchar(items)>0]
    cat("    items: '", paste(items, collapse="', '"), "' after removing blank-named\n")
    variants <- 4
    res <- list()
    for (item in items) {
        ##cat("** item: '", item, "'\n", sep="")
        d <- getData(f, item)
        if (!is.null(d)) res[[item]] <- d
        d <- getData(f, paste(item, "_QC", sep=""))
        if (!is.null(d)) res[[paste(item, "_QC", sep="")]] <- d
        d <- getData(f, paste(item, "_ADJUSTED", sep=""))
        if (!is.null(d)) res[[paste(item, "_ADJUSTED", sep="")]] <- d
        d <- getData(f, paste(item, "_ADJUSTED_QC", sep=""))
        if (!is.null(d)) res[[paste(item, "_ADJUSTED_QC", sep="")]] <- d
        d <- getData(f, paste(item, "_ADJUSTED_ERROR", sep=""))
        if (!is.null(d)) res[[paste(item, "_ADJUSTED_ERROR", sep="")]] <- d
    }
    ## str(res)
    resNames <- argoDataNames(names(res))
    names(res) <- resNames
    cat("    names(res): '", paste(names(res), collapse="', '", sep=""), "\n")
    cat("\n")
    cat("below are names of f$var[i]:\n")
    for (i in 1:f$nvar) cat("    ", names(f$var[i]), "\n")
    cat("below is percentage of TEMP_DOXY data that are NA:\n")
    cat(sprintf("    %.2f\n", 100*sum(is.na(ncvar_get(f, "TEMP_DOXY")))/length(ncvar_get(f,"TEMP_DOXY"))))
}
