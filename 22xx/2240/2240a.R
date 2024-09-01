file <- "units.csv"
unitTableDefault <- read.csv(file,
    header = FALSE,
    col.names = c("file", "oce", "scale")
)
print(unitTableDefault)
as.unitNEW <- function(u, unitTable, default = "copy") {
    # Try to handle odd spacings, like " m/s" and "m /s"
    # print(u)
    uorig <- u
    u <- trimws(u)
    u <- gsub("  ", " ", u)
    u <- gsub("\\s*/\\s*", "/", u)
    u <- gsub("\\s*-", "-", u)
    # print(u)
    w <- which(unitTable$file == u)
    if (length(w) > 1) {
        stop("multiple match: please report as an issue")
    }
    if (length(w) == 0) {
        if (identical(default, "copy")) {
            list(unit = uorig, scale = "")
        } else {
            default
        }
    } else {
        m <- unitTable[w, ]
        list(unit = parse(text = m$oce), scale = m$scale)
    }
}
as.unitNEW("m /s", unit = unitTableDefault)
as.unitNEW("m/s", unit = unitTableDefault)
as.unitNEW("m s-1", unit = unitTableDefault)
as.unitNEW("m s -1", unit = unitTableDefault)
as.unitNEW("foo bar", unit = unitTableDefault)
as.unitNEW("foo bar", unit = unitTableDefault, default = NULL)
