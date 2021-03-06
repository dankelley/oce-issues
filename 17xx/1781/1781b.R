library(oce)
library(argoFloats)
library(testthat)
source("~/git/oce/R/section.R")
if (!exists("d")) {
    i <- getIndex()
    si <- subset(i, ID=6901191)
    si <- subset(si, cycle=1:10)
    d <- readProfiles(getProfiles(si))
}
sec1 <- as.section(d[["argos"]], guessDepths=TRUE)
expect_true(is.finite(sec1[["station"]][[1]][["waterDepth"]]))
sec2 <- as.section(d[["argos"]], guessDepths=FALSE)
expect_true(is.null(sec2[["station"]][[1]][["waterDepth"]]))

## ERROR plot(sec1)#, drawBottom=TRUE)#, ylim=c(4000,0))

createSection <- function(argos)
{
    if (!inherits(argos, "argoFloats"))
        stop("First argument must be an argoFloats object")
    if (argos[["type"]] != "argos")
        stop("First argument must be an argoFloats object of type \"argos\"")
    oce::as.section(lapply(argos[["argos"]],
            function(a) {
                oceSetMetadata(as.ctd(a), "waterDepth", max(a[["pressure"]], na.rm=TRUE))
            }))
}

# Without taking care of flags (some salinities are 0, which messes up
# the S and sigmaTheta plots)
sec3 <- createSection(d)
plot(sec3)

sec4 <- createSection(applyQC(d))
plot(sec4)


